## 第一遍
标题：ANYTOUCH: LEARNING UNIFIED STATIC-DYNAMIC  REPRESENTATION ACROSS MULTIPLE VISUO-TACTILE  SENSORS
    多视觉 - 触觉传感器学习统一的静态 - 动态表征
摘要：
	为了让机器人像人一样精准操控和感知物品，有许多触觉-视觉传感器被集成到机器人身上，但是由于诸多传感器之间并无统一的标准，它们各自拥有独特的特征表示，这个成为了本论文试图解决的问题，即实现一个统一视觉-触觉传感器的表征，（也可以叫跨传感器表征学习）这个表征还被提议要同时具有动态和静态的特点，为了此研究，作者团队还构建了TacQuad数据集（同一个物体、同一个接触、不同传感器的数据），提出了一个any touch框架即论文标题
结论：结论很简短，就是总结了一番论文中的主要两块内容，一就是TacQuad数据集，二是any touch框架。
## 第二遍
#### 阅读步骤：
第二遍里面我们就要对整个文章完整过一遍，然后知道每一块到底在干什么东西，我们可以沿着从标题一直往下读到最后，但是这个时候
也不需要注意太多的细节，以及一些公式的证明等等。
关注的地方
第二遍阅读的时候，最重要是搞明白那些重要的*图和表*，都要知道他每一个字在干什么事情
作者提出的方法和别人提出的方法是怎么进行对比的？之间差距有多大？这个时候可能你还没有特别搞懂他在干什么。但是不要紧，你可以将*不懂的地方标记下来，留到之后第三遍进行阅读*
达到的效果
第二遍阅读完之后，*你就对整个论文的各个部分，都有一个大概的了解*，中间可以把作者引用的别人的相关文献圈出来，比如作者是在某某某的方法上进行了*改进*，做了哪些改进之类的。
#### 1.intro:
###### 背景
第一段也是简单介绍了一下背景，然后指出
>This variability poses challenges to building precise robotic tactile systems, as sensor-specific data collection (Yang et al., 2022; Gao et al., 2023) and model training limit the data scale and diversity for the model of a single sensor and lead to suboptimal perception capabilities

传感器的多种多样和差异化的特征数据让机器人触觉系统的构建增加了挑战，因为若要是针对单个传感器进行数据的收集会面临以下问题：
- 成本高（每换一种传感器都得重新采集和标注）；
- 数据量有限；
- 无法覆盖多种材质、形态和环境。
导致感知能力欠佳。
###### 之前的研究
1.2024[[T3]]提出用“tokenization（符号化）”机制，把不同传感器的原始触觉信号转换成一种**统一的“触觉语言”**。属于“sample-level alignment”（样本级对齐）
- **是对齐的，但有限**：它只有少量样本在多个传感器之间是配对的（同一物体、同一接触条件），数量级远远不够覆盖所有物体、材质和动作。
- **覆盖的模态少**：主要是 GelSight、VisGel 等光学触觉或部分压力阵列传感器。
- **对齐方式偏样本级**：每一对样本明确对应，但没有大规模、多样化、多传感器的数据覆盖。
>改进：本研究引进了动态的表征，提供了TacQuad多模态对齐的数据集，且属于语义层面的对齐

考虑到数据集的问题：
2.2024提出双传感器对齐，罗德里格斯等人（2024 年）收集了一个双传感器配对数据集，以实现跨传感器生成。然而，他们对特定操作任务的关注限制了传感器和所收集物体的多样性。此外，他们忽视了配对的多模态数据在提高传感器可转移性和实现全面触觉感知方面的潜在益处。
- 他们尝试收集了**配对数据**：同一个物体在**两种传感器**下的触觉信号。
- 目的是让模型能做**跨传感器生成**（cross-sensor generation），即用一种传感器的数据预测另一种传感器的信号
局限：
- **操作任务有限**：他们只关注特定的触摸或操作类型，比如抓握、滑动等。
- **传感器和物体种类少**：数据集覆盖的触觉传感器类型和物体材质不多，导致训练的模型**泛化性受限**。

###### 本研究
数据集：TacQuad——an aligned multi-modal multisensor tactile dataset 对齐的多模态多传感器触觉数据集
- 多样性：①72,606 contact frames；②four different visuo-tactile sensors（publicly available sensors, self-made sensors, and force field sensors）
- 降低收集成本：在校准平台上进行细粒度时空对齐的数据收集，更大规模的粗粒度空间对齐数据通过手持设备进行收集。
- 每个采集物标注触觉属性描述，从而构建一个全面的触觉 - 视觉 - 语言数据集。


表征模型如何构建：
>我们认识到，人类的触觉感知是静态和动态过程的结合，因为人类会从纹理、滑动和压力变化等多种类型的信息中获得全面的触觉感知。——动态和静态

Any touch:a unified staticdynamic multi-sensor tactile representation learning framework.
- 输入有图片也有视频，即包含静态和动态
- 多层次的架构：以全面增强模型捕捉像素级触觉细节（像素级）和与传感器无关特征（语义级）的能力。
- 掩码建模：以学习细粒度的像素级细节
- 多模态对齐和一项新颖的跨传感器匹配任务，以理解不同传感器下物体的语义级触觉属性，并提取与传感器无关的特征。
- 减小传感器之间的差异：通过让多种传感器表征共享同一个空间然后再根据它们自己代表的物品的触觉信息
- 多传感器之间的知识迁移：token 替换
	跨传感器泛化策略：token 替换（在训练时，每个传感器的数据通常会有一个专门的标识符 token，告诉模型“这是哪种传感器的数据”。
	策略：随机把这些特定 token 替换成统一的通用 token（universal sensor token）。
	作用：
	模型不能只依赖特定传感器的标识
	被迫学习 与传感器无关的触觉特征）
- 实验和表现：
	- **多数据集验证**：在不同触觉数据集上测试 AnyTouch 的跨传感器能力和泛化能力。
	- **真实实验**：做了 **细粒度倒水（fine-grained pouring）实验**，测试模型在现实操作中的感知能力。
	- 实验结果表明：AnyTouch 能同时捕捉静态和动态触觉信息，并能在不同传感器间迁移。

#### 2.Related work
###### 2.1跨领域学习
举了两个在此领域的两个方法：①对比学习，多语言（multi-source language）训练中，通过让语义相同的句子（比如英文和中文的同义句）在表示空间靠近，而语义不同的句子远离。②循环一致性：在风格迁移（比如把马变成斑马）中，输入一张图像到另一个域再转回来，要求得到的图像和原始图像一致。- 即：`A → B → A`，希望重建出来的 `A' ≈ A`。
之前的研究：
- multi-sensor joint training：让不同传感器（如触觉A、触觉B、触觉C）**在同一个模型里一起训练**，共享部分网络参数，从而学到通用表征。
- multi-modal alignment：对齐**不同模态之间的语义空间**，例如视觉和触觉、触觉和语言，让它们在同一个嵌入空间中可以互相理解。
- cross-sensor generation：让模型从一种传感器的数据**生成另一种传感器的数据**。
>存在的问题：overlook the benefits of jointly utilizing multi-modal data and aligned multi-sensor data to bridge the sensor gap.

###### 2.2视触觉传感器的应用
被用于机器人的灵巧操作比如密集堆积、抓取、插入操作；与其他传感器协作，实现*动态*整合，比如pouring操作，还有peg insertion with keyway（带方向约束的插销动作，类似于插U盘）；也有静态的：比如材料分类和形状重建
>存在的问题：However, due to the low standardization of visual-tactile sensors, these methods fail to leverage larger and more diverse data from other sensors and lack sensor transferability
###### 2.3表征学习
定义：
	- **将原始复杂数据映射到一个有意义的向量空间；**
	-  **让相似的输入（比如两种橡胶材质）在空间中靠近；**
	- **不同的输入（比如金属 vs 布料）在空间中远离。**
举例：
背景：表征学习（自监督方法如 [[BERT]]/[[MAE]]）在视觉、语言和其他模态上取得成功，如今正扩展到多模态领域，触觉也可以通过图像化处理（通过视触觉传感器），用类似视觉的方法进行表征学习，从而提升触觉模型在多任务、多传感器环境下的表现。
>存在的问题：However, these efforts have not explored how to obtain a unified visuo-tactile representation suitable for various tasks.

#### 3.TacQuad数据集
###### 3.1以前的研究：
罗德里格斯等人（2024 年）进行了初步尝试来解决这个问题，他们收集了一个包含 32256 对触觉图像的数据集，这些图像来自两个传感器，用于特定操作任务，但涉及的物体种类有限。该研究*没有考虑材料和硬度等触觉属性*，也*忽视了通过多模态信息增强跨传感器迁移能力*的潜力。
###### 如何解决：
提供多传感器对齐的数据，其中包含文本和图像，明确使模型能够学习*语义级别的触觉属性*(GPT-4o）和与传感器无关的特征（将原本的token替换成通用的），从而通过数据驱动的方法形成一个统一的多传感器表示空间。
###### 3.2数据收集：
前三个传感器用于收集触觉图像，而 Tac3D 用于捕捉变形力场。考虑成本问题但为了在更大规模上收集数据，同时确保尽可能多的数据配对，采用粗细两种方法来收集对齐数据
![[Pasted image 20251112101355.png]]
1.Fine-grained Spatio-temporal Aligned(
精细时空对齐)：
- 按压**一个玻璃罐**的顶部中心，该罐子表面坚硬、光滑、透明且具有一系列纹理。
- 有校准平台
- 四种传感器以相同的速度按压同一物体的相同位置。
- 25个物体，30次触摸 (Touches)，17,524帧。
2.Coarse-grained Spatial Aligned (粗粒度空间对齐）：
- 按压**一个粗糙的橙子**的顶部中心。接触点相对坚硬，有粗糙度和轻微的弹性。
- 手动采集
- 四种传感器按压同一物体上的**相同位置**，但**不保证时间上的同步对齐**。它包含了**室内和室外**场景。
- 99个物体，151次触摸 (Touches)，55,082帧。
3.数据分类：
- **Hard（硬）：** 塑料、金属、石头、玻璃等。
- **Soft（软）：** 织物、纸张、海绵等。
- **Food（食物）：** 蔬菜、水果等。

4.Cross-sensor Generation：跨传感器生成是指**利用一种传感器采集到的数据，来预测或合成（生成）另一种传感器在同一接触事件中本应采集到的数据**
5.Cross-sensor Matching：跨传感器匹配是指**确定来自不同传感器的数据是否描述了（或对应于）** **相同的** **物理触摸事件或物体。**
#### 4.Any Touch
![[Pasted image 20251112104431.png]]
围绕着这张图来展开：
###### 4.1整合图片和视频输入：
we consider tactile images as single-frame static videos to unify tactile images and videos
![[Pasted image 20251113093712.png]]
![[Pasted image 20251113093727.png]]
![[Pasted image 20251113093800.png]]
今天要补一下[[Transformer]]
###### 4.2pixel-Level
[[Masked Modeling 自监督学习思想]]


