!	boot.s
!
! It then loads the system at 0x10000, using BIOS interrupts. Thereafter
! it disables all interrupts, changes to protected mode, and calls the

BOOTSEG = 0x07c0
SYSSEG  = 0x1000			! system loaded at 0x10000 (65536).
SYSLEN  = 17				! sectors occupied.

entry start
start:
	jmpi	go,#BOOTSEG		!这句用来设置段寄存器cs为0x7c00并且设置
go:	mov	ax,cs					!下面两句让ds和ss寄存器都变为0x7c00,ds通常为数据段,ss位堆栈段
	mov	ds,ax
	mov	ss,ax
	mov	sp,#0x400		! arbitrary value >>512  sp为堆栈指针需要大于程序末端并留有一定空间

!从sysseg即0x1000位置处开始加载系统 此时   ax等于0x7c00
! ok, we've written the message, now
load_system:			!这一段用来加载系统
	mov	dx,#0x0000		!加载使用了bios中的int0x13这个中断,中断 dh表示磁头号.......
	mov	cx,#0x0002		!cl
	mov	ax,#SYSSEG		!ax变为0x1000
	mov	es,ax					!es寄存器为扩展寄存器
	xor	bx,bx					!ES:BS(0x1000:0x0000)表示从磁盘中读入的位置
	mov	ax,#0x200+SYSLEN	!ax中 ah也就是0x2用来表示功能号,al用来表示读入的扇区数(SYSLEN = 17,所以一共要读入17个扇区)
	int 	0x13
	jnc	ok_load				!cf位0则跳转
die:	jmp	die

! now we want to move to protected mode ...
ok_load:
	cli			! no interrupts allowed !关中断
	mov	ax, #SYSSEG		!让ax变为0x1000
	mov	ds, ax				!ds = 0x1000
	xor	ax, ax
	mov	es, ax				!es=0u/
	mov	cx, #0x2000
	sub	si,si				!si,di变为0  SI（Source Index）：源变址寄存器可用来存放相对于DS段之源变址指针；
	sub	di,di				!DI（Destination Index）：目的变址寄存器，可用来存放相对于 ES 段之目的变址指针。
	rep
	movw			!单独的movw指令表示从DS:SI移到ES:DI
	mov	ax, #BOOTSEG
	mov	ds, ax
	lidt	idt_48		! load idt with 0,0		!在我的电脑中跑起来的结果是idt_48位于ds:0x69     执行完后idt寄存器为0
	lgdt	gdt_48		! load gdt with whatever appropriate	!在我电脑上gdt_48位于ds:0x6f	执行完后gdt寄存器值位0x7c51

	!lidt和lgdt指令都分别吧idt_48和gdt_48代表的数据放入了对应的寄存器中
	!

! absolute address 0x00000, in 32-bit protected mode.
	mov	ax,#0x0001	! protected mode (PE) bit
	lmsw	ax		! This is it! 指令未执行前CR0寄存器为CR0=0x60000010: pg CD NW ac wp ne ET ts em mp pe.执行完毕后cr0中pe位变为1,进入保护模式
	jmpi	0,8		! jmp offset 0 of segment 8 (cs).这个跳转中就是段选择符,保护模式已经开启jmp far 0008:0000
							! 注意了段选择子这里是0x0008其中的高13位代表索引号.下一位是T1位,再后面两位是RTL.T1=1时候表示指向LDT.RTL表示特权

gdt:	.word	0,0,0,0		! dummy

	.word	0x07FF		! 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		! base address=0x00000
	.word	0x9A00		! code read/exec
	.word	0x00C0		! granularity=4096, 386

	.word	0x07FF		! 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		! base address=0x00000
	.word	0x9200		! data read/write
	.word	0x00C0		! granularity=4096, 386

idt_48: .word	0		! idt limit=0
	.word	0,0		! idt base=0L
gdt_48: .word	0x7ff		! gdt limit=2048, 256 GDT entries
	.word	0x7c00+gdt,0	! gdt base = 07xxx
.org 510
	.word   0xAA55
