#include <defs.h>
#include <stdio.h>
#include <string.h>
#include <console.h>
#include <kdebug.h>
#include <picirq.h>
#include <trap.h>
#include <clock.h>
#include <intr.h>
#include <pmm.h>
#include <kmonitor.h>
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);

    cons_init();                // init the console

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);

    print_kerninfo();

   grade_backtrace();//实际上调用了lab1实验4实现的print——stack函数

    pmm_init();                 // init physical memory management

    pic_init();                 // init interrupt controller          初始化中断控制器
                                //  具体细节不比了解，作用是在使能之后能够使得外设操作能够产生中断
    idt_init();                 // init interrupt descriptor table

    clock_init();               // init clock interrupt
    intr_enable();              // enable irq interrupt

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();

    /* do nothing */
    while (1);
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
    mon_backtrace(0, NULL, NULL);
}

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
}

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
    grade_backtrace1(arg0, arg2);
}

void
grade_backtrace(void) {
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
}

static void
lab1_print_cur_status(void) {
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
    cprintf("%d:  cs = %x\n", round, reg1);
    cprintf("%d:  ds = %x\n", round, reg2);
    cprintf("%d:  es = %x\n", round, reg3);
    cprintf("%d:  ss = %x\n", round, reg4);
    round ++;
}

static void

lab1_switch_to_user(void) {
    //LAB1 CHALLENGE 1 : TODO
__asm__ __volatile__ (
        "sub $0x8, %%esp \n"
        "int %0 \n"
        "movl %%ebp, %%esp \n"       // 因为这里主动调INT之后，汇编不会帮我们把类似leave的指令补齐，所以需要我们自己加上去
        :
        :"i"(T_SWITCH_TOU)
    );

}



static void
lab1_switch_to_kernel(void) {
    //LAB1 CHALLENGE 1 :  TODO
   __asm__ __volatile__ (
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        :
        :"i"(T_SWITCH_TOK)
    ); 
}

static void lab2_switch_kb(void)
{
     __asm__ __volatile__ (
        "sub $0x8, %%esp \n"
        "INT %0 \n"
        "movl %%ebp, %%esp \n"
        :
        :"irq"(T_SWITCH_KB)
    );     
}
static void
lab1_switch_test(void) {
    lab1_print_cur_status();    // print 当前 cs/ss/ds 等寄存器状态
    lab1_switch_to_user();
    cprintf("+++ switch to  user  mode +++\n");
    lab1_print_cur_status();
    lab1_switch_to_kernel();
    cprintf("+++ switch to kernel mode +++\n");
    lab1_print_cur_status();

   lab2_switch_kb();
    
}
