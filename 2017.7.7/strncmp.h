//这个函数用来比较两个字符串的前count字符的大小
//%1 表示cs，%2表示ct，%3表示count
extern inline int strncmp(const char *cs,const char *ct, int count){
	register int __res ;
	__asm__(
		"cld\n"									//清除方向
		"1:\tdecl %3\n\t"				//程序段1: %3 = %3 -1 这里%3表示的是count
		"js 2f\n\t"							//js表示负数跳转，是看标志寄存器的符号标志sf
		"lodsb\n\t"							//lodsb 其具体操作是把SI指向的存储单元读入累加器（也就是eax）ds：（esi）->al ，然后通过esi++，或esi--，通过DF标志位来判断加还是减
		"scasb\n\t"							//scasb 计算 AL - byte of [ES:EDI] , 设置相应的标志寄存器的值； edi++或 -- 通过df来判断 修改寄存器EDI的值：如果标志DF为0，则 inc EDI；如果DF为1，则 dec EDI。
		"jne 3f\n\t"						//jne 不等于则跳转，判断zf标志位zf=0则跳转。 当零标志 Z=0 则跳转； 否则 零标志 Z=1 则顺序执行下一条指令。
		"testb %%al,%%al\n\t"		//判断al是否位NULL
		"jne 1b\n"							//判断
		"2:\txorl %%eax,%%eax\n\t" //xor异或指令就是把eax赋值0
		"jmp 4f\n" 							//无条件跳转指令
		"3:\tmovl $1,%%eax\n\t"	//eax = 1
		"jl 4f\n\t"							//jl
		"negl %%eax\n"					//negl eax=eax
		"4:"										//空的一段程序的结束
//		:"=a"(__res):"D" (cs),"S" (ct),"c"(count):"si","di","cx"); //在Linux0.11参考书中原本的代码是这样，但是这样程序无法通过编译运行
		:"=a"(__res):"D" (cs),"S" (ct),"c"(count):);

	return __res;

}
