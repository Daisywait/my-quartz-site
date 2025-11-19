## 完整操作流程（本地 → GitLab）

bash

```
# 1. 进入项目目录并初始化 Git 仓库
cd /path/to/your/project
git init
```

> .git 目录创建成功，表示初始化完成。

---

bash

```
# 2. （可选）创建 .gitignore 文件，忽略不需要版本控制的文件
cat > .gitignore << EOF
# 依赖
node_modules/
venv/
__pycache__/
*.pyc

# 构建输出
dist/
build/
target/

# 环境变量
.env
.env.local

# IDE/编辑器
.idea/
.vscode/
*.swp
*.swo

# 日志
*.log
EOF
```

---

bash

```
# 3. 添加所有文件到暂存区
git add .

# 4. 提交初始 commit
git commit -m "Initial commit"
```

> 如果是空项目，Git 可能拒绝空提交，可先创建一个 README.md：
> 
> bash
> 
> ```
> echo "# yourproject" > README.md
> git add README.md
> git commit -m "Initial commit"
> ```

---

## 连接远程 GitLab 仓库

### 方式一：使用 SSH（推荐，免密码）

bash

```
# 5. 添加远程仓库（origin）
git remote add origin git@172.31.179.162:yourusername/yourproject.git
```

> 注意：
> 
> - 172.31.179.162 是你的 GitLab 服务器内网 IP
> - yourusername/yourproject.git 是命名空间 + 项目名
> - 项目必须**已存在于 GitLab**（你有权限）

---

### 方式二：使用 HTTPS（需要输入用户名/密码或 PAT）

bash

```
git remote add origin https://172.31.179.162/yourusername/yourproject.git
```

> 推送时会提示输入 **用户名 + Personal Access Token（PAT）**

---

### 查看/删除/重新设置 origin

bash

```
# 查看当前远程
git remote -v

# 删除旧的 origin
git remote remove origin

# 重新添加
git remote add origin git@172.31.179.162:yourusername/yourproject.git
```

---

## 配置层级说明（补充你提到的）

|层级|命令|作用范围|配置文件位置|
|---|---|---|---|
|--local|git config --local|当前仓库|.git/config|
|--global|git config --global|当前用户所有仓库|~/.gitconfig|
|--system|git config --system|整个系统所有用户|/etc/gitconfig|

bash

```
# 查看三层配置
git config --local --list
git config --global --list
git config --system --list
```

> 优先级：local > global > system

---

## 推送代码到 GitLab

bash

```
# 6. 推送主分支（首次推送需设置上游）
git push -u origin main
```

> 如果你的默认分支是 master：
> 
> bash
> 
> ```
> git push -u origin master
> ```

---

### 强制推送（谨慎！会覆盖远程）

bash

```
git push -f origin main
```

> 仅用于：
> 
> - 修复历史
> - 重新初始化远程仓库
> - 多人协作时可能导致他人丢失提交

---

## 常见问题与解决方案

|问题|原因|解决方法|
|---|---|---|
|Permission denied (publickey)|SSH 密钥未配置|见下方 SSH 配置|
|remote: You are not allowed to push code|无推送权限|在 GitLab 项目中授予 **Developer/Maintainer** 权限|
|failed to push some refs|远程有你本地没有的提交|git pull --rebase origin main 后再推|
|Repository not found|URL 错误或项目不存在|检查 URL 和项目路径|

---

## 配置 SSH 密钥（首次使用必须）

bash

```
# 1. 生成 SSH 密钥（默认路径 ~/.ssh/id_rsa）
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# 2. 查看公钥
cat ~/.ssh/id_rsa.pub

# 3. 复制公钥 → 粘贴到 GitLab: 用户设置 → SSH Keys
```

bash

```
# 4. 测试连接
ssh -T git@172.31.179.162
# 成功会显示：Welcome to GitLab, @yourusername!
```

---

## 验证最终状态

bash

```
git remote -v
git branch -M main    # 如需重命名分支
git push -u origin main
```