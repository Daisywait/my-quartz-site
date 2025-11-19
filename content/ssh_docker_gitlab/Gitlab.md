GitLab 实例的核心配置文件为 `/etc/gitlab/gitlab.rb`
检查是不是git仓库git status

gitlab-rails console

修改分支名称
git branch -M main


要“查看 GitLab 初始密码”，有且只有一条命令，必须在 **容器内部** 执行。

你进入容器之后（`docker exec -it gitlab bash`），在里面运行：

`cat /etc/gitlab/initial_root_password`


