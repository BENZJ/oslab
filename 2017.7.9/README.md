# 2017.7.9学习记录

## 计划
1. linux0.00的调试和运行

## 说明
linux0.00 代码的下载地址为[下载](http://oldlinux.org/Linux.old/bochs/linux-0.00-041217.zip)
## boot.s与head.s代码风格的却别
大家可能发现boot.s和head.s的代码有一点点不一样，这是因为boot.s使用的是as86汇编器
而head.s使用的是GNU as汇编器，具体表现在
1. movl等操作的出现：当然还是mov的意思，l表示双字，w表示单字，b表示字节
2. movl等操作的源操作数和目的操作数位置，源在前而目的在后，与boot.s中的mov操作是相反的
3. 立即数前必须加$,寄存器前必须加%
4. 待续

### 引用
[Operating System Labs] 我对Linux0.00中 head.s 的理解和注释http://www.cnblogs.com/SuperBlee/p/4095124.html
