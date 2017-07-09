# 2017.7.7学习记录
## 计划
1. 学习c语言中如何调用基础的汇编语言
2. 学习汇编中如何调用c语言

## c语言中调用汇编代码
### 文件内容
1. main.c 主函数
2. strncmp.h 汇编函数，用来比较两个字符串的前n个字符

### 调用过程
```bash
gcc -m32 -o main main.c
./main
```
### 知识点

#### cld指令
清除方向标志，在字符串的比较，赋值，读取等一系列和rep连用的操作中，di或si是可以自动增减的而不需要人来加减它的值，cld即告诉程序si，di向前移动，std指令为设置方向，告诉程序si，di向后移动
### loadsb指令
汇编语言中，串操作指令LODSB/LODSW是块读出指令，其具体操作是把SI指向的存储单元读入累加器,其中LODSB是读入AL,LODSW是读入AX中,然后SI自动增加或减小1或2位.当方向标志位DF=0时，则SI自动增加；DF=1时，SI自动减小。
与LODSB/LODSW类似的，STOSB/STOSW是块写入指令，其具体操作是把累加器的内容写入到指向的存储单元中。其中STOSB是从AL中读入,STOSW是从AX中读入,然后SI自动增加或减小1或2位.当方向标志位DF=0时，则SI自动增加；DF=1时，SI自动减小。[1]
### 嵌入汇编基本格式
```c
asm(
  "汇编语句"
  :输出寄存器
  :输入寄存器
  :会被修改的寄存器
)
```
### es
附加段寄存器，是 extra segment 的缩写；
### ds
数据段寄存器，是  data segment 的缩写；
### test指令
翻译过来就是:
　　将两个操作数进行按位AND,设结果是TEMP
　　SF = 将结果的最高位赋给SF标志位，例如结果最高位是1，SF就是1
## 参考
1. lodsb汇编语句 http://baike.baidu.com/link?url=mGx9wgXLMcf748-3bwzQbD-vHNbNtyg29dk6iEAQQHA4QdhTJVTeBmYqmettn7ItHQcNhIseFV2N2e4GQ8i11q
2. gcc m32 错误http://blog.csdn.net/download_73/article/details/53376855
3. 汇编指令合集http://www.cnblogs.com/lxgeek/archive/2011/01/01/1923738.html
4. SCASB 指令http://baike.baidu.com/link?url=4nm1bPv8SALdW1cB4K10_JRYkCcl7jd15pzU8kMqbPqD6rcTkPhKbMTVnvuxS4yRwW8s7765IKpbdUujBrt3K_
5. test指令
http://baike.baidu.com/link?url=I7GMFeMtM-NF3ux-hZb9s7WUiVGfb6tfLKg-NvKnMQYiBcr5yH44xlu_dVNGyfflJCexbtjflL5ls_z2nvjEWq
6. 如何在64位的linux系统上使用汇编和C语言混合编程http://www.cnblogs.com/chenchenluo/archive/2012/04/02/2421457.html
