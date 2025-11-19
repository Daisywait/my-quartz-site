**MAE (Masked Autoencoder)**
- 架构：**Encoder + Decoder**，Encoder 是 Transformer
- 自监督方法：随机遮盖图像大块 patch，让模型预测被遮盖部分
- 学到的就是**图像的潜在表征**