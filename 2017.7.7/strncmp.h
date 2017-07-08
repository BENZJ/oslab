//这个函数用来比较两个字符串的前count字符的大小
//%1 表示cs，%2表示ct，%3表示count
extern inline int strncmp(const char *cs,const char *ct, int count){
	register int __res ;
	__asm__(
		"cld\n"									//清除方向
		"1:\tdecl %3\n\t"				//程序段1: %3 = %3 -1 这里%3表示的是count
		"js 2f\n\t"							//非负跳转到2标签（也就是第二段）
		"lodsb\n\t"
		"scasb\n\t"
		"jne 3f\n\t"
		"testb %%al,%%al\n\t"
		"jne 1b\n"
		"2:\txorl %%eax,%%eax\n\t"
		"jmp 4f\n"
		"3:\tmovl $1,%%eax\n\t"
		"jl 4f\n\t"
		"negl %%eax\n"
		"4:"
//		:"=a"(__res):"D" (cs),"S" (ct),"c"(count):"si","di","cx"); //在Linux0.11参考书中原本的代码是这样，但是这样程序无法通过编译运行
		:"=a"(__res):"D" (cs),"S" (ct),"c"(count):);

	return __res;

}
