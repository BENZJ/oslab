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