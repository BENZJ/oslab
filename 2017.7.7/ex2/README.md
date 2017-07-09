# 文件介绍
这个例子用来运行在c程序中调用汇编文件。
# 文件运行方法
```bash
as -32 -o callee.o callee.s
gcc -m32 -o caller caller.c callee.o
```
# 程序运行法结果如下
![](http://oowki3u7j.bkt.clouddn.com/2017.7.7result.png)
