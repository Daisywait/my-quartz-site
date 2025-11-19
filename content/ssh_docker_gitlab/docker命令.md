`docker stop gitlab`
`docker rm gitlab`
常看共享内存：`docker exec gitlab df -h /dev/shm`
1. **删除容器** `1bf2cdab1f0e`（它使用了你要删除的镜像）
2. **然后才能删除镜像** `7d79b4fee201`
进入容器内部
`docker exec -it gitlab bash`
删除镜像：docker rmi <ID>

`nvidia-smi`查看


你可以用这个命令查看所有容器，包括正在运行的和停止的：

`docker ps -a`

- `docker ps` 默认只显示正在运行的容器。
    
- `-a` 会显示所有容器（包括停止的）。
    

从输出里，你可以看到容器的 **CONTAINER ID**、**NAMES** 和状态。

如果你想启动一个现有容器，可以用：

`docker start <容器名或ID>`

比如你之前的 GitLab 容器名是 `gitlab`，就运行：

`docker start gitlab`

然后可以用 `docker logs -f gitlab` 查看启动日志，看是否正常启动并监听端口。

检查在跑的容器：docker ps
