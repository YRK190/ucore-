#include <defs.h>
#include <mmu.h>
#include <memlayout.h>
#include <clock.h>
#include <trap.h>
#include <x86.h>
#include <stdio.h>
#include <assert.h>
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

extern uintptr_t __vectors[];//存储着中断处理函数的地址

static void print_ticks() {
    cprintf("%d ticks\n",TICK_NUM);
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}

/* *
 * Interrupt descriptor table:
 *
 * Must be built at run time because shifted function addresses can't
 * be represented in relocation records.
 * */
static struct gatedesc idt[256] = {{0}};

static struct pseudodesc idt_pd = {
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
     /* LAB1 YOUR CODE : STEP 2 */
     /* (1) Where are the entry addrs of each Interrupt Service Routine (ISR)?//      isr的地址存储在__vectors中
      *     All ISR's entry addrs are stored in __vectors. where is uintptr_t __vectors[] ?
      *     __vectors[] is in kern/trap/vector.S which is produced by tools/vector.c  //声明渠道和实现渠道
      *     (try "make" command in lab1, then you will find vector.S in kern/trap DIR)
      *     You can use  "extern uintptr_t __vectors[];" to define this extern variable which will be used later.
      * (2) Now you should setup the entries of ISR in Interrupt Description Table (IDT).
      *     Can you see idt[256] in this file? Yes, it's IDT! you can use SETGATE macro to setup each item of IDT
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
        //从0-256 
        int i=0;
        for (i = 0; i < 256; i++)
        {
            SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);//gate--idt[i]      默认为interrupt gate   sel--段选择子  off--偏移量  dpl--权限，0-内核态
        }
        //SETGATE(idt[T_SWITCH_TOK],0,GD_KDATA,DPL__USER);    单独修改此处作用
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
    lidt(&idt_pd);//挂载idt表到ldtr寄存器中
}

static const char *
trapname(int trapno) {
    static const char * const excnames[] = {
        "Divide error",
        "Debug",
        "Non-Maskable Interrupt",
        "Breakpoint",
        "Overflow",
        "BOUND Range Exceeded",
        "Invalid Opcode",
        "Device Not Available",
        "Double Fault",
        "Coprocessor Segment Overrun",
        "Invalid TSS",
        "Segment Not Present",
        "Stack Fault",
        "General Protection",
        "Page Fault",
        "(unknown trap)",
        "x87 FPU Floating-Point Error",
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };
//判断中断类型
    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
        return excnames[trapno];
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
        return "Hardware Interrupt";
    }
    return "(unknown trap)";
}

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
}

static const char *IA32flags[] = {
    "CF", NULL, "PF", NULL, "AF", NULL, "ZF", "SF",
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
    cprintf("trapframe at %p\n", tf);
    print_regs(&tf->tf_regs);
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
    cprintf("  es   0x----%04x\n", tf->tf_es);
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
    cprintf("  err  0x%08x\n", tf->tf_err);
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);

    if (!trap_in_kernel(tf)) {
        cprintf("  esp  0x%08x\n", tf->tf_esp);
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
    }
}

void
print_regs(struct pushregs *regs) {
    cprintf("  edi  0x%08x\n", regs->reg_edi);
    cprintf("  esi  0x%08x\n", regs->reg_esi);
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
    cprintf("  edx  0x%08x\n", regs->reg_edx);
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
    cprintf("  eax  0x%08x\n", regs->reg_eax);
}

void switch2user(struct trapframe *tf)
{
  // eflags
  // 0x3000 = 00110000 00000000
  // 把nested task位置1，也就是可以嵌套
  tf->tf_eflags |= 0x3000;

  // USER_CS = 3 << 3 | 3 = 24 | 3 = 27 = 0x1B = 00011011;
  // 如果当前运行的程序不是在用户态的代码段执行（从内核切换过来肯定不会是）
  if (tf->tf_cs != USER_CS)
  {
    struct trapframe switchk2u;
    switchk2u = *tf;
    switchk2u.tf_cs = USER_CS;
    // 设置数据段为USER_DS
    switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
    // 因为内存是从高到低，
    // 而这是从内核态切换到用户态（没有ss,sp）
    // (uint32_t)tf + sizeof(struct trapframe) - 8 即 tf->tf_esp的地址
    // 也就是switchk2u.tf_esp，指向旧的tf_esp的值
    switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;

    //  eflags 设置IOPL
    switchk2u.tf_eflags |=FL_IOPL_MASK;

    // (uint32_t *)tf是一个指针，指针的地址-1就
    // *((uint32_t *)tf - 1) 这个指针指向的地址设置为我们新樊笼出来的tss(switchk2u)

    *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  }
}
void switch2kernel(struct trapframe *tf)
{
  if (tf->tf_cs != KERNEL_CS)
  {
    // 设置CS为 KERNEL_CS = 0x8 = 1000 =  00001|0|00 -> Index = 1, GDT, RPL = 0 
    tf->tf_cs = KERNEL_CS;
    // KERNEL_DS = 00010|0|00 -> Index = 2, GDT, RPL = 0 
    tf->tf_ds = tf->tf_es = KERNEL_DS;

    // FL_IOPL_MASK = 0x00003000 = 0011000000000000 = 00110000 00000000
    // I/O Privilege Level bitmask
    // tf->tf_eflags = (tf->tf_eflags) & (~FL_IOPL_MASK)
    // = (tf->tf_eflags) & (11111111 11111111 11001111 11111111)
    // 也就是把IOPL设置为0
    // IOPL(bits 12 and 13) [I/O privilege level field]   
    // 指示当前运行任务的I/O特权级(I/O privilege level)，
    // 正在运行任务的当前特权级(CPL)必须小于或等于I/O特权级才能允许访问I/O地址空间。
    // 这个域只能在CPL为0时才能通过POPF以及IRET指令修改。
    tf->tf_eflags &= ~FL_IOPL_MASK;
    struct trapframe *switchu2k;
    // 由于内存布局是从高到低，所以这里修改switchu2k，指向
    switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));

    /* *
    * memmove - copies the values of @n bytes from the location pointed by @src to
    * the memory area pointed by @dst. @src and @dst are allowed to overlap.
    * @dst        pointer to the destination array where the content is to be copied
    * @src        pointer to the source of data to by copied
    * @n:        number of bytes to copy
    *
    * The memmove() function returns @dst.
    * */
    // 相当于是把tf，拷贝到switchu2k
    memmove(switchu2k, tf, sizeof(struct trapframe) - 8);

    // 修改tf - 1处，指向新的trapframe
    *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  }
  }
/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
    char c;
    switch (tf->tf_trapno) //根据顺序可知，tf->trapno就是中断向量号
    {
    case IRQ_OFFSET + IRQ_TIMER:
        /* LAB1 YOUR CODE : STEP 3 */
        /* handle the 时钟中断 */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
        if (ticks%TICK_NUM==0)
        {
            print_ticks();
            cprintf("\nhello");
        }
        
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
        cprintf("serial [%03d] %c\n", c, c);
        break;
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
        cprintf("kbd [%03d] %c\n", c, c);
        if (c=='3')
        {
            switch2user(tf);
            print_trapframe(tf);
            cprintf("+++ switch to  user  mode by keyboard+++\n");
        }
        if (c=='0')
        {
            switch2kernel(tf);
            print_trapframe(tf);
            cprintf("+++ switch to  kernel  mode by keyboard +++\n");
        }
        
        break;
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.  中断号为120，即0x78
    case T_SWITCH_TOU:
    switch2user(tf);
    break;
    case T_SWITCH_TOK:
        //panic("T_SWITCH_** ??\n");
    switch2kernel(tf);
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}

/* *
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores(复原) the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
}

