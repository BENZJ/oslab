# 2017.7.2学习记录
## 计划
1. 学习启动的框架，简单的512字节的启动模块
2. bochs的启动和调试

## 知识点
### 寻址方式
1. 直接寻址
```bash
!跳转到bx值所在的位置处
mov bx,ax
mov bx
```
2. 间接寻址
```bash
mov [bx],ax
mov [bx]
```

## 实验结果
![](http://oowki3u7j.bkt.clouddn.com/oslab2017.7.2result.png)
## 操作过程
### 生成软盘
```bash
#编译
as86 -0 -a -o boot.o boot.s
#链接
ld86 -0 -s -o boot boot.o

#生成启动软盘
dd bs=32 if=boot of=/dev/fd0 skip=1
```
### 编写bochsrc文件
bochsrc在本目录下代码如下
```
romimage : file = $BXSHARE/BIOS-bochs-latest
vgaromimage : file = $BXSHARE/VGABIOS-lgpl-latest
megs : 16
floppya: 1_44="/dev/fd0", status=inserted
boot: floppy

```

### bochs调试的方法
#### 设置断点
```bash
vb 0x0:0x7c00 在内存0x7c00处设置断点
```
![](http://oowki3u7j.bkt.clouddn.com/oslab2017.7.2break.png)
#### 查看各个寄存器
```bash
r
```
![rcmd](http://oowki3u7j.bkt.clouddn.com/oslab2017.7.2rcmd.png)
#### 查看断点
```bash
info b
```

#### 运行到断点
```bash
c
```

#### 单步调试
```bash
s
```
#### 查看反汇编指令
```bash
u ／10
```
![](http://oowki3u7j.bkt.clouddn.com/oslab2017.7.2.ucmd.png)

#### 查看内存内容
```bash
x /512bc 0x0:0x7c00
x /512bx 0x0:0x7c00
```
![](http://oowki3u7j.bkt.clouddn.com/oslab2017.7.2.xcmd.png)

### boch调试过程

## 参考文章
http://blog.csdn.net/liu0808/article/details/53099099
