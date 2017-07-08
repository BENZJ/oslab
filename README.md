# Operating system learning
This repository is used to record my operating system's daily code,refering to the souce code of Linux0.11
## tool
1. bochs

## 环境安装
1. 下载docker ubuntu nvc 仓库
https://github.com/fcwu/docker-ubuntu-vnc-desktop

2. 修改其中的Dockerfil文件内容
Dockerfile文件在当前文件夹下

3. 编译创建docker镜像
```bash
docker build .
```

4. 创建容器
```bash
docker run -it -p 6080:80 --name oslab ...
```
...是你的镜像uuid

5. 进入图形化的界面
在浏览器中输入127.0.0.1:6080就能登陆进入
