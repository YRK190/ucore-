
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 cc 2d 00 00       	call   102df8 <memset>

    cons_init();                // init the console
  10002c:	e8 66 15 00 00       	call   101597 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 20 36 10 00 	movl   $0x103620,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 3c 36 10 00 	movl   $0x10363c,(%esp)
  100046:	e8 32 02 00 00       	call   10027d <cprintf>

    print_kerninfo();
  10004b:	e8 d3 08 00 00       	call   100923 <print_kerninfo>

   grade_backtrace();//实际上调用了lab1实验4实现的print——stack函数
  100050:	e8 8b 00 00 00       	call   1000e0 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 65 2a 00 00       	call   102abf <pmm_init>

    pic_init();                 // init interrupt controller          初始化中断控制器
  10005a:	e8 6f 16 00 00       	call   1016ce <pic_init>
                                //  具体细节不比了解，作用是在使能之后能够使得外设操作能够产生中断
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 cd 17 00 00       	call   101831 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 21 0d 00 00       	call   100d8a <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 9b 17 00 00       	call   101809 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 79 01 00 00       	call   1001ec <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	55                   	push   %ebp
  100076:	89 e5                	mov    %esp,%ebp
  100078:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100082:	00 
  100083:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008a:	00 
  10008b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100092:	e8 e1 0c 00 00       	call   100d78 <mon_backtrace>
}
  100097:	c9                   	leave  
  100098:	c3                   	ret    

00100099 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100099:	55                   	push   %ebp
  10009a:	89 e5                	mov    %esp,%ebp
  10009c:	53                   	push   %ebx
  10009d:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a0:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a6:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ac:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000b4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b8:	89 04 24             	mov    %eax,(%esp)
  1000bb:	e8 b5 ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c0:	83 c4 14             	add    $0x14,%esp
  1000c3:	5b                   	pop    %ebx
  1000c4:	5d                   	pop    %ebp
  1000c5:	c3                   	ret    

001000c6 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c6:	55                   	push   %ebp
  1000c7:	89 e5                	mov    %esp,%ebp
  1000c9:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d6:	89 04 24             	mov    %eax,(%esp)
  1000d9:	e8 bb ff ff ff       	call   100099 <grade_backtrace1>
}
  1000de:	c9                   	leave  
  1000df:	c3                   	ret    

001000e0 <grade_backtrace>:

void
grade_backtrace(void) {
  1000e0:	55                   	push   %ebp
  1000e1:	89 e5                	mov    %esp,%ebp
  1000e3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e6:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000eb:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f2:	ff 
  1000f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fe:	e8 c3 ff ff ff       	call   1000c6 <grade_backtrace0>
}
  100103:	c9                   	leave  
  100104:	c3                   	ret    

00100105 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100105:	55                   	push   %ebp
  100106:	89 e5                	mov    %esp,%ebp
  100108:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10010b:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010e:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100111:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100114:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100117:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011b:	0f b7 c0             	movzwl %ax,%eax
  10011e:	83 e0 03             	and    $0x3,%eax
  100121:	89 c2                	mov    %eax,%edx
  100123:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100128:	89 54 24 08          	mov    %edx,0x8(%esp)
  10012c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100130:	c7 04 24 41 36 10 00 	movl   $0x103641,(%esp)
  100137:	e8 41 01 00 00       	call   10027d <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10013c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100140:	0f b7 d0             	movzwl %ax,%edx
  100143:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100148:	89 54 24 08          	mov    %edx,0x8(%esp)
  10014c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100150:	c7 04 24 4f 36 10 00 	movl   $0x10364f,(%esp)
  100157:	e8 21 01 00 00       	call   10027d <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10015c:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100160:	0f b7 d0             	movzwl %ax,%edx
  100163:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100168:	89 54 24 08          	mov    %edx,0x8(%esp)
  10016c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100170:	c7 04 24 5d 36 10 00 	movl   $0x10365d,(%esp)
  100177:	e8 01 01 00 00       	call   10027d <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10017c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100180:	0f b7 d0             	movzwl %ax,%edx
  100183:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100188:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100190:	c7 04 24 6b 36 10 00 	movl   $0x10366b,(%esp)
  100197:	e8 e1 00 00 00       	call   10027d <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a0:	0f b7 d0             	movzwl %ax,%edx
  1001a3:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a8:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b0:	c7 04 24 79 36 10 00 	movl   $0x103679,(%esp)
  1001b7:	e8 c1 00 00 00       	call   10027d <cprintf>
    round ++;
  1001bc:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001c1:	83 c0 01             	add    $0x1,%eax
  1001c4:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c9:	c9                   	leave  
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_user>:

static void

lab1_switch_to_user(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
__asm__ __volatile__ (
  1001ce:	83 ec 08             	sub    $0x8,%esp
  1001d1:	cd 78                	int    $0x78
  1001d3:	89 ec                	mov    %ebp,%esp
        "movl %%ebp, %%esp \n"       // 因为这里主动调INT之后，汇编不会帮我们把类似leave的指令补齐，所以需要我们自己加上去
        :
        :"i"(T_SWITCH_TOU)
    );

}
  1001d5:	5d                   	pop    %ebp
  1001d6:	c3                   	ret    

001001d7 <lab1_switch_to_kernel>:



static void
lab1_switch_to_kernel(void) {
  1001d7:	55                   	push   %ebp
  1001d8:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
   __asm__ __volatile__ (
  1001da:	cd 79                	int    $0x79
  1001dc:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        :
        :"i"(T_SWITCH_TOK)
    ); 
}
  1001de:	5d                   	pop    %ebp
  1001df:	c3                   	ret    

001001e0 <lab2_switch_kb>:

static void lab2_switch_kb(void)
{
  1001e0:	55                   	push   %ebp
  1001e1:	89 e5                	mov    %esp,%ebp
     __asm__ __volatile__ (
  1001e3:	83 ec 08             	sub    $0x8,%esp
  1001e6:	cd 21                	int    $0x21
  1001e8:	89 ec                	mov    %ebp,%esp
        "INT %0 \n"
        "movl %%ebp, %%esp \n"
        :
        :"irq"(T_SWITCH_KB)
    );     
}
  1001ea:	5d                   	pop    %ebp
  1001eb:	c3                   	ret    

001001ec <lab1_switch_test>:
static void
lab1_switch_test(void) {
  1001ec:	55                   	push   %ebp
  1001ed:	89 e5                	mov    %esp,%ebp
  1001ef:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();    // print 当前 cs/ss/ds 等寄存器状态
  1001f2:	e8 0e ff ff ff       	call   100105 <lab1_print_cur_status>
    lab1_switch_to_user();
  1001f7:	e8 cf ff ff ff       	call   1001cb <lab1_switch_to_user>
    cprintf("+++ switch to  user  mode +++\n");
  1001fc:	c7 04 24 88 36 10 00 	movl   $0x103688,(%esp)
  100203:	e8 75 00 00 00       	call   10027d <cprintf>
    lab1_print_cur_status();
  100208:	e8 f8 fe ff ff       	call   100105 <lab1_print_cur_status>
    lab1_switch_to_kernel();
  10020d:	e8 c5 ff ff ff       	call   1001d7 <lab1_switch_to_kernel>
    cprintf("+++ switch to kernel mode +++\n");
  100212:	c7 04 24 a8 36 10 00 	movl   $0x1036a8,(%esp)
  100219:	e8 5f 00 00 00       	call   10027d <cprintf>
    lab1_print_cur_status();
  10021e:	e8 e2 fe ff ff       	call   100105 <lab1_print_cur_status>

   lab2_switch_kb();
  100223:	e8 b8 ff ff ff       	call   1001e0 <lab2_switch_kb>
    
}
  100228:	c9                   	leave  
  100229:	c3                   	ret    

0010022a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  10022a:	55                   	push   %ebp
  10022b:	89 e5                	mov    %esp,%ebp
  10022d:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100230:	8b 45 08             	mov    0x8(%ebp),%eax
  100233:	89 04 24             	mov    %eax,(%esp)
  100236:	e8 88 13 00 00       	call   1015c3 <cons_putc>
    (*cnt) ++;
  10023b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10023e:	8b 00                	mov    (%eax),%eax
  100240:	8d 50 01             	lea    0x1(%eax),%edx
  100243:	8b 45 0c             	mov    0xc(%ebp),%eax
  100246:	89 10                	mov    %edx,(%eax)
}
  100248:	c9                   	leave  
  100249:	c3                   	ret    

0010024a <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10024a:	55                   	push   %ebp
  10024b:	89 e5                	mov    %esp,%ebp
  10024d:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100257:	8b 45 0c             	mov    0xc(%ebp),%eax
  10025a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10025e:	8b 45 08             	mov    0x8(%ebp),%eax
  100261:	89 44 24 08          	mov    %eax,0x8(%esp)
  100265:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100268:	89 44 24 04          	mov    %eax,0x4(%esp)
  10026c:	c7 04 24 2a 02 10 00 	movl   $0x10022a,(%esp)
  100273:	e8 d2 2e 00 00       	call   10314a <vprintfmt>
    return cnt;
  100278:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10027b:	c9                   	leave  
  10027c:	c3                   	ret    

0010027d <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10027d:	55                   	push   %ebp
  10027e:	89 e5                	mov    %esp,%ebp
  100280:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100283:	8d 45 0c             	lea    0xc(%ebp),%eax
  100286:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100289:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10028c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100290:	8b 45 08             	mov    0x8(%ebp),%eax
  100293:	89 04 24             	mov    %eax,(%esp)
  100296:	e8 af ff ff ff       	call   10024a <vcprintf>
  10029b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10029e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002a1:	c9                   	leave  
  1002a2:	c3                   	ret    

001002a3 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002a3:	55                   	push   %ebp
  1002a4:	89 e5                	mov    %esp,%ebp
  1002a6:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ac:	89 04 24             	mov    %eax,(%esp)
  1002af:	e8 0f 13 00 00       	call   1015c3 <cons_putc>
}
  1002b4:	c9                   	leave  
  1002b5:	c3                   	ret    

001002b6 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002b6:	55                   	push   %ebp
  1002b7:	89 e5                	mov    %esp,%ebp
  1002b9:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002c3:	eb 13                	jmp    1002d8 <cputs+0x22>
        cputch(c, &cnt);
  1002c5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002c9:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002cc:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002d0:	89 04 24             	mov    %eax,(%esp)
  1002d3:	e8 52 ff ff ff       	call   10022a <cputch>
    while ((c = *str ++) != '\0') {
  1002d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1002db:	8d 50 01             	lea    0x1(%eax),%edx
  1002de:	89 55 08             	mov    %edx,0x8(%ebp)
  1002e1:	0f b6 00             	movzbl (%eax),%eax
  1002e4:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002e7:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002eb:	75 d8                	jne    1002c5 <cputs+0xf>
    }
    cputch('\n', &cnt);
  1002ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002f4:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1002fb:	e8 2a ff ff ff       	call   10022a <cputch>
    return cnt;
  100300:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100303:	c9                   	leave  
  100304:	c3                   	ret    

00100305 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100305:	55                   	push   %ebp
  100306:	89 e5                	mov    %esp,%ebp
  100308:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  10030b:	e8 dc 12 00 00       	call   1015ec <cons_getc>
  100310:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100313:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100317:	74 f2                	je     10030b <getchar+0x6>
        /* do nothing */;
    return c;
  100319:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10031c:	c9                   	leave  
  10031d:	c3                   	ret    

0010031e <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  10031e:	55                   	push   %ebp
  10031f:	89 e5                	mov    %esp,%ebp
  100321:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100324:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100328:	74 13                	je     10033d <readline+0x1f>
        cprintf("%s", prompt);
  10032a:	8b 45 08             	mov    0x8(%ebp),%eax
  10032d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100331:	c7 04 24 c7 36 10 00 	movl   $0x1036c7,(%esp)
  100338:	e8 40 ff ff ff       	call   10027d <cprintf>
    }
    int i = 0, c;
  10033d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100344:	e8 bc ff ff ff       	call   100305 <getchar>
  100349:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10034c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100350:	79 07                	jns    100359 <readline+0x3b>
            return NULL;
  100352:	b8 00 00 00 00       	mov    $0x0,%eax
  100357:	eb 79                	jmp    1003d2 <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100359:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10035d:	7e 28                	jle    100387 <readline+0x69>
  10035f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100366:	7f 1f                	jg     100387 <readline+0x69>
            cputchar(c);
  100368:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10036b:	89 04 24             	mov    %eax,(%esp)
  10036e:	e8 30 ff ff ff       	call   1002a3 <cputchar>
            buf[i ++] = c;
  100373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100376:	8d 50 01             	lea    0x1(%eax),%edx
  100379:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10037c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10037f:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100385:	eb 46                	jmp    1003cd <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100387:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10038b:	75 17                	jne    1003a4 <readline+0x86>
  10038d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100391:	7e 11                	jle    1003a4 <readline+0x86>
            cputchar(c);
  100393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100396:	89 04 24             	mov    %eax,(%esp)
  100399:	e8 05 ff ff ff       	call   1002a3 <cputchar>
            i --;
  10039e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1003a2:	eb 29                	jmp    1003cd <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  1003a4:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003a8:	74 06                	je     1003b0 <readline+0x92>
  1003aa:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003ae:	75 1d                	jne    1003cd <readline+0xaf>
            cputchar(c);
  1003b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003b3:	89 04 24             	mov    %eax,(%esp)
  1003b6:	e8 e8 fe ff ff       	call   1002a3 <cputchar>
            buf[i] = '\0';
  1003bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003be:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1003c3:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003c6:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1003cb:	eb 05                	jmp    1003d2 <readline+0xb4>
        }
    }
  1003cd:	e9 72 ff ff ff       	jmp    100344 <readline+0x26>
}
  1003d2:	c9                   	leave  
  1003d3:	c3                   	ret    

001003d4 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003d4:	55                   	push   %ebp
  1003d5:	89 e5                	mov    %esp,%ebp
  1003d7:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  1003da:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  1003df:	85 c0                	test   %eax,%eax
  1003e1:	74 02                	je     1003e5 <__panic+0x11>
        goto panic_dead;
  1003e3:	eb 48                	jmp    10042d <__panic+0x59>
    }
    is_panic = 1;
  1003e5:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  1003ec:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1003ef:	8d 45 14             	lea    0x14(%ebp),%eax
  1003f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1003f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003f8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1003ff:	89 44 24 04          	mov    %eax,0x4(%esp)
  100403:	c7 04 24 ca 36 10 00 	movl   $0x1036ca,(%esp)
  10040a:	e8 6e fe ff ff       	call   10027d <cprintf>
    vcprintf(fmt, ap);
  10040f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100412:	89 44 24 04          	mov    %eax,0x4(%esp)
  100416:	8b 45 10             	mov    0x10(%ebp),%eax
  100419:	89 04 24             	mov    %eax,(%esp)
  10041c:	e8 29 fe ff ff       	call   10024a <vcprintf>
    cprintf("\n");
  100421:	c7 04 24 e6 36 10 00 	movl   $0x1036e6,(%esp)
  100428:	e8 50 fe ff ff       	call   10027d <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  10042d:	e8 dd 13 00 00       	call   10180f <intr_disable>
    while (1) {
        kmonitor(NULL);
  100432:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100439:	e8 6b 08 00 00       	call   100ca9 <kmonitor>
    }
  10043e:	eb f2                	jmp    100432 <__panic+0x5e>

00100440 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100440:	55                   	push   %ebp
  100441:	89 e5                	mov    %esp,%ebp
  100443:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100446:	8d 45 14             	lea    0x14(%ebp),%eax
  100449:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10044c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10044f:	89 44 24 08          	mov    %eax,0x8(%esp)
  100453:	8b 45 08             	mov    0x8(%ebp),%eax
  100456:	89 44 24 04          	mov    %eax,0x4(%esp)
  10045a:	c7 04 24 e8 36 10 00 	movl   $0x1036e8,(%esp)
  100461:	e8 17 fe ff ff       	call   10027d <cprintf>
    vcprintf(fmt, ap);
  100466:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100469:	89 44 24 04          	mov    %eax,0x4(%esp)
  10046d:	8b 45 10             	mov    0x10(%ebp),%eax
  100470:	89 04 24             	mov    %eax,(%esp)
  100473:	e8 d2 fd ff ff       	call   10024a <vcprintf>
    cprintf("\n");
  100478:	c7 04 24 e6 36 10 00 	movl   $0x1036e6,(%esp)
  10047f:	e8 f9 fd ff ff       	call   10027d <cprintf>
    va_end(ap);
}
  100484:	c9                   	leave  
  100485:	c3                   	ret    

00100486 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100486:	55                   	push   %ebp
  100487:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100489:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  10048e:	5d                   	pop    %ebp
  10048f:	c3                   	ret    

00100490 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100490:	55                   	push   %ebp
  100491:	89 e5                	mov    %esp,%ebp
  100493:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  100496:	8b 45 0c             	mov    0xc(%ebp),%eax
  100499:	8b 00                	mov    (%eax),%eax
  10049b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10049e:	8b 45 10             	mov    0x10(%ebp),%eax
  1004a1:	8b 00                	mov    (%eax),%eax
  1004a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004ad:	e9 d2 00 00 00       	jmp    100584 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1004b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004b8:	01 d0                	add    %edx,%eax
  1004ba:	89 c2                	mov    %eax,%edx
  1004bc:	c1 ea 1f             	shr    $0x1f,%edx
  1004bf:	01 d0                	add    %edx,%eax
  1004c1:	d1 f8                	sar    %eax
  1004c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1004c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004c9:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1004cc:	eb 04                	jmp    1004d2 <stab_binsearch+0x42>
            m --;
  1004ce:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1004d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004d5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004d8:	7c 1f                	jl     1004f9 <stab_binsearch+0x69>
  1004da:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004dd:	89 d0                	mov    %edx,%eax
  1004df:	01 c0                	add    %eax,%eax
  1004e1:	01 d0                	add    %edx,%eax
  1004e3:	c1 e0 02             	shl    $0x2,%eax
  1004e6:	89 c2                	mov    %eax,%edx
  1004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1004eb:	01 d0                	add    %edx,%eax
  1004ed:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004f1:	0f b6 c0             	movzbl %al,%eax
  1004f4:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004f7:	75 d5                	jne    1004ce <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
  1004f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004fc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004ff:	7d 0b                	jge    10050c <stab_binsearch+0x7c>
            l = true_m + 1;
  100501:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100504:	83 c0 01             	add    $0x1,%eax
  100507:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10050a:	eb 78                	jmp    100584 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10050c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100513:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100516:	89 d0                	mov    %edx,%eax
  100518:	01 c0                	add    %eax,%eax
  10051a:	01 d0                	add    %edx,%eax
  10051c:	c1 e0 02             	shl    $0x2,%eax
  10051f:	89 c2                	mov    %eax,%edx
  100521:	8b 45 08             	mov    0x8(%ebp),%eax
  100524:	01 d0                	add    %edx,%eax
  100526:	8b 40 08             	mov    0x8(%eax),%eax
  100529:	3b 45 18             	cmp    0x18(%ebp),%eax
  10052c:	73 13                	jae    100541 <stab_binsearch+0xb1>
            *region_left = m;
  10052e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100531:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100534:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100536:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100539:	83 c0 01             	add    $0x1,%eax
  10053c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10053f:	eb 43                	jmp    100584 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100541:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100544:	89 d0                	mov    %edx,%eax
  100546:	01 c0                	add    %eax,%eax
  100548:	01 d0                	add    %edx,%eax
  10054a:	c1 e0 02             	shl    $0x2,%eax
  10054d:	89 c2                	mov    %eax,%edx
  10054f:	8b 45 08             	mov    0x8(%ebp),%eax
  100552:	01 d0                	add    %edx,%eax
  100554:	8b 40 08             	mov    0x8(%eax),%eax
  100557:	3b 45 18             	cmp    0x18(%ebp),%eax
  10055a:	76 16                	jbe    100572 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10055c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10055f:	8d 50 ff             	lea    -0x1(%eax),%edx
  100562:	8b 45 10             	mov    0x10(%ebp),%eax
  100565:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100567:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10056a:	83 e8 01             	sub    $0x1,%eax
  10056d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100570:	eb 12                	jmp    100584 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100572:	8b 45 0c             	mov    0xc(%ebp),%eax
  100575:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100578:	89 10                	mov    %edx,(%eax)
            l = m;
  10057a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10057d:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  100580:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  100584:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100587:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  10058a:	0f 8e 22 ff ff ff    	jle    1004b2 <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
  100590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100594:	75 0f                	jne    1005a5 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  100596:	8b 45 0c             	mov    0xc(%ebp),%eax
  100599:	8b 00                	mov    (%eax),%eax
  10059b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10059e:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a1:	89 10                	mov    %edx,(%eax)
  1005a3:	eb 3f                	jmp    1005e4 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1005a5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a8:	8b 00                	mov    (%eax),%eax
  1005aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005ad:	eb 04                	jmp    1005b3 <stab_binsearch+0x123>
  1005af:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1005b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b6:	8b 00                	mov    (%eax),%eax
  1005b8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005bb:	7d 1f                	jge    1005dc <stab_binsearch+0x14c>
  1005bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005c0:	89 d0                	mov    %edx,%eax
  1005c2:	01 c0                	add    %eax,%eax
  1005c4:	01 d0                	add    %edx,%eax
  1005c6:	c1 e0 02             	shl    $0x2,%eax
  1005c9:	89 c2                	mov    %eax,%edx
  1005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ce:	01 d0                	add    %edx,%eax
  1005d0:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005d4:	0f b6 c0             	movzbl %al,%eax
  1005d7:	3b 45 14             	cmp    0x14(%ebp),%eax
  1005da:	75 d3                	jne    1005af <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  1005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005e2:	89 10                	mov    %edx,(%eax)
    }
}
  1005e4:	c9                   	leave  
  1005e5:	c3                   	ret    

001005e6 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1005e6:	55                   	push   %ebp
  1005e7:	89 e5                	mov    %esp,%ebp
  1005e9:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1005ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ef:	c7 00 08 37 10 00    	movl   $0x103708,(%eax)
    info->eip_line = 0;
  1005f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1005ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  100602:	c7 40 08 08 37 10 00 	movl   $0x103708,0x8(%eax)
    info->eip_fn_namelen = 9;
  100609:	8b 45 0c             	mov    0xc(%ebp),%eax
  10060c:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100613:	8b 45 0c             	mov    0xc(%ebp),%eax
  100616:	8b 55 08             	mov    0x8(%ebp),%edx
  100619:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10061c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100626:	c7 45 f4 ac 3f 10 00 	movl   $0x103fac,-0xc(%ebp)
    stab_end = __STAB_END__;
  10062d:	c7 45 f0 fc b8 10 00 	movl   $0x10b8fc,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100634:	c7 45 ec fd b8 10 00 	movl   $0x10b8fd,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10063b:	c7 45 e8 53 d9 10 00 	movl   $0x10d953,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100642:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100645:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100648:	76 0d                	jbe    100657 <debuginfo_eip+0x71>
  10064a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10064d:	83 e8 01             	sub    $0x1,%eax
  100650:	0f b6 00             	movzbl (%eax),%eax
  100653:	84 c0                	test   %al,%al
  100655:	74 0a                	je     100661 <debuginfo_eip+0x7b>
        return -1;
  100657:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10065c:	e9 c0 02 00 00       	jmp    100921 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100661:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100668:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10066b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10066e:	29 c2                	sub    %eax,%edx
  100670:	89 d0                	mov    %edx,%eax
  100672:	c1 f8 02             	sar    $0x2,%eax
  100675:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  10067b:	83 e8 01             	sub    $0x1,%eax
  10067e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100681:	8b 45 08             	mov    0x8(%ebp),%eax
  100684:	89 44 24 10          	mov    %eax,0x10(%esp)
  100688:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  10068f:	00 
  100690:	8d 45 e0             	lea    -0x20(%ebp),%eax
  100693:	89 44 24 08          	mov    %eax,0x8(%esp)
  100697:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  10069a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10069e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006a1:	89 04 24             	mov    %eax,(%esp)
  1006a4:	e8 e7 fd ff ff       	call   100490 <stab_binsearch>
    if (lfile == 0)
  1006a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006ac:	85 c0                	test   %eax,%eax
  1006ae:	75 0a                	jne    1006ba <debuginfo_eip+0xd4>
        return -1;
  1006b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006b5:	e9 67 02 00 00       	jmp    100921 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006c3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c9:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006cd:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  1006d4:	00 
  1006d5:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1006d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006dc:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1006df:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006e6:	89 04 24             	mov    %eax,(%esp)
  1006e9:	e8 a2 fd ff ff       	call   100490 <stab_binsearch>

    if (lfun <= rfun) {
  1006ee:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1006f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006f4:	39 c2                	cmp    %eax,%edx
  1006f6:	7f 7c                	jg     100774 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  1006f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006fb:	89 c2                	mov    %eax,%edx
  1006fd:	89 d0                	mov    %edx,%eax
  1006ff:	01 c0                	add    %eax,%eax
  100701:	01 d0                	add    %edx,%eax
  100703:	c1 e0 02             	shl    $0x2,%eax
  100706:	89 c2                	mov    %eax,%edx
  100708:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10070b:	01 d0                	add    %edx,%eax
  10070d:	8b 10                	mov    (%eax),%edx
  10070f:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100712:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100715:	29 c1                	sub    %eax,%ecx
  100717:	89 c8                	mov    %ecx,%eax
  100719:	39 c2                	cmp    %eax,%edx
  10071b:	73 22                	jae    10073f <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10071d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100720:	89 c2                	mov    %eax,%edx
  100722:	89 d0                	mov    %edx,%eax
  100724:	01 c0                	add    %eax,%eax
  100726:	01 d0                	add    %edx,%eax
  100728:	c1 e0 02             	shl    $0x2,%eax
  10072b:	89 c2                	mov    %eax,%edx
  10072d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100730:	01 d0                	add    %edx,%eax
  100732:	8b 10                	mov    (%eax),%edx
  100734:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100737:	01 c2                	add    %eax,%edx
  100739:	8b 45 0c             	mov    0xc(%ebp),%eax
  10073c:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10073f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100742:	89 c2                	mov    %eax,%edx
  100744:	89 d0                	mov    %edx,%eax
  100746:	01 c0                	add    %eax,%eax
  100748:	01 d0                	add    %edx,%eax
  10074a:	c1 e0 02             	shl    $0x2,%eax
  10074d:	89 c2                	mov    %eax,%edx
  10074f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100752:	01 d0                	add    %edx,%eax
  100754:	8b 50 08             	mov    0x8(%eax),%edx
  100757:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075a:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10075d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100760:	8b 40 10             	mov    0x10(%eax),%eax
  100763:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100766:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100769:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10076c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10076f:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100772:	eb 15                	jmp    100789 <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100774:	8b 45 0c             	mov    0xc(%ebp),%eax
  100777:	8b 55 08             	mov    0x8(%ebp),%edx
  10077a:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  10077d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100780:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  100783:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100786:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  100789:	8b 45 0c             	mov    0xc(%ebp),%eax
  10078c:	8b 40 08             	mov    0x8(%eax),%eax
  10078f:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  100796:	00 
  100797:	89 04 24             	mov    %eax,(%esp)
  10079a:	e8 cd 24 00 00       	call   102c6c <strfind>
  10079f:	89 c2                	mov    %eax,%edx
  1007a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007a4:	8b 40 08             	mov    0x8(%eax),%eax
  1007a7:	29 c2                	sub    %eax,%edx
  1007a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ac:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007af:	8b 45 08             	mov    0x8(%ebp),%eax
  1007b2:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007b6:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007bd:	00 
  1007be:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007c1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007c5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1007cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007cf:	89 04 24             	mov    %eax,(%esp)
  1007d2:	e8 b9 fc ff ff       	call   100490 <stab_binsearch>
    if (lline <= rline) {
  1007d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007dd:	39 c2                	cmp    %eax,%edx
  1007df:	7f 24                	jg     100805 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  1007e1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007e4:	89 c2                	mov    %eax,%edx
  1007e6:	89 d0                	mov    %edx,%eax
  1007e8:	01 c0                	add    %eax,%eax
  1007ea:	01 d0                	add    %edx,%eax
  1007ec:	c1 e0 02             	shl    $0x2,%eax
  1007ef:	89 c2                	mov    %eax,%edx
  1007f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007f4:	01 d0                	add    %edx,%eax
  1007f6:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1007fa:	0f b7 d0             	movzwl %ax,%edx
  1007fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100800:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100803:	eb 13                	jmp    100818 <debuginfo_eip+0x232>
        return -1;
  100805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10080a:	e9 12 01 00 00       	jmp    100921 <debuginfo_eip+0x33b>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10080f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100812:	83 e8 01             	sub    $0x1,%eax
  100815:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10081b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10081e:	39 c2                	cmp    %eax,%edx
  100820:	7c 56                	jl     100878 <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100822:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100825:	89 c2                	mov    %eax,%edx
  100827:	89 d0                	mov    %edx,%eax
  100829:	01 c0                	add    %eax,%eax
  10082b:	01 d0                	add    %edx,%eax
  10082d:	c1 e0 02             	shl    $0x2,%eax
  100830:	89 c2                	mov    %eax,%edx
  100832:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100835:	01 d0                	add    %edx,%eax
  100837:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10083b:	3c 84                	cmp    $0x84,%al
  10083d:	74 39                	je     100878 <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10083f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100842:	89 c2                	mov    %eax,%edx
  100844:	89 d0                	mov    %edx,%eax
  100846:	01 c0                	add    %eax,%eax
  100848:	01 d0                	add    %edx,%eax
  10084a:	c1 e0 02             	shl    $0x2,%eax
  10084d:	89 c2                	mov    %eax,%edx
  10084f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100852:	01 d0                	add    %edx,%eax
  100854:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100858:	3c 64                	cmp    $0x64,%al
  10085a:	75 b3                	jne    10080f <debuginfo_eip+0x229>
  10085c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10085f:	89 c2                	mov    %eax,%edx
  100861:	89 d0                	mov    %edx,%eax
  100863:	01 c0                	add    %eax,%eax
  100865:	01 d0                	add    %edx,%eax
  100867:	c1 e0 02             	shl    $0x2,%eax
  10086a:	89 c2                	mov    %eax,%edx
  10086c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10086f:	01 d0                	add    %edx,%eax
  100871:	8b 40 08             	mov    0x8(%eax),%eax
  100874:	85 c0                	test   %eax,%eax
  100876:	74 97                	je     10080f <debuginfo_eip+0x229>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100878:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10087b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10087e:	39 c2                	cmp    %eax,%edx
  100880:	7c 46                	jl     1008c8 <debuginfo_eip+0x2e2>
  100882:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100885:	89 c2                	mov    %eax,%edx
  100887:	89 d0                	mov    %edx,%eax
  100889:	01 c0                	add    %eax,%eax
  10088b:	01 d0                	add    %edx,%eax
  10088d:	c1 e0 02             	shl    $0x2,%eax
  100890:	89 c2                	mov    %eax,%edx
  100892:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100895:	01 d0                	add    %edx,%eax
  100897:	8b 10                	mov    (%eax),%edx
  100899:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10089c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10089f:	29 c1                	sub    %eax,%ecx
  1008a1:	89 c8                	mov    %ecx,%eax
  1008a3:	39 c2                	cmp    %eax,%edx
  1008a5:	73 21                	jae    1008c8 <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008a7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008aa:	89 c2                	mov    %eax,%edx
  1008ac:	89 d0                	mov    %edx,%eax
  1008ae:	01 c0                	add    %eax,%eax
  1008b0:	01 d0                	add    %edx,%eax
  1008b2:	c1 e0 02             	shl    $0x2,%eax
  1008b5:	89 c2                	mov    %eax,%edx
  1008b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ba:	01 d0                	add    %edx,%eax
  1008bc:	8b 10                	mov    (%eax),%edx
  1008be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008c1:	01 c2                	add    %eax,%edx
  1008c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008c6:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008c8:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008ce:	39 c2                	cmp    %eax,%edx
  1008d0:	7d 4a                	jge    10091c <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  1008d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008d5:	83 c0 01             	add    $0x1,%eax
  1008d8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008db:	eb 18                	jmp    1008f5 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008e0:	8b 40 14             	mov    0x14(%eax),%eax
  1008e3:	8d 50 01             	lea    0x1(%eax),%edx
  1008e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008e9:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008ec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008ef:	83 c0 01             	add    $0x1,%eax
  1008f2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008f5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1008fb:	39 c2                	cmp    %eax,%edx
  1008fd:	7d 1d                	jge    10091c <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100902:	89 c2                	mov    %eax,%edx
  100904:	89 d0                	mov    %edx,%eax
  100906:	01 c0                	add    %eax,%eax
  100908:	01 d0                	add    %edx,%eax
  10090a:	c1 e0 02             	shl    $0x2,%eax
  10090d:	89 c2                	mov    %eax,%edx
  10090f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100912:	01 d0                	add    %edx,%eax
  100914:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100918:	3c a0                	cmp    $0xa0,%al
  10091a:	74 c1                	je     1008dd <debuginfo_eip+0x2f7>
        }
    }
    return 0;
  10091c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100921:	c9                   	leave  
  100922:	c3                   	ret    

00100923 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100923:	55                   	push   %ebp
  100924:	89 e5                	mov    %esp,%ebp
  100926:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100929:	c7 04 24 12 37 10 00 	movl   $0x103712,(%esp)
  100930:	e8 48 f9 ff ff       	call   10027d <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100935:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10093c:	00 
  10093d:	c7 04 24 2b 37 10 00 	movl   $0x10372b,(%esp)
  100944:	e8 34 f9 ff ff       	call   10027d <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100949:	c7 44 24 04 02 36 10 	movl   $0x103602,0x4(%esp)
  100950:	00 
  100951:	c7 04 24 43 37 10 00 	movl   $0x103743,(%esp)
  100958:	e8 20 f9 ff ff       	call   10027d <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10095d:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100964:	00 
  100965:	c7 04 24 5b 37 10 00 	movl   $0x10375b,(%esp)
  10096c:	e8 0c f9 ff ff       	call   10027d <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100971:	c7 44 24 04 20 fd 10 	movl   $0x10fd20,0x4(%esp)
  100978:	00 
  100979:	c7 04 24 73 37 10 00 	movl   $0x103773,(%esp)
  100980:	e8 f8 f8 ff ff       	call   10027d <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100985:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  10098a:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100990:	b8 00 00 10 00       	mov    $0x100000,%eax
  100995:	29 c2                	sub    %eax,%edx
  100997:	89 d0                	mov    %edx,%eax
  100999:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10099f:	85 c0                	test   %eax,%eax
  1009a1:	0f 48 c2             	cmovs  %edx,%eax
  1009a4:	c1 f8 0a             	sar    $0xa,%eax
  1009a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009ab:	c7 04 24 8c 37 10 00 	movl   $0x10378c,(%esp)
  1009b2:	e8 c6 f8 ff ff       	call   10027d <cprintf>
}
  1009b7:	c9                   	leave  
  1009b8:	c3                   	ret    

001009b9 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009b9:	55                   	push   %ebp
  1009ba:	89 e5                	mov    %esp,%ebp
  1009bc:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009c2:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1009cc:	89 04 24             	mov    %eax,(%esp)
  1009cf:	e8 12 fc ff ff       	call   1005e6 <debuginfo_eip>
  1009d4:	85 c0                	test   %eax,%eax
  1009d6:	74 15                	je     1009ed <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1009db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009df:	c7 04 24 b6 37 10 00 	movl   $0x1037b6,(%esp)
  1009e6:	e8 92 f8 ff ff       	call   10027d <cprintf>
  1009eb:	eb 6d                	jmp    100a5a <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1009f4:	eb 1c                	jmp    100a12 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  1009f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1009f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009fc:	01 d0                	add    %edx,%eax
  1009fe:	0f b6 00             	movzbl (%eax),%eax
  100a01:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a0a:	01 ca                	add    %ecx,%edx
  100a0c:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100a12:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a15:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  100a18:	7f dc                	jg     1009f6 <print_debuginfo+0x3d>
        }
        fnname[j] = '\0';
  100a1a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a23:	01 d0                	add    %edx,%eax
  100a25:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  100a28:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a2b:	8b 55 08             	mov    0x8(%ebp),%edx
  100a2e:	89 d1                	mov    %edx,%ecx
  100a30:	29 c1                	sub    %eax,%ecx
  100a32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a35:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a38:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a3c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a42:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a46:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a4e:	c7 04 24 d2 37 10 00 	movl   $0x1037d2,(%esp)
  100a55:	e8 23 f8 ff ff       	call   10027d <cprintf>
    }
}
  100a5a:	c9                   	leave  
  100a5b:	c3                   	ret    

00100a5c <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a5c:	55                   	push   %ebp
  100a5d:	89 e5                	mov    %esp,%ebp
  100a5f:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a62:	8b 45 04             	mov    0x4(%ebp),%eax
  100a65:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a6b:	c9                   	leave  
  100a6c:	c3                   	ret    

00100a6d <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a6d:	55                   	push   %ebp
  100a6e:	89 e5                	mov    %esp,%ebp
  100a70:	53                   	push   %ebx
  100a71:	83 ec 44             	sub    $0x44,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a74:	89 e8                	mov    %ebp,%eax
  100a76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100a79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
     uint32_t ebp= read_ebp();//在bootmain.s中，初始ebp为0；
  100a7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     uint32_t eip= read_eip();
  100a7f:	e8 d8 ff ff ff       	call   100a5c <read_eip>
  100a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
     int tag=0;
  100a87:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     for ( tag = 0;tag<STACKFRAME_DEPTH&&ebp!=0; tag++)
  100a8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100a95:	e9 8d 00 00 00       	jmp    100b27 <print_stackframe+0xba>
     {
        cprintf("ebp:0x%08x,eip:0x%08x ",ebp,eip);
  100a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a9d:	89 44 24 08          	mov    %eax,0x8(%esp)
  100aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aa4:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aa8:	c7 04 24 e4 37 10 00 	movl   $0x1037e4,(%esp)
  100aaf:	e8 c9 f7 ff ff       	call   10027d <cprintf>
        uint32_t  *arg=(uint32_t *)(ebp+2);
  100ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ab7:	83 c0 02             	add    $0x2,%eax
  100aba:	89 45 e8             	mov    %eax,-0x18(%ebp)
        cprintf("arg[1]:0x%08x,arg[2]:0x%08x,arg[3]:0x%08x,arg[4]:0x%08x",arg[0],arg[1],arg[2],arg[3]);
  100abd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ac0:	83 c0 0c             	add    $0xc,%eax
  100ac3:	8b 18                	mov    (%eax),%ebx
  100ac5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ac8:	83 c0 08             	add    $0x8,%eax
  100acb:	8b 08                	mov    (%eax),%ecx
  100acd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ad0:	83 c0 04             	add    $0x4,%eax
  100ad3:	8b 10                	mov    (%eax),%edx
  100ad5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ad8:	8b 00                	mov    (%eax),%eax
  100ada:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  100ade:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100ae2:	89 54 24 08          	mov    %edx,0x8(%esp)
  100ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aea:	c7 04 24 fc 37 10 00 	movl   $0x1037fc,(%esp)
  100af1:	e8 87 f7 ff ff       	call   10027d <cprintf>
        cprintf("\n");
  100af6:	c7 04 24 34 38 10 00 	movl   $0x103834,(%esp)
  100afd:	e8 7b f7 ff ff       	call   10027d <cprintf>
        print_debuginfo(eip-1);
  100b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b05:	83 e8 01             	sub    $0x1,%eax
  100b08:	89 04 24             	mov    %eax,(%esp)
  100b0b:	e8 a9 fe ff ff       	call   1009b9 <print_debuginfo>
        eip=*((uint32_t*)ebp+1);//因为一直都有调用堆栈，eip的值其实就是esp
  100b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b13:	83 c0 04             	add    $0x4,%eax
  100b16:	8b 00                	mov    (%eax),%eax
  100b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp=*((uint32_t*)ebp);
  100b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b1e:	8b 00                	mov    (%eax),%eax
  100b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
     for ( tag = 0;tag<STACKFRAME_DEPTH&&ebp!=0; tag++)
  100b23:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100b27:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b2b:	7f 0a                	jg     100b37 <print_stackframe+0xca>
  100b2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b31:	0f 85 63 ff ff ff    	jne    100a9a <print_stackframe+0x2d>
     }
     
}
  100b37:	83 c4 44             	add    $0x44,%esp
  100b3a:	5b                   	pop    %ebx
  100b3b:	5d                   	pop    %ebp
  100b3c:	c3                   	ret    

00100b3d <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b3d:	55                   	push   %ebp
  100b3e:	89 e5                	mov    %esp,%ebp
  100b40:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b4a:	eb 0c                	jmp    100b58 <parse+0x1b>
            *buf ++ = '\0';
  100b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  100b4f:	8d 50 01             	lea    0x1(%eax),%edx
  100b52:	89 55 08             	mov    %edx,0x8(%ebp)
  100b55:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b58:	8b 45 08             	mov    0x8(%ebp),%eax
  100b5b:	0f b6 00             	movzbl (%eax),%eax
  100b5e:	84 c0                	test   %al,%al
  100b60:	74 1d                	je     100b7f <parse+0x42>
  100b62:	8b 45 08             	mov    0x8(%ebp),%eax
  100b65:	0f b6 00             	movzbl (%eax),%eax
  100b68:	0f be c0             	movsbl %al,%eax
  100b6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b6f:	c7 04 24 b8 38 10 00 	movl   $0x1038b8,(%esp)
  100b76:	e8 be 20 00 00       	call   102c39 <strchr>
  100b7b:	85 c0                	test   %eax,%eax
  100b7d:	75 cd                	jne    100b4c <parse+0xf>
        }
        if (*buf == '\0') {
  100b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b82:	0f b6 00             	movzbl (%eax),%eax
  100b85:	84 c0                	test   %al,%al
  100b87:	75 02                	jne    100b8b <parse+0x4e>
            break;
  100b89:	eb 67                	jmp    100bf2 <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b8b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b8f:	75 14                	jne    100ba5 <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b91:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100b98:	00 
  100b99:	c7 04 24 bd 38 10 00 	movl   $0x1038bd,(%esp)
  100ba0:	e8 d8 f6 ff ff       	call   10027d <cprintf>
        }
        argv[argc ++] = buf;
  100ba5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ba8:	8d 50 01             	lea    0x1(%eax),%edx
  100bab:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bb8:	01 c2                	add    %eax,%edx
  100bba:	8b 45 08             	mov    0x8(%ebp),%eax
  100bbd:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bbf:	eb 04                	jmp    100bc5 <parse+0x88>
            buf ++;
  100bc1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  100bc8:	0f b6 00             	movzbl (%eax),%eax
  100bcb:	84 c0                	test   %al,%al
  100bcd:	74 1d                	je     100bec <parse+0xaf>
  100bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  100bd2:	0f b6 00             	movzbl (%eax),%eax
  100bd5:	0f be c0             	movsbl %al,%eax
  100bd8:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bdc:	c7 04 24 b8 38 10 00 	movl   $0x1038b8,(%esp)
  100be3:	e8 51 20 00 00       	call   102c39 <strchr>
  100be8:	85 c0                	test   %eax,%eax
  100bea:	74 d5                	je     100bc1 <parse+0x84>
        }
    }
  100bec:	90                   	nop
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100bed:	e9 66 ff ff ff       	jmp    100b58 <parse+0x1b>
    return argc;
  100bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100bf5:	c9                   	leave  
  100bf6:	c3                   	ret    

00100bf7 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100bf7:	55                   	push   %ebp
  100bf8:	89 e5                	mov    %esp,%ebp
  100bfa:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100bfd:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c00:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c04:	8b 45 08             	mov    0x8(%ebp),%eax
  100c07:	89 04 24             	mov    %eax,(%esp)
  100c0a:	e8 2e ff ff ff       	call   100b3d <parse>
  100c0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c12:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c16:	75 0a                	jne    100c22 <runcmd+0x2b>
        return 0;
  100c18:	b8 00 00 00 00       	mov    $0x0,%eax
  100c1d:	e9 85 00 00 00       	jmp    100ca7 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c29:	eb 5c                	jmp    100c87 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c2b:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c31:	89 d0                	mov    %edx,%eax
  100c33:	01 c0                	add    %eax,%eax
  100c35:	01 d0                	add    %edx,%eax
  100c37:	c1 e0 02             	shl    $0x2,%eax
  100c3a:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c3f:	8b 00                	mov    (%eax),%eax
  100c41:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c45:	89 04 24             	mov    %eax,(%esp)
  100c48:	e8 4d 1f 00 00       	call   102b9a <strcmp>
  100c4d:	85 c0                	test   %eax,%eax
  100c4f:	75 32                	jne    100c83 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c51:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c54:	89 d0                	mov    %edx,%eax
  100c56:	01 c0                	add    %eax,%eax
  100c58:	01 d0                	add    %edx,%eax
  100c5a:	c1 e0 02             	shl    $0x2,%eax
  100c5d:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c62:	8b 40 08             	mov    0x8(%eax),%eax
  100c65:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100c68:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100c6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  100c6e:	89 54 24 08          	mov    %edx,0x8(%esp)
  100c72:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100c75:	83 c2 04             	add    $0x4,%edx
  100c78:	89 54 24 04          	mov    %edx,0x4(%esp)
  100c7c:	89 0c 24             	mov    %ecx,(%esp)
  100c7f:	ff d0                	call   *%eax
  100c81:	eb 24                	jmp    100ca7 <runcmd+0xb0>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c8a:	83 f8 02             	cmp    $0x2,%eax
  100c8d:	76 9c                	jbe    100c2b <runcmd+0x34>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c8f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c92:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c96:	c7 04 24 db 38 10 00 	movl   $0x1038db,(%esp)
  100c9d:	e8 db f5 ff ff       	call   10027d <cprintf>
    return 0;
  100ca2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ca7:	c9                   	leave  
  100ca8:	c3                   	ret    

00100ca9 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100ca9:	55                   	push   %ebp
  100caa:	89 e5                	mov    %esp,%ebp
  100cac:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100caf:	c7 04 24 f4 38 10 00 	movl   $0x1038f4,(%esp)
  100cb6:	e8 c2 f5 ff ff       	call   10027d <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cbb:	c7 04 24 1c 39 10 00 	movl   $0x10391c,(%esp)
  100cc2:	e8 b6 f5 ff ff       	call   10027d <cprintf>

    if (tf != NULL) {
  100cc7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100ccb:	74 0b                	je     100cd8 <kmonitor+0x2f>
        print_trapframe(tf);
  100ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  100cd0:	89 04 24             	mov    %eax,(%esp)
  100cd3:	e8 17 0d 00 00       	call   1019ef <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100cd8:	c7 04 24 41 39 10 00 	movl   $0x103941,(%esp)
  100cdf:	e8 3a f6 ff ff       	call   10031e <readline>
  100ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100ce7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100ceb:	74 18                	je     100d05 <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100ced:	8b 45 08             	mov    0x8(%ebp),%eax
  100cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cf7:	89 04 24             	mov    %eax,(%esp)
  100cfa:	e8 f8 fe ff ff       	call   100bf7 <runcmd>
  100cff:	85 c0                	test   %eax,%eax
  100d01:	79 02                	jns    100d05 <kmonitor+0x5c>
                break;
  100d03:	eb 02                	jmp    100d07 <kmonitor+0x5e>
            }
        }
    }
  100d05:	eb d1                	jmp    100cd8 <kmonitor+0x2f>
}
  100d07:	c9                   	leave  
  100d08:	c3                   	ret    

00100d09 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d09:	55                   	push   %ebp
  100d0a:	89 e5                	mov    %esp,%ebp
  100d0c:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d16:	eb 3f                	jmp    100d57 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d1b:	89 d0                	mov    %edx,%eax
  100d1d:	01 c0                	add    %eax,%eax
  100d1f:	01 d0                	add    %edx,%eax
  100d21:	c1 e0 02             	shl    $0x2,%eax
  100d24:	05 00 e0 10 00       	add    $0x10e000,%eax
  100d29:	8b 48 04             	mov    0x4(%eax),%ecx
  100d2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d2f:	89 d0                	mov    %edx,%eax
  100d31:	01 c0                	add    %eax,%eax
  100d33:	01 d0                	add    %edx,%eax
  100d35:	c1 e0 02             	shl    $0x2,%eax
  100d38:	05 00 e0 10 00       	add    $0x10e000,%eax
  100d3d:	8b 00                	mov    (%eax),%eax
  100d3f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d43:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d47:	c7 04 24 45 39 10 00 	movl   $0x103945,(%esp)
  100d4e:	e8 2a f5 ff ff       	call   10027d <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d5a:	83 f8 02             	cmp    $0x2,%eax
  100d5d:	76 b9                	jbe    100d18 <mon_help+0xf>
    }
    return 0;
  100d5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d64:	c9                   	leave  
  100d65:	c3                   	ret    

00100d66 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d66:	55                   	push   %ebp
  100d67:	89 e5                	mov    %esp,%ebp
  100d69:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d6c:	e8 b2 fb ff ff       	call   100923 <print_kerninfo>
    return 0;
  100d71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d76:	c9                   	leave  
  100d77:	c3                   	ret    

00100d78 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d78:	55                   	push   %ebp
  100d79:	89 e5                	mov    %esp,%ebp
  100d7b:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d7e:	e8 ea fc ff ff       	call   100a6d <print_stackframe>
    return 0;
  100d83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d88:	c9                   	leave  
  100d89:	c3                   	ret    

00100d8a <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d8a:	55                   	push   %ebp
  100d8b:	89 e5                	mov    %esp,%ebp
  100d8d:	83 ec 28             	sub    $0x28,%esp
  100d90:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100d96:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d9a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100d9e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100da2:	ee                   	out    %al,(%dx)
  100da3:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100da9:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100dad:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100db1:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100db5:	ee                   	out    %al,(%dx)
  100db6:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100dbc:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100dc0:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dc4:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dc8:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100dc9:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100dd0:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100dd3:	c7 04 24 4e 39 10 00 	movl   $0x10394e,(%esp)
  100dda:	e8 9e f4 ff ff       	call   10027d <cprintf>
    pic_enable(IRQ_TIMER);
  100ddf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100de6:	e8 b5 08 00 00       	call   1016a0 <pic_enable>
}
  100deb:	c9                   	leave  
  100dec:	c3                   	ret    

00100ded <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100ded:	55                   	push   %ebp
  100dee:	89 e5                	mov    %esp,%ebp
  100df0:	83 ec 10             	sub    $0x10,%esp
  100df3:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100df9:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100dfd:	89 c2                	mov    %eax,%edx
  100dff:	ec                   	in     (%dx),%al
  100e00:	88 45 fd             	mov    %al,-0x3(%ebp)
  100e03:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e09:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e0d:	89 c2                	mov    %eax,%edx
  100e0f:	ec                   	in     (%dx),%al
  100e10:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e13:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e19:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e1d:	89 c2                	mov    %eax,%edx
  100e1f:	ec                   	in     (%dx),%al
  100e20:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e23:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100e29:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e2d:	89 c2                	mov    %eax,%edx
  100e2f:	ec                   	in     (%dx),%al
  100e30:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e33:	c9                   	leave  
  100e34:	c3                   	ret    

00100e35 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e35:	55                   	push   %ebp
  100e36:	89 e5                	mov    %esp,%ebp
  100e38:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e3b:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e45:	0f b7 00             	movzwl (%eax),%eax
  100e48:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e4f:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e57:	0f b7 00             	movzwl (%eax),%eax
  100e5a:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e5e:	74 12                	je     100e72 <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100e60:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100e67:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e6e:	b4 03 
  100e70:	eb 13                	jmp    100e85 <cga_init+0x50>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100e72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e75:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e79:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100e7c:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e83:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100e85:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e8c:	0f b7 c0             	movzwl %ax,%eax
  100e8f:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100e93:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e97:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e9b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e9f:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100ea0:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ea7:	83 c0 01             	add    $0x1,%eax
  100eaa:	0f b7 c0             	movzwl %ax,%eax
  100ead:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100eb1:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100eb5:	89 c2                	mov    %eax,%edx
  100eb7:	ec                   	in     (%dx),%al
  100eb8:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100ebb:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100ebf:	0f b6 c0             	movzbl %al,%eax
  100ec2:	c1 e0 08             	shl    $0x8,%eax
  100ec5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ec8:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ecf:	0f b7 c0             	movzwl %ax,%eax
  100ed2:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100ed6:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100eda:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ede:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ee2:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100ee3:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100eea:	83 c0 01             	add    $0x1,%eax
  100eed:	0f b7 c0             	movzwl %ax,%eax
  100ef0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ef4:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100ef8:	89 c2                	mov    %eax,%edx
  100efa:	ec                   	in     (%dx),%al
  100efb:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100efe:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f02:	0f b6 c0             	movzbl %al,%eax
  100f05:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f0b:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f13:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100f19:	c9                   	leave  
  100f1a:	c3                   	ret    

00100f1b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f1b:	55                   	push   %ebp
  100f1c:	89 e5                	mov    %esp,%ebp
  100f1e:	83 ec 48             	sub    $0x48,%esp
  100f21:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100f27:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f2b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f2f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f33:	ee                   	out    %al,(%dx)
  100f34:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100f3a:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100f3e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f42:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f46:	ee                   	out    %al,(%dx)
  100f47:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100f4d:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100f51:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f55:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f59:	ee                   	out    %al,(%dx)
  100f5a:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f60:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100f64:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f68:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f6c:	ee                   	out    %al,(%dx)
  100f6d:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100f73:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100f77:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f7b:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f7f:	ee                   	out    %al,(%dx)
  100f80:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100f86:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100f8a:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100f8e:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100f92:	ee                   	out    %al,(%dx)
  100f93:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f99:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100f9d:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fa1:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fa5:	ee                   	out    %al,(%dx)
  100fa6:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fac:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100fb0:	89 c2                	mov    %eax,%edx
  100fb2:	ec                   	in     (%dx),%al
  100fb3:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100fb6:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100fba:	3c ff                	cmp    $0xff,%al
  100fbc:	0f 95 c0             	setne  %al
  100fbf:	0f b6 c0             	movzbl %al,%eax
  100fc2:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100fc7:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fcd:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100fd1:	89 c2                	mov    %eax,%edx
  100fd3:	ec                   	in     (%dx),%al
  100fd4:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100fd7:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100fdd:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100fe1:	89 c2                	mov    %eax,%edx
  100fe3:	ec                   	in     (%dx),%al
  100fe4:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100fe7:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100fec:	85 c0                	test   %eax,%eax
  100fee:	74 0c                	je     100ffc <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  100ff0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  100ff7:	e8 a4 06 00 00       	call   1016a0 <pic_enable>
    }
}
  100ffc:	c9                   	leave  
  100ffd:	c3                   	ret    

00100ffe <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100ffe:	55                   	push   %ebp
  100fff:	89 e5                	mov    %esp,%ebp
  101001:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101004:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10100b:	eb 09                	jmp    101016 <lpt_putc_sub+0x18>
        delay();
  10100d:	e8 db fd ff ff       	call   100ded <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101012:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101016:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10101c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101020:	89 c2                	mov    %eax,%edx
  101022:	ec                   	in     (%dx),%al
  101023:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101026:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10102a:	84 c0                	test   %al,%al
  10102c:	78 09                	js     101037 <lpt_putc_sub+0x39>
  10102e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101035:	7e d6                	jle    10100d <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
  101037:	8b 45 08             	mov    0x8(%ebp),%eax
  10103a:	0f b6 c0             	movzbl %al,%eax
  10103d:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  101043:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101046:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10104a:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10104e:	ee                   	out    %al,(%dx)
  10104f:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101055:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101059:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10105d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101061:	ee                   	out    %al,(%dx)
  101062:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  101068:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  10106c:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101070:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101074:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101075:	c9                   	leave  
  101076:	c3                   	ret    

00101077 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101077:	55                   	push   %ebp
  101078:	89 e5                	mov    %esp,%ebp
  10107a:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10107d:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101081:	74 0d                	je     101090 <lpt_putc+0x19>
        lpt_putc_sub(c);
  101083:	8b 45 08             	mov    0x8(%ebp),%eax
  101086:	89 04 24             	mov    %eax,(%esp)
  101089:	e8 70 ff ff ff       	call   100ffe <lpt_putc_sub>
  10108e:	eb 24                	jmp    1010b4 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  101090:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101097:	e8 62 ff ff ff       	call   100ffe <lpt_putc_sub>
        lpt_putc_sub(' ');
  10109c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010a3:	e8 56 ff ff ff       	call   100ffe <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010a8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010af:	e8 4a ff ff ff       	call   100ffe <lpt_putc_sub>
    }
}
  1010b4:	c9                   	leave  
  1010b5:	c3                   	ret    

001010b6 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1010b6:	55                   	push   %ebp
  1010b7:	89 e5                	mov    %esp,%ebp
  1010b9:	53                   	push   %ebx
  1010ba:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  1010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1010c0:	b0 00                	mov    $0x0,%al
  1010c2:	85 c0                	test   %eax,%eax
  1010c4:	75 07                	jne    1010cd <cga_putc+0x17>
        c |= 0x0700;
  1010c6:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1010d0:	0f b6 c0             	movzbl %al,%eax
  1010d3:	83 f8 0a             	cmp    $0xa,%eax
  1010d6:	74 4c                	je     101124 <cga_putc+0x6e>
  1010d8:	83 f8 0d             	cmp    $0xd,%eax
  1010db:	74 57                	je     101134 <cga_putc+0x7e>
  1010dd:	83 f8 08             	cmp    $0x8,%eax
  1010e0:	0f 85 88 00 00 00    	jne    10116e <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  1010e6:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010ed:	66 85 c0             	test   %ax,%ax
  1010f0:	74 30                	je     101122 <cga_putc+0x6c>
            crt_pos --;
  1010f2:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010f9:	83 e8 01             	sub    $0x1,%eax
  1010fc:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101102:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101107:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  10110e:	0f b7 d2             	movzwl %dx,%edx
  101111:	01 d2                	add    %edx,%edx
  101113:	01 c2                	add    %eax,%edx
  101115:	8b 45 08             	mov    0x8(%ebp),%eax
  101118:	b0 00                	mov    $0x0,%al
  10111a:	83 c8 20             	or     $0x20,%eax
  10111d:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  101120:	eb 72                	jmp    101194 <cga_putc+0xde>
  101122:	eb 70                	jmp    101194 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101124:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10112b:	83 c0 50             	add    $0x50,%eax
  10112e:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101134:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  10113b:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  101142:	0f b7 c1             	movzwl %cx,%eax
  101145:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10114b:	c1 e8 10             	shr    $0x10,%eax
  10114e:	89 c2                	mov    %eax,%edx
  101150:	66 c1 ea 06          	shr    $0x6,%dx
  101154:	89 d0                	mov    %edx,%eax
  101156:	c1 e0 02             	shl    $0x2,%eax
  101159:	01 d0                	add    %edx,%eax
  10115b:	c1 e0 04             	shl    $0x4,%eax
  10115e:	29 c1                	sub    %eax,%ecx
  101160:	89 ca                	mov    %ecx,%edx
  101162:	89 d8                	mov    %ebx,%eax
  101164:	29 d0                	sub    %edx,%eax
  101166:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  10116c:	eb 26                	jmp    101194 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10116e:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101174:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10117b:	8d 50 01             	lea    0x1(%eax),%edx
  10117e:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101185:	0f b7 c0             	movzwl %ax,%eax
  101188:	01 c0                	add    %eax,%eax
  10118a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  10118d:	8b 45 08             	mov    0x8(%ebp),%eax
  101190:	66 89 02             	mov    %ax,(%edx)
        break;
  101193:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101194:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10119b:	66 3d cf 07          	cmp    $0x7cf,%ax
  10119f:	76 5b                	jbe    1011fc <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1011a1:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011a6:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1011ac:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011b1:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1011b8:	00 
  1011b9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1011bd:	89 04 24             	mov    %eax,(%esp)
  1011c0:	e8 72 1c 00 00       	call   102e37 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011c5:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1011cc:	eb 15                	jmp    1011e3 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  1011ce:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1011d6:	01 d2                	add    %edx,%edx
  1011d8:	01 d0                	add    %edx,%eax
  1011da:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1011e3:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1011ea:	7e e2                	jle    1011ce <cga_putc+0x118>
        }
        crt_pos -= CRT_COLS;
  1011ec:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011f3:	83 e8 50             	sub    $0x50,%eax
  1011f6:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1011fc:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101203:	0f b7 c0             	movzwl %ax,%eax
  101206:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  10120a:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  10120e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101212:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101216:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101217:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10121e:	66 c1 e8 08          	shr    $0x8,%ax
  101222:	0f b6 c0             	movzbl %al,%eax
  101225:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10122c:	83 c2 01             	add    $0x1,%edx
  10122f:	0f b7 d2             	movzwl %dx,%edx
  101232:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101236:	88 45 ed             	mov    %al,-0x13(%ebp)
  101239:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10123d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101241:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101242:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101249:	0f b7 c0             	movzwl %ax,%eax
  10124c:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  101250:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101254:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101258:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10125c:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10125d:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101264:	0f b6 c0             	movzbl %al,%eax
  101267:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10126e:	83 c2 01             	add    $0x1,%edx
  101271:	0f b7 d2             	movzwl %dx,%edx
  101274:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  101278:	88 45 e5             	mov    %al,-0x1b(%ebp)
  10127b:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10127f:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101283:	ee                   	out    %al,(%dx)
}
  101284:	83 c4 34             	add    $0x34,%esp
  101287:	5b                   	pop    %ebx
  101288:	5d                   	pop    %ebp
  101289:	c3                   	ret    

0010128a <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10128a:	55                   	push   %ebp
  10128b:	89 e5                	mov    %esp,%ebp
  10128d:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101290:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101297:	eb 09                	jmp    1012a2 <serial_putc_sub+0x18>
        delay();
  101299:	e8 4f fb ff ff       	call   100ded <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10129e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012a2:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012a8:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1012ac:	89 c2                	mov    %eax,%edx
  1012ae:	ec                   	in     (%dx),%al
  1012af:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1012b2:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1012b6:	0f b6 c0             	movzbl %al,%eax
  1012b9:	83 e0 20             	and    $0x20,%eax
  1012bc:	85 c0                	test   %eax,%eax
  1012be:	75 09                	jne    1012c9 <serial_putc_sub+0x3f>
  1012c0:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1012c7:	7e d0                	jle    101299 <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
  1012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1012cc:	0f b6 c0             	movzbl %al,%eax
  1012cf:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1012d5:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012d8:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012dc:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012e0:	ee                   	out    %al,(%dx)
}
  1012e1:	c9                   	leave  
  1012e2:	c3                   	ret    

001012e3 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1012e3:	55                   	push   %ebp
  1012e4:	89 e5                	mov    %esp,%ebp
  1012e6:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1012e9:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012ed:	74 0d                	je     1012fc <serial_putc+0x19>
        serial_putc_sub(c);
  1012ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1012f2:	89 04 24             	mov    %eax,(%esp)
  1012f5:	e8 90 ff ff ff       	call   10128a <serial_putc_sub>
  1012fa:	eb 24                	jmp    101320 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  1012fc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101303:	e8 82 ff ff ff       	call   10128a <serial_putc_sub>
        serial_putc_sub(' ');
  101308:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10130f:	e8 76 ff ff ff       	call   10128a <serial_putc_sub>
        serial_putc_sub('\b');
  101314:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10131b:	e8 6a ff ff ff       	call   10128a <serial_putc_sub>
    }
}
  101320:	c9                   	leave  
  101321:	c3                   	ret    

00101322 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101322:	55                   	push   %ebp
  101323:	89 e5                	mov    %esp,%ebp
  101325:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101328:	eb 33                	jmp    10135d <cons_intr+0x3b>
        if (c != 0) {
  10132a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10132e:	74 2d                	je     10135d <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  101330:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101335:	8d 50 01             	lea    0x1(%eax),%edx
  101338:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10133e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101341:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101347:	a1 84 f0 10 00       	mov    0x10f084,%eax
  10134c:	3d 00 02 00 00       	cmp    $0x200,%eax
  101351:	75 0a                	jne    10135d <cons_intr+0x3b>
                cons.wpos = 0;
  101353:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  10135a:	00 00 00 
    while ((c = (*proc)()) != -1) {
  10135d:	8b 45 08             	mov    0x8(%ebp),%eax
  101360:	ff d0                	call   *%eax
  101362:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101365:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101369:	75 bf                	jne    10132a <cons_intr+0x8>
            }
        }
    }
}
  10136b:	c9                   	leave  
  10136c:	c3                   	ret    

0010136d <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10136d:	55                   	push   %ebp
  10136e:	89 e5                	mov    %esp,%ebp
  101370:	83 ec 10             	sub    $0x10,%esp
  101373:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101379:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10137d:	89 c2                	mov    %eax,%edx
  10137f:	ec                   	in     (%dx),%al
  101380:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101383:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101387:	0f b6 c0             	movzbl %al,%eax
  10138a:	83 e0 01             	and    $0x1,%eax
  10138d:	85 c0                	test   %eax,%eax
  10138f:	75 07                	jne    101398 <serial_proc_data+0x2b>
        return -1;
  101391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101396:	eb 2a                	jmp    1013c2 <serial_proc_data+0x55>
  101398:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10139e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1013a2:	89 c2                	mov    %eax,%edx
  1013a4:	ec                   	in     (%dx),%al
  1013a5:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1013a8:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1013ac:	0f b6 c0             	movzbl %al,%eax
  1013af:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1013b2:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1013b6:	75 07                	jne    1013bf <serial_proc_data+0x52>
        c = '\b';
  1013b8:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  1013bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1013c2:	c9                   	leave  
  1013c3:	c3                   	ret    

001013c4 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1013c4:	55                   	push   %ebp
  1013c5:	89 e5                	mov    %esp,%ebp
  1013c7:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  1013ca:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1013cf:	85 c0                	test   %eax,%eax
  1013d1:	74 0c                	je     1013df <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1013d3:	c7 04 24 6d 13 10 00 	movl   $0x10136d,(%esp)
  1013da:	e8 43 ff ff ff       	call   101322 <cons_intr>
    }
}
  1013df:	c9                   	leave  
  1013e0:	c3                   	ret    

001013e1 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1013e1:	55                   	push   %ebp
  1013e2:	89 e5                	mov    %esp,%ebp
  1013e4:	83 ec 38             	sub    $0x38,%esp
  1013e7:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013ed:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1013f1:	89 c2                	mov    %eax,%edx
  1013f3:	ec                   	in     (%dx),%al
  1013f4:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1013f7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1013fb:	0f b6 c0             	movzbl %al,%eax
  1013fe:	83 e0 01             	and    $0x1,%eax
  101401:	85 c0                	test   %eax,%eax
  101403:	75 0a                	jne    10140f <kbd_proc_data+0x2e>
        return -1;
  101405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10140a:	e9 59 01 00 00       	jmp    101568 <kbd_proc_data+0x187>
  10140f:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101415:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101419:	89 c2                	mov    %eax,%edx
  10141b:	ec                   	in     (%dx),%al
  10141c:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10141f:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101423:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101426:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10142a:	75 17                	jne    101443 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  10142c:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101431:	83 c8 40             	or     $0x40,%eax
  101434:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101439:	b8 00 00 00 00       	mov    $0x0,%eax
  10143e:	e9 25 01 00 00       	jmp    101568 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  101443:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101447:	84 c0                	test   %al,%al
  101449:	79 47                	jns    101492 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  10144b:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101450:	83 e0 40             	and    $0x40,%eax
  101453:	85 c0                	test   %eax,%eax
  101455:	75 09                	jne    101460 <kbd_proc_data+0x7f>
  101457:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10145b:	83 e0 7f             	and    $0x7f,%eax
  10145e:	eb 04                	jmp    101464 <kbd_proc_data+0x83>
  101460:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101464:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101467:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10146b:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101472:	83 c8 40             	or     $0x40,%eax
  101475:	0f b6 c0             	movzbl %al,%eax
  101478:	f7 d0                	not    %eax
  10147a:	89 c2                	mov    %eax,%edx
  10147c:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101481:	21 d0                	and    %edx,%eax
  101483:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101488:	b8 00 00 00 00       	mov    $0x0,%eax
  10148d:	e9 d6 00 00 00       	jmp    101568 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101492:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101497:	83 e0 40             	and    $0x40,%eax
  10149a:	85 c0                	test   %eax,%eax
  10149c:	74 11                	je     1014af <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10149e:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  1014a2:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014a7:	83 e0 bf             	and    $0xffffffbf,%eax
  1014aa:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  1014af:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014b3:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1014ba:	0f b6 d0             	movzbl %al,%edx
  1014bd:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014c2:	09 d0                	or     %edx,%eax
  1014c4:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1014c9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014cd:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1014d4:	0f b6 d0             	movzbl %al,%edx
  1014d7:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014dc:	31 d0                	xor    %edx,%eax
  1014de:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1014e3:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014e8:	83 e0 03             	and    $0x3,%eax
  1014eb:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1014f2:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f6:	01 d0                	add    %edx,%eax
  1014f8:	0f b6 00             	movzbl (%eax),%eax
  1014fb:	0f b6 c0             	movzbl %al,%eax
  1014fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101501:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101506:	83 e0 08             	and    $0x8,%eax
  101509:	85 c0                	test   %eax,%eax
  10150b:	74 22                	je     10152f <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  10150d:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101511:	7e 0c                	jle    10151f <kbd_proc_data+0x13e>
  101513:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101517:	7f 06                	jg     10151f <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  101519:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10151d:	eb 10                	jmp    10152f <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  10151f:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101523:	7e 0a                	jle    10152f <kbd_proc_data+0x14e>
  101525:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101529:	7f 04                	jg     10152f <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  10152b:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10152f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101534:	f7 d0                	not    %eax
  101536:	83 e0 06             	and    $0x6,%eax
  101539:	85 c0                	test   %eax,%eax
  10153b:	75 28                	jne    101565 <kbd_proc_data+0x184>
  10153d:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101544:	75 1f                	jne    101565 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  101546:	c7 04 24 69 39 10 00 	movl   $0x103969,(%esp)
  10154d:	e8 2b ed ff ff       	call   10027d <cprintf>
  101552:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101558:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10155c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101560:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101564:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101565:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101568:	c9                   	leave  
  101569:	c3                   	ret    

0010156a <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10156a:	55                   	push   %ebp
  10156b:	89 e5                	mov    %esp,%ebp
  10156d:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  101570:	c7 04 24 e1 13 10 00 	movl   $0x1013e1,(%esp)
  101577:	e8 a6 fd ff ff       	call   101322 <cons_intr>
}
  10157c:	c9                   	leave  
  10157d:	c3                   	ret    

0010157e <kbd_init>:

static void
kbd_init(void) {
  10157e:	55                   	push   %ebp
  10157f:	89 e5                	mov    %esp,%ebp
  101581:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101584:	e8 e1 ff ff ff       	call   10156a <kbd_intr>
    pic_enable(IRQ_KBD);
  101589:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101590:	e8 0b 01 00 00       	call   1016a0 <pic_enable>
}
  101595:	c9                   	leave  
  101596:	c3                   	ret    

00101597 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101597:	55                   	push   %ebp
  101598:	89 e5                	mov    %esp,%ebp
  10159a:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  10159d:	e8 93 f8 ff ff       	call   100e35 <cga_init>
    serial_init();
  1015a2:	e8 74 f9 ff ff       	call   100f1b <serial_init>
    kbd_init();
  1015a7:	e8 d2 ff ff ff       	call   10157e <kbd_init>
    if (!serial_exists) {
  1015ac:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1015b1:	85 c0                	test   %eax,%eax
  1015b3:	75 0c                	jne    1015c1 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  1015b5:	c7 04 24 75 39 10 00 	movl   $0x103975,(%esp)
  1015bc:	e8 bc ec ff ff       	call   10027d <cprintf>
    }
}
  1015c1:	c9                   	leave  
  1015c2:	c3                   	ret    

001015c3 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1015c3:	55                   	push   %ebp
  1015c4:	89 e5                	mov    %esp,%ebp
  1015c6:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  1015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1015cc:	89 04 24             	mov    %eax,(%esp)
  1015cf:	e8 a3 fa ff ff       	call   101077 <lpt_putc>
    cga_putc(c);
  1015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  1015d7:	89 04 24             	mov    %eax,(%esp)
  1015da:	e8 d7 fa ff ff       	call   1010b6 <cga_putc>
    serial_putc(c);
  1015df:	8b 45 08             	mov    0x8(%ebp),%eax
  1015e2:	89 04 24             	mov    %eax,(%esp)
  1015e5:	e8 f9 fc ff ff       	call   1012e3 <serial_putc>
}
  1015ea:	c9                   	leave  
  1015eb:	c3                   	ret    

001015ec <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1015ec:	55                   	push   %ebp
  1015ed:	89 e5                	mov    %esp,%ebp
  1015ef:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1015f2:	e8 cd fd ff ff       	call   1013c4 <serial_intr>
    kbd_intr();
  1015f7:	e8 6e ff ff ff       	call   10156a <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1015fc:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  101602:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101607:	39 c2                	cmp    %eax,%edx
  101609:	74 36                	je     101641 <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  10160b:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101610:	8d 50 01             	lea    0x1(%eax),%edx
  101613:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  101619:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  101620:	0f b6 c0             	movzbl %al,%eax
  101623:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101626:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10162b:	3d 00 02 00 00       	cmp    $0x200,%eax
  101630:	75 0a                	jne    10163c <cons_getc+0x50>
            cons.rpos = 0;
  101632:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101639:	00 00 00 
        }
        return c;
  10163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10163f:	eb 05                	jmp    101646 <cons_getc+0x5a>
    }
    return 0;
  101641:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101646:	c9                   	leave  
  101647:	c3                   	ret    

00101648 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101648:	55                   	push   %ebp
  101649:	89 e5                	mov    %esp,%ebp
  10164b:	83 ec 14             	sub    $0x14,%esp
  10164e:	8b 45 08             	mov    0x8(%ebp),%eax
  101651:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101655:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101659:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  10165f:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  101664:	85 c0                	test   %eax,%eax
  101666:	74 36                	je     10169e <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101668:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10166c:	0f b6 c0             	movzbl %al,%eax
  10166f:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101675:	88 45 fd             	mov    %al,-0x3(%ebp)
  101678:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10167c:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101680:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101681:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101685:	66 c1 e8 08          	shr    $0x8,%ax
  101689:	0f b6 c0             	movzbl %al,%eax
  10168c:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  101692:	88 45 f9             	mov    %al,-0x7(%ebp)
  101695:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101699:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10169d:	ee                   	out    %al,(%dx)
    }
}
  10169e:	c9                   	leave  
  10169f:	c3                   	ret    

001016a0 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1016a0:	55                   	push   %ebp
  1016a1:	89 e5                	mov    %esp,%ebp
  1016a3:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  1016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1016a9:	ba 01 00 00 00       	mov    $0x1,%edx
  1016ae:	89 c1                	mov    %eax,%ecx
  1016b0:	d3 e2                	shl    %cl,%edx
  1016b2:	89 d0                	mov    %edx,%eax
  1016b4:	f7 d0                	not    %eax
  1016b6:	89 c2                	mov    %eax,%edx
  1016b8:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016bf:	21 d0                	and    %edx,%eax
  1016c1:	0f b7 c0             	movzwl %ax,%eax
  1016c4:	89 04 24             	mov    %eax,(%esp)
  1016c7:	e8 7c ff ff ff       	call   101648 <pic_setmask>
}
  1016cc:	c9                   	leave  
  1016cd:	c3                   	ret    

001016ce <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1016ce:	55                   	push   %ebp
  1016cf:	89 e5                	mov    %esp,%ebp
  1016d1:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1016d4:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1016db:	00 00 00 
  1016de:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  1016e4:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  1016e8:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1016ec:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016f0:	ee                   	out    %al,(%dx)
  1016f1:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016f7:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  1016fb:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016ff:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101703:	ee                   	out    %al,(%dx)
  101704:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10170a:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  10170e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101712:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101716:	ee                   	out    %al,(%dx)
  101717:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  10171d:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  101721:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101725:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101729:	ee                   	out    %al,(%dx)
  10172a:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  101730:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  101734:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101738:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10173c:	ee                   	out    %al,(%dx)
  10173d:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  101743:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  101747:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10174b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10174f:	ee                   	out    %al,(%dx)
  101750:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  101756:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  10175a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10175e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101762:	ee                   	out    %al,(%dx)
  101763:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101769:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  10176d:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101771:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101775:	ee                   	out    %al,(%dx)
  101776:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  10177c:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  101780:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101784:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101788:	ee                   	out    %al,(%dx)
  101789:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  10178f:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  101793:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101797:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10179b:	ee                   	out    %al,(%dx)
  10179c:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  1017a2:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  1017a6:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017aa:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017ae:	ee                   	out    %al,(%dx)
  1017af:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017b5:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  1017b9:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017bd:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017c1:	ee                   	out    %al,(%dx)
  1017c2:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1017c8:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1017cc:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017d0:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017d4:	ee                   	out    %al,(%dx)
  1017d5:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  1017db:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  1017df:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017e3:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017e7:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1017e8:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017ef:	66 83 f8 ff          	cmp    $0xffff,%ax
  1017f3:	74 12                	je     101807 <pic_init+0x139>
        pic_setmask(irq_mask);
  1017f5:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017fc:	0f b7 c0             	movzwl %ax,%eax
  1017ff:	89 04 24             	mov    %eax,(%esp)
  101802:	e8 41 fe ff ff       	call   101648 <pic_setmask>
    }
}
  101807:	c9                   	leave  
  101808:	c3                   	ret    

00101809 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101809:	55                   	push   %ebp
  10180a:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  10180c:	fb                   	sti    
    sti();
}
  10180d:	5d                   	pop    %ebp
  10180e:	c3                   	ret    

0010180f <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  10180f:	55                   	push   %ebp
  101810:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  101812:	fa                   	cli    
    cli();
}
  101813:	5d                   	pop    %ebp
  101814:	c3                   	ret    

00101815 <print_ticks>:
#include <string.h>
#define TICK_NUM 100

extern uintptr_t __vectors[];//存储着中断处理函数的地址

static void print_ticks() {
  101815:	55                   	push   %ebp
  101816:	89 e5                	mov    %esp,%ebp
  101818:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  10181b:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101822:	00 
  101823:	c7 04 24 a0 39 10 00 	movl   $0x1039a0,(%esp)
  10182a:	e8 4e ea ff ff       	call   10027d <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  10182f:	c9                   	leave  
  101830:	c3                   	ret    

00101831 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101831:	55                   	push   %ebp
  101832:	89 e5                	mov    %esp,%ebp
  101834:	83 ec 10             	sub    $0x10,%esp
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
        //从0-256 
        int i=0;
  101837:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
        for (i = 0; i < 256; i++)
  10183e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101845:	e9 c3 00 00 00       	jmp    10190d <idt_init+0xdc>
        {
            SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);//gate--idt[i]      默认为interrupt gate   sel--段选择子  off--偏移量  dpl--权限，0-内核态
  10184a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10184d:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101854:	89 c2                	mov    %eax,%edx
  101856:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101859:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  101860:	00 
  101861:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101864:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  10186b:	00 08 00 
  10186e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101871:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101878:	00 
  101879:	83 e2 e0             	and    $0xffffffe0,%edx
  10187c:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101883:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101886:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10188d:	00 
  10188e:	83 e2 1f             	and    $0x1f,%edx
  101891:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101898:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10189b:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018a2:	00 
  1018a3:	83 e2 f0             	and    $0xfffffff0,%edx
  1018a6:	83 ca 0e             	or     $0xe,%edx
  1018a9:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b3:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018ba:	00 
  1018bb:	83 e2 ef             	and    $0xffffffef,%edx
  1018be:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018c8:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018cf:	00 
  1018d0:	83 e2 9f             	and    $0xffffff9f,%edx
  1018d3:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018dd:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018e4:	00 
  1018e5:	83 ca 80             	or     $0xffffff80,%edx
  1018e8:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018f2:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018f9:	c1 e8 10             	shr    $0x10,%eax
  1018fc:	89 c2                	mov    %eax,%edx
  1018fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101901:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  101908:	00 
        for (i = 0; i < 256; i++)
  101909:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10190d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  101914:	0f 8e 30 ff ff ff    	jle    10184a <idt_init+0x19>
        }
        //SETGATE(idt[T_SWITCH_TOK],0,GD_KDATA,DPL__USER);    单独修改此处作用
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  10191a:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  10191f:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  101925:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  10192c:	08 00 
  10192e:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101935:	83 e0 e0             	and    $0xffffffe0,%eax
  101938:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10193d:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101944:	83 e0 1f             	and    $0x1f,%eax
  101947:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10194c:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101953:	83 e0 f0             	and    $0xfffffff0,%eax
  101956:	83 c8 0e             	or     $0xe,%eax
  101959:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10195e:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101965:	83 e0 ef             	and    $0xffffffef,%eax
  101968:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10196d:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101974:	83 c8 60             	or     $0x60,%eax
  101977:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10197c:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101983:	83 c8 80             	or     $0xffffff80,%eax
  101986:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10198b:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  101990:	c1 e8 10             	shr    $0x10,%eax
  101993:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  101999:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  1019a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1019a3:	0f 01 18             	lidtl  (%eax)
    lidt(&idt_pd);//挂载idt表到ldtr寄存器中
}
  1019a6:	c9                   	leave  
  1019a7:	c3                   	ret    

001019a8 <trapname>:

static const char *
trapname(int trapno) {
  1019a8:	55                   	push   %ebp
  1019a9:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };
//判断中断类型
    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ae:	83 f8 13             	cmp    $0x13,%eax
  1019b1:	77 0c                	ja     1019bf <trapname+0x17>
        return excnames[trapno];
  1019b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1019b6:	8b 04 85 60 3d 10 00 	mov    0x103d60(,%eax,4),%eax
  1019bd:	eb 18                	jmp    1019d7 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1019bf:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  1019c3:	7e 0d                	jle    1019d2 <trapname+0x2a>
  1019c5:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1019c9:	7f 07                	jg     1019d2 <trapname+0x2a>
        return "Hardware Interrupt";
  1019cb:	b8 aa 39 10 00       	mov    $0x1039aa,%eax
  1019d0:	eb 05                	jmp    1019d7 <trapname+0x2f>
    }
    return "(unknown trap)";
  1019d2:	b8 bd 39 10 00       	mov    $0x1039bd,%eax
}
  1019d7:	5d                   	pop    %ebp
  1019d8:	c3                   	ret    

001019d9 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  1019d9:	55                   	push   %ebp
  1019da:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  1019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1019df:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1019e3:	66 83 f8 08          	cmp    $0x8,%ax
  1019e7:	0f 94 c0             	sete   %al
  1019ea:	0f b6 c0             	movzbl %al,%eax
}
  1019ed:	5d                   	pop    %ebp
  1019ee:	c3                   	ret    

001019ef <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  1019ef:	55                   	push   %ebp
  1019f0:	89 e5                	mov    %esp,%ebp
  1019f2:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  1019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1019f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019fc:	c7 04 24 fe 39 10 00 	movl   $0x1039fe,(%esp)
  101a03:	e8 75 e8 ff ff       	call   10027d <cprintf>
    print_regs(&tf->tf_regs);
  101a08:	8b 45 08             	mov    0x8(%ebp),%eax
  101a0b:	89 04 24             	mov    %eax,(%esp)
  101a0e:	e8 a1 01 00 00       	call   101bb4 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101a13:	8b 45 08             	mov    0x8(%ebp),%eax
  101a16:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101a1a:	0f b7 c0             	movzwl %ax,%eax
  101a1d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a21:	c7 04 24 0f 3a 10 00 	movl   $0x103a0f,(%esp)
  101a28:	e8 50 e8 ff ff       	call   10027d <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a30:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a34:	0f b7 c0             	movzwl %ax,%eax
  101a37:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a3b:	c7 04 24 22 3a 10 00 	movl   $0x103a22,(%esp)
  101a42:	e8 36 e8 ff ff       	call   10027d <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a47:	8b 45 08             	mov    0x8(%ebp),%eax
  101a4a:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a4e:	0f b7 c0             	movzwl %ax,%eax
  101a51:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a55:	c7 04 24 35 3a 10 00 	movl   $0x103a35,(%esp)
  101a5c:	e8 1c e8 ff ff       	call   10027d <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a61:	8b 45 08             	mov    0x8(%ebp),%eax
  101a64:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101a68:	0f b7 c0             	movzwl %ax,%eax
  101a6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a6f:	c7 04 24 48 3a 10 00 	movl   $0x103a48,(%esp)
  101a76:	e8 02 e8 ff ff       	call   10027d <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7e:	8b 40 30             	mov    0x30(%eax),%eax
  101a81:	89 04 24             	mov    %eax,(%esp)
  101a84:	e8 1f ff ff ff       	call   1019a8 <trapname>
  101a89:	8b 55 08             	mov    0x8(%ebp),%edx
  101a8c:	8b 52 30             	mov    0x30(%edx),%edx
  101a8f:	89 44 24 08          	mov    %eax,0x8(%esp)
  101a93:	89 54 24 04          	mov    %edx,0x4(%esp)
  101a97:	c7 04 24 5b 3a 10 00 	movl   $0x103a5b,(%esp)
  101a9e:	e8 da e7 ff ff       	call   10027d <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa6:	8b 40 34             	mov    0x34(%eax),%eax
  101aa9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aad:	c7 04 24 6d 3a 10 00 	movl   $0x103a6d,(%esp)
  101ab4:	e8 c4 e7 ff ff       	call   10027d <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  101abc:	8b 40 38             	mov    0x38(%eax),%eax
  101abf:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ac3:	c7 04 24 7c 3a 10 00 	movl   $0x103a7c,(%esp)
  101aca:	e8 ae e7 ff ff       	call   10027d <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101acf:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ad6:	0f b7 c0             	movzwl %ax,%eax
  101ad9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101add:	c7 04 24 8b 3a 10 00 	movl   $0x103a8b,(%esp)
  101ae4:	e8 94 e7 ff ff       	call   10027d <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  101aec:	8b 40 40             	mov    0x40(%eax),%eax
  101aef:	89 44 24 04          	mov    %eax,0x4(%esp)
  101af3:	c7 04 24 9e 3a 10 00 	movl   $0x103a9e,(%esp)
  101afa:	e8 7e e7 ff ff       	call   10027d <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101aff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b06:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b0d:	eb 3e                	jmp    101b4d <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  101b12:	8b 50 40             	mov    0x40(%eax),%edx
  101b15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b18:	21 d0                	and    %edx,%eax
  101b1a:	85 c0                	test   %eax,%eax
  101b1c:	74 28                	je     101b46 <print_trapframe+0x157>
  101b1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b21:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b28:	85 c0                	test   %eax,%eax
  101b2a:	74 1a                	je     101b46 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b2f:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b36:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3a:	c7 04 24 ad 3a 10 00 	movl   $0x103aad,(%esp)
  101b41:	e8 37 e7 ff ff       	call   10027d <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b46:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b4a:	d1 65 f0             	shll   -0x10(%ebp)
  101b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b50:	83 f8 17             	cmp    $0x17,%eax
  101b53:	76 ba                	jbe    101b0f <print_trapframe+0x120>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b55:	8b 45 08             	mov    0x8(%ebp),%eax
  101b58:	8b 40 40             	mov    0x40(%eax),%eax
  101b5b:	25 00 30 00 00       	and    $0x3000,%eax
  101b60:	c1 e8 0c             	shr    $0xc,%eax
  101b63:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b67:	c7 04 24 b1 3a 10 00 	movl   $0x103ab1,(%esp)
  101b6e:	e8 0a e7 ff ff       	call   10027d <cprintf>

    if (!trap_in_kernel(tf)) {
  101b73:	8b 45 08             	mov    0x8(%ebp),%eax
  101b76:	89 04 24             	mov    %eax,(%esp)
  101b79:	e8 5b fe ff ff       	call   1019d9 <trap_in_kernel>
  101b7e:	85 c0                	test   %eax,%eax
  101b80:	75 30                	jne    101bb2 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101b82:	8b 45 08             	mov    0x8(%ebp),%eax
  101b85:	8b 40 44             	mov    0x44(%eax),%eax
  101b88:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b8c:	c7 04 24 ba 3a 10 00 	movl   $0x103aba,(%esp)
  101b93:	e8 e5 e6 ff ff       	call   10027d <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101b98:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9b:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101b9f:	0f b7 c0             	movzwl %ax,%eax
  101ba2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba6:	c7 04 24 c9 3a 10 00 	movl   $0x103ac9,(%esp)
  101bad:	e8 cb e6 ff ff       	call   10027d <cprintf>
    }
}
  101bb2:	c9                   	leave  
  101bb3:	c3                   	ret    

00101bb4 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101bb4:	55                   	push   %ebp
  101bb5:	89 e5                	mov    %esp,%ebp
  101bb7:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101bba:	8b 45 08             	mov    0x8(%ebp),%eax
  101bbd:	8b 00                	mov    (%eax),%eax
  101bbf:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc3:	c7 04 24 dc 3a 10 00 	movl   $0x103adc,(%esp)
  101bca:	e8 ae e6 ff ff       	call   10027d <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd2:	8b 40 04             	mov    0x4(%eax),%eax
  101bd5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd9:	c7 04 24 eb 3a 10 00 	movl   $0x103aeb,(%esp)
  101be0:	e8 98 e6 ff ff       	call   10027d <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101be5:	8b 45 08             	mov    0x8(%ebp),%eax
  101be8:	8b 40 08             	mov    0x8(%eax),%eax
  101beb:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bef:	c7 04 24 fa 3a 10 00 	movl   $0x103afa,(%esp)
  101bf6:	e8 82 e6 ff ff       	call   10027d <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  101bfe:	8b 40 0c             	mov    0xc(%eax),%eax
  101c01:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c05:	c7 04 24 09 3b 10 00 	movl   $0x103b09,(%esp)
  101c0c:	e8 6c e6 ff ff       	call   10027d <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c11:	8b 45 08             	mov    0x8(%ebp),%eax
  101c14:	8b 40 10             	mov    0x10(%eax),%eax
  101c17:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c1b:	c7 04 24 18 3b 10 00 	movl   $0x103b18,(%esp)
  101c22:	e8 56 e6 ff ff       	call   10027d <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101c27:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2a:	8b 40 14             	mov    0x14(%eax),%eax
  101c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c31:	c7 04 24 27 3b 10 00 	movl   $0x103b27,(%esp)
  101c38:	e8 40 e6 ff ff       	call   10027d <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c40:	8b 40 18             	mov    0x18(%eax),%eax
  101c43:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c47:	c7 04 24 36 3b 10 00 	movl   $0x103b36,(%esp)
  101c4e:	e8 2a e6 ff ff       	call   10027d <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c53:	8b 45 08             	mov    0x8(%ebp),%eax
  101c56:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c59:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c5d:	c7 04 24 45 3b 10 00 	movl   $0x103b45,(%esp)
  101c64:	e8 14 e6 ff ff       	call   10027d <cprintf>
}
  101c69:	c9                   	leave  
  101c6a:	c3                   	ret    

00101c6b <switch2user>:

void switch2user(struct trapframe *tf)
{
  101c6b:	55                   	push   %ebp
  101c6c:	89 e5                	mov    %esp,%ebp
  101c6e:	57                   	push   %edi
  101c6f:	56                   	push   %esi
  101c70:	53                   	push   %ebx
  101c71:	83 ec 50             	sub    $0x50,%esp
  // eflags
  // 0x3000 = 00110000 00000000
  // 把nested task位置1，也就是可以嵌套
  tf->tf_eflags |= 0x3000;
  101c74:	8b 45 08             	mov    0x8(%ebp),%eax
  101c77:	8b 40 40             	mov    0x40(%eax),%eax
  101c7a:	80 cc 30             	or     $0x30,%ah
  101c7d:	89 c2                	mov    %eax,%edx
  101c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  101c82:	89 50 40             	mov    %edx,0x40(%eax)

  // USER_CS = 3 << 3 | 3 = 24 | 3 = 27 = 0x1B = 00011011;
  // 如果当前运行的程序不是在用户态的代码段执行（从内核切换过来肯定不会是）
  if (tf->tf_cs != USER_CS)
  101c85:	8b 45 08             	mov    0x8(%ebp),%eax
  101c88:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101c8c:	66 83 f8 1b          	cmp    $0x1b,%ax
  101c90:	74 4e                	je     101ce0 <switch2user+0x75>
  {
    struct trapframe switchk2u;
    switchk2u = *tf;
  101c92:	8b 45 08             	mov    0x8(%ebp),%eax
  101c95:	8d 55 a8             	lea    -0x58(%ebp),%edx
  101c98:	89 c3                	mov    %eax,%ebx
  101c9a:	b8 13 00 00 00       	mov    $0x13,%eax
  101c9f:	89 d7                	mov    %edx,%edi
  101ca1:	89 de                	mov    %ebx,%esi
  101ca3:	89 c1                	mov    %eax,%ecx
  101ca5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    switchk2u.tf_cs = USER_CS;
  101ca7:	66 c7 45 e4 1b 00    	movw   $0x1b,-0x1c(%ebp)
    // 设置数据段为USER_DS
    switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101cad:	66 c7 45 f0 23 00    	movw   $0x23,-0x10(%ebp)
  101cb3:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101cb7:	66 89 45 d0          	mov    %ax,-0x30(%ebp)
  101cbb:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  101cbf:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    // 因为内存是从高到低，
    // 而这是从内核态切换到用户态（没有ss,sp）
    // (uint32_t)tf + sizeof(struct trapframe) - 8 即 tf->tf_esp的地址
    // 也就是switchk2u.tf_esp，指向旧的tf_esp的值
    switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc6:	83 c0 44             	add    $0x44,%eax
  101cc9:	89 45 ec             	mov    %eax,-0x14(%ebp)

    //  eflags 设置IOPL
    switchk2u.tf_eflags |=FL_IOPL_MASK;
  101ccc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101ccf:	80 cc 30             	or     $0x30,%ah
  101cd2:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // (uint32_t *)tf是一个指针，指针的地址-1就
    // *((uint32_t *)tf - 1) 这个指针指向的地址设置为我们新樊笼出来的tss(switchk2u)

    *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  101cd8:	8d 50 fc             	lea    -0x4(%eax),%edx
  101cdb:	8d 45 a8             	lea    -0x58(%ebp),%eax
  101cde:	89 02                	mov    %eax,(%edx)
  }
}
  101ce0:	83 c4 50             	add    $0x50,%esp
  101ce3:	5b                   	pop    %ebx
  101ce4:	5e                   	pop    %esi
  101ce5:	5f                   	pop    %edi
  101ce6:	5d                   	pop    %ebp
  101ce7:	c3                   	ret    

00101ce8 <switch2kernel>:
void switch2kernel(struct trapframe *tf)
{
  101ce8:	55                   	push   %ebp
  101ce9:	89 e5                	mov    %esp,%ebp
  101ceb:	83 ec 28             	sub    $0x28,%esp
  if (tf->tf_cs != KERNEL_CS)
  101cee:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101cf5:	66 83 f8 08          	cmp    $0x8,%ax
  101cf9:	74 62                	je     101d5d <switch2kernel+0x75>
  {
    // 设置CS为 KERNEL_CS = 0x8 = 1000 =  00001|0|00 -> Index = 1, GDT, RPL = 0 
    tf->tf_cs = KERNEL_CS;
  101cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  101cfe:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
    // KERNEL_DS = 00010|0|00 -> Index = 2, GDT, RPL = 0 
    tf->tf_ds = tf->tf_es = KERNEL_DS;
  101d04:	8b 45 08             	mov    0x8(%ebp),%eax
  101d07:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101d10:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101d14:	8b 45 08             	mov    0x8(%ebp),%eax
  101d17:	66 89 50 2c          	mov    %dx,0x2c(%eax)
    // 也就是把IOPL设置为0
    // IOPL(bits 12 and 13) [I/O privilege level field]   
    // 指示当前运行任务的I/O特权级(I/O privilege level)，
    // 正在运行任务的当前特权级(CPL)必须小于或等于I/O特权级才能允许访问I/O地址空间。
    // 这个域只能在CPL为0时才能通过POPF以及IRET指令修改。
    tf->tf_eflags &= ~FL_IOPL_MASK;
  101d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d1e:	8b 40 40             	mov    0x40(%eax),%eax
  101d21:	80 e4 cf             	and    $0xcf,%ah
  101d24:	89 c2                	mov    %eax,%edx
  101d26:	8b 45 08             	mov    0x8(%ebp),%eax
  101d29:	89 50 40             	mov    %edx,0x40(%eax)
    struct trapframe *switchu2k;
    // 由于内存布局是从高到低，所以这里修改switchu2k，指向
    switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2f:	8b 40 44             	mov    0x44(%eax),%eax
  101d32:	83 e8 44             	sub    $0x44,%eax
  101d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
    * @n:        number of bytes to copy
    *
    * The memmove() function returns @dst.
    * */
    // 相当于是把tf，拷贝到switchu2k
    memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101d38:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101d3f:	00 
  101d40:	8b 45 08             	mov    0x8(%ebp),%eax
  101d43:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101d4a:	89 04 24             	mov    %eax,(%esp)
  101d4d:	e8 e5 10 00 00       	call   102e37 <memmove>

    // 修改tf - 1处，指向新的trapframe
    *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101d52:	8b 45 08             	mov    0x8(%ebp),%eax
  101d55:	8d 50 fc             	lea    -0x4(%eax),%edx
  101d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101d5b:	89 02                	mov    %eax,(%edx)
  }
  }
  101d5d:	c9                   	leave  
  101d5e:	c3                   	ret    

00101d5f <trap_dispatch>:
/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d5f:	55                   	push   %ebp
  101d60:	89 e5                	mov    %esp,%ebp
  101d62:	83 ec 28             	sub    $0x28,%esp
    char c;
    switch (tf->tf_trapno) //根据顺序可知，tf->trapno就是中断向量号
  101d65:	8b 45 08             	mov    0x8(%ebp),%eax
  101d68:	8b 40 30             	mov    0x30(%eax),%eax
  101d6b:	83 f8 2f             	cmp    $0x2f,%eax
  101d6e:	77 21                	ja     101d91 <trap_dispatch+0x32>
  101d70:	83 f8 2e             	cmp    $0x2e,%eax
  101d73:	0f 83 69 01 00 00    	jae    101ee2 <trap_dispatch+0x183>
  101d79:	83 f8 21             	cmp    $0x21,%eax
  101d7c:	0f 84 96 00 00 00    	je     101e18 <trap_dispatch+0xb9>
  101d82:	83 f8 24             	cmp    $0x24,%eax
  101d85:	74 68                	je     101def <trap_dispatch+0x90>
  101d87:	83 f8 20             	cmp    $0x20,%eax
  101d8a:	74 1c                	je     101da8 <trap_dispatch+0x49>
  101d8c:	e9 19 01 00 00       	jmp    101eaa <trap_dispatch+0x14b>
  101d91:	83 f8 78             	cmp    $0x78,%eax
  101d94:	0f 84 f6 00 00 00    	je     101e90 <trap_dispatch+0x131>
  101d9a:	83 f8 79             	cmp    $0x79,%eax
  101d9d:	0f 84 fa 00 00 00    	je     101e9d <trap_dispatch+0x13e>
  101da3:	e9 02 01 00 00       	jmp    101eaa <trap_dispatch+0x14b>
        /* handle the 时钟中断 */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  101da8:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101dad:	83 c0 01             	add    $0x1,%eax
  101db0:	a3 08 f9 10 00       	mov    %eax,0x10f908
        if (ticks%TICK_NUM==0)
  101db5:	8b 0d 08 f9 10 00    	mov    0x10f908,%ecx
  101dbb:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101dc0:	89 c8                	mov    %ecx,%eax
  101dc2:	f7 e2                	mul    %edx
  101dc4:	89 d0                	mov    %edx,%eax
  101dc6:	c1 e8 05             	shr    $0x5,%eax
  101dc9:	6b c0 64             	imul   $0x64,%eax,%eax
  101dcc:	29 c1                	sub    %eax,%ecx
  101dce:	89 c8                	mov    %ecx,%eax
  101dd0:	85 c0                	test   %eax,%eax
  101dd2:	75 16                	jne    101dea <trap_dispatch+0x8b>
        {
            print_ticks();
  101dd4:	e8 3c fa ff ff       	call   101815 <print_ticks>
            cprintf("\nhello");
  101dd9:	c7 04 24 54 3b 10 00 	movl   $0x103b54,(%esp)
  101de0:	e8 98 e4 ff ff       	call   10027d <cprintf>
        }
        
        break;
  101de5:	e9 f9 00 00 00       	jmp    101ee3 <trap_dispatch+0x184>
  101dea:	e9 f4 00 00 00       	jmp    101ee3 <trap_dispatch+0x184>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101def:	e8 f8 f7 ff ff       	call   1015ec <cons_getc>
  101df4:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101df7:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101dfb:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101dff:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e03:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e07:	c7 04 24 5b 3b 10 00 	movl   $0x103b5b,(%esp)
  101e0e:	e8 6a e4 ff ff       	call   10027d <cprintf>
        break;
  101e13:	e9 cb 00 00 00       	jmp    101ee3 <trap_dispatch+0x184>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e18:	e8 cf f7 ff ff       	call   1015ec <cons_getc>
  101e1d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e20:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e24:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e28:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e30:	c7 04 24 6d 3b 10 00 	movl   $0x103b6d,(%esp)
  101e37:	e8 41 e4 ff ff       	call   10027d <cprintf>
        if (c=='3')
  101e3c:	80 7d f7 33          	cmpb   $0x33,-0x9(%ebp)
  101e40:	75 22                	jne    101e64 <trap_dispatch+0x105>
        {
            switch2user(tf);
  101e42:	8b 45 08             	mov    0x8(%ebp),%eax
  101e45:	89 04 24             	mov    %eax,(%esp)
  101e48:	e8 1e fe ff ff       	call   101c6b <switch2user>
            print_trapframe(tf);
  101e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e50:	89 04 24             	mov    %eax,(%esp)
  101e53:	e8 97 fb ff ff       	call   1019ef <print_trapframe>
            cprintf("+++ switch to  user  mode by keyboard+++\n");
  101e58:	c7 04 24 7c 3b 10 00 	movl   $0x103b7c,(%esp)
  101e5f:	e8 19 e4 ff ff       	call   10027d <cprintf>
        }
        if (c=='0')
  101e64:	80 7d f7 30          	cmpb   $0x30,-0x9(%ebp)
  101e68:	75 24                	jne    101e8e <trap_dispatch+0x12f>
        {
            switch2kernel(tf);
  101e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6d:	89 04 24             	mov    %eax,(%esp)
  101e70:	e8 73 fe ff ff       	call   101ce8 <switch2kernel>
            print_trapframe(tf);
  101e75:	8b 45 08             	mov    0x8(%ebp),%eax
  101e78:	89 04 24             	mov    %eax,(%esp)
  101e7b:	e8 6f fb ff ff       	call   1019ef <print_trapframe>
            cprintf("+++ switch to  kernel  mode by keyboard +++\n");
  101e80:	c7 04 24 a8 3b 10 00 	movl   $0x103ba8,(%esp)
  101e87:	e8 f1 e3 ff ff       	call   10027d <cprintf>
        }
        
        break;
  101e8c:	eb 55                	jmp    101ee3 <trap_dispatch+0x184>
  101e8e:	eb 53                	jmp    101ee3 <trap_dispatch+0x184>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.  中断号为120，即0x78
    case T_SWITCH_TOU:
    switch2user(tf);
  101e90:	8b 45 08             	mov    0x8(%ebp),%eax
  101e93:	89 04 24             	mov    %eax,(%esp)
  101e96:	e8 d0 fd ff ff       	call   101c6b <switch2user>
    break;
  101e9b:	eb 46                	jmp    101ee3 <trap_dispatch+0x184>
    case T_SWITCH_TOK:
        //panic("T_SWITCH_** ??\n");
    switch2kernel(tf);
  101e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea0:	89 04 24             	mov    %eax,(%esp)
  101ea3:	e8 40 fe ff ff       	call   101ce8 <switch2kernel>
        break;
  101ea8:	eb 39                	jmp    101ee3 <trap_dispatch+0x184>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  101ead:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101eb1:	0f b7 c0             	movzwl %ax,%eax
  101eb4:	83 e0 03             	and    $0x3,%eax
  101eb7:	85 c0                	test   %eax,%eax
  101eb9:	75 28                	jne    101ee3 <trap_dispatch+0x184>
            print_trapframe(tf);
  101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebe:	89 04 24             	mov    %eax,(%esp)
  101ec1:	e8 29 fb ff ff       	call   1019ef <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101ec6:	c7 44 24 08 d5 3b 10 	movl   $0x103bd5,0x8(%esp)
  101ecd:	00 
  101ece:	c7 44 24 04 14 01 00 	movl   $0x114,0x4(%esp)
  101ed5:	00 
  101ed6:	c7 04 24 f1 3b 10 00 	movl   $0x103bf1,(%esp)
  101edd:	e8 f2 e4 ff ff       	call   1003d4 <__panic>
        break;
  101ee2:	90                   	nop
        }
    }
}
  101ee3:	c9                   	leave  
  101ee4:	c3                   	ret    

00101ee5 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores(复原) the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101ee5:	55                   	push   %ebp
  101ee6:	89 e5                	mov    %esp,%ebp
  101ee8:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  101eee:	89 04 24             	mov    %eax,(%esp)
  101ef1:	e8 69 fe ff ff       	call   101d5f <trap_dispatch>
}
  101ef6:	c9                   	leave  
  101ef7:	c3                   	ret    

00101ef8 <vector0>:
# handler
.text          #声明，以下是代码段
.globl __alltraps
.globl vector0
vector0://每一个代码段要做的事情
  pushl $0  #代替error code
  101ef8:	6a 00                	push   $0x0
  pushl $0 #中断向量号
  101efa:	6a 00                	push   $0x0
  jmp __alltraps
  101efc:	e9 67 0a 00 00       	jmp    102968 <__alltraps>

00101f01 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f01:	6a 00                	push   $0x0
  pushl $1
  101f03:	6a 01                	push   $0x1
  jmp __alltraps
  101f05:	e9 5e 0a 00 00       	jmp    102968 <__alltraps>

00101f0a <vector2>:
.globl vector2
vector2:
  pushl $0
  101f0a:	6a 00                	push   $0x0
  pushl $2
  101f0c:	6a 02                	push   $0x2
  jmp __alltraps
  101f0e:	e9 55 0a 00 00       	jmp    102968 <__alltraps>

00101f13 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f13:	6a 00                	push   $0x0
  pushl $3
  101f15:	6a 03                	push   $0x3
  jmp __alltraps
  101f17:	e9 4c 0a 00 00       	jmp    102968 <__alltraps>

00101f1c <vector4>:
.globl vector4
vector4:
  pushl $0
  101f1c:	6a 00                	push   $0x0
  pushl $4
  101f1e:	6a 04                	push   $0x4
  jmp __alltraps
  101f20:	e9 43 0a 00 00       	jmp    102968 <__alltraps>

00101f25 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f25:	6a 00                	push   $0x0
  pushl $5
  101f27:	6a 05                	push   $0x5
  jmp __alltraps
  101f29:	e9 3a 0a 00 00       	jmp    102968 <__alltraps>

00101f2e <vector6>:
.globl vector6
vector6:
  pushl $0
  101f2e:	6a 00                	push   $0x0
  pushl $6
  101f30:	6a 06                	push   $0x6
  jmp __alltraps
  101f32:	e9 31 0a 00 00       	jmp    102968 <__alltraps>

00101f37 <vector7>:
.globl vector7
vector7:
  pushl $0
  101f37:	6a 00                	push   $0x0
  pushl $7
  101f39:	6a 07                	push   $0x7
  jmp __alltraps
  101f3b:	e9 28 0a 00 00       	jmp    102968 <__alltraps>

00101f40 <vector8>:
.globl vector8
vector8:
  pushl $8
  101f40:	6a 08                	push   $0x8
  jmp __alltraps
  101f42:	e9 21 0a 00 00       	jmp    102968 <__alltraps>

00101f47 <vector9>:
.globl vector9
vector9:
  pushl $9
  101f47:	6a 09                	push   $0x9
  jmp __alltraps
  101f49:	e9 1a 0a 00 00       	jmp    102968 <__alltraps>

00101f4e <vector10>:
.globl vector10
vector10:
  pushl $10
  101f4e:	6a 0a                	push   $0xa
  jmp __alltraps
  101f50:	e9 13 0a 00 00       	jmp    102968 <__alltraps>

00101f55 <vector11>:
.globl vector11
vector11:
  pushl $11
  101f55:	6a 0b                	push   $0xb
  jmp __alltraps
  101f57:	e9 0c 0a 00 00       	jmp    102968 <__alltraps>

00101f5c <vector12>:
.globl vector12
vector12:
  pushl $12
  101f5c:	6a 0c                	push   $0xc
  jmp __alltraps
  101f5e:	e9 05 0a 00 00       	jmp    102968 <__alltraps>

00101f63 <vector13>:
.globl vector13
vector13:
  pushl $13
  101f63:	6a 0d                	push   $0xd
  jmp __alltraps
  101f65:	e9 fe 09 00 00       	jmp    102968 <__alltraps>

00101f6a <vector14>:
.globl vector14
vector14:
  pushl $14
  101f6a:	6a 0e                	push   $0xe
  jmp __alltraps
  101f6c:	e9 f7 09 00 00       	jmp    102968 <__alltraps>

00101f71 <vector15>:
.globl vector15
vector15:
  pushl $0
  101f71:	6a 00                	push   $0x0
  pushl $15
  101f73:	6a 0f                	push   $0xf
  jmp __alltraps
  101f75:	e9 ee 09 00 00       	jmp    102968 <__alltraps>

00101f7a <vector16>:
.globl vector16
vector16:
  pushl $0
  101f7a:	6a 00                	push   $0x0
  pushl $16
  101f7c:	6a 10                	push   $0x10
  jmp __alltraps
  101f7e:	e9 e5 09 00 00       	jmp    102968 <__alltraps>

00101f83 <vector17>:
.globl vector17
vector17:
  pushl $17
  101f83:	6a 11                	push   $0x11
  jmp __alltraps
  101f85:	e9 de 09 00 00       	jmp    102968 <__alltraps>

00101f8a <vector18>:
.globl vector18
vector18:
  pushl $0
  101f8a:	6a 00                	push   $0x0
  pushl $18
  101f8c:	6a 12                	push   $0x12
  jmp __alltraps
  101f8e:	e9 d5 09 00 00       	jmp    102968 <__alltraps>

00101f93 <vector19>:
.globl vector19
vector19:
  pushl $0
  101f93:	6a 00                	push   $0x0
  pushl $19
  101f95:	6a 13                	push   $0x13
  jmp __alltraps
  101f97:	e9 cc 09 00 00       	jmp    102968 <__alltraps>

00101f9c <vector20>:
.globl vector20
vector20:
  pushl $0
  101f9c:	6a 00                	push   $0x0
  pushl $20
  101f9e:	6a 14                	push   $0x14
  jmp __alltraps
  101fa0:	e9 c3 09 00 00       	jmp    102968 <__alltraps>

00101fa5 <vector21>:
.globl vector21
vector21:
  pushl $0
  101fa5:	6a 00                	push   $0x0
  pushl $21
  101fa7:	6a 15                	push   $0x15
  jmp __alltraps
  101fa9:	e9 ba 09 00 00       	jmp    102968 <__alltraps>

00101fae <vector22>:
.globl vector22
vector22:
  pushl $0
  101fae:	6a 00                	push   $0x0
  pushl $22
  101fb0:	6a 16                	push   $0x16
  jmp __alltraps
  101fb2:	e9 b1 09 00 00       	jmp    102968 <__alltraps>

00101fb7 <vector23>:
.globl vector23
vector23:
  pushl $0
  101fb7:	6a 00                	push   $0x0
  pushl $23
  101fb9:	6a 17                	push   $0x17
  jmp __alltraps
  101fbb:	e9 a8 09 00 00       	jmp    102968 <__alltraps>

00101fc0 <vector24>:
.globl vector24
vector24:
  pushl $0
  101fc0:	6a 00                	push   $0x0
  pushl $24
  101fc2:	6a 18                	push   $0x18
  jmp __alltraps
  101fc4:	e9 9f 09 00 00       	jmp    102968 <__alltraps>

00101fc9 <vector25>:
.globl vector25
vector25:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $25
  101fcb:	6a 19                	push   $0x19
  jmp __alltraps
  101fcd:	e9 96 09 00 00       	jmp    102968 <__alltraps>

00101fd2 <vector26>:
.globl vector26
vector26:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $26
  101fd4:	6a 1a                	push   $0x1a
  jmp __alltraps
  101fd6:	e9 8d 09 00 00       	jmp    102968 <__alltraps>

00101fdb <vector27>:
.globl vector27
vector27:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $27
  101fdd:	6a 1b                	push   $0x1b
  jmp __alltraps
  101fdf:	e9 84 09 00 00       	jmp    102968 <__alltraps>

00101fe4 <vector28>:
.globl vector28
vector28:
  pushl $0
  101fe4:	6a 00                	push   $0x0
  pushl $28
  101fe6:	6a 1c                	push   $0x1c
  jmp __alltraps
  101fe8:	e9 7b 09 00 00       	jmp    102968 <__alltraps>

00101fed <vector29>:
.globl vector29
vector29:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $29
  101fef:	6a 1d                	push   $0x1d
  jmp __alltraps
  101ff1:	e9 72 09 00 00       	jmp    102968 <__alltraps>

00101ff6 <vector30>:
.globl vector30
vector30:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $30
  101ff8:	6a 1e                	push   $0x1e
  jmp __alltraps
  101ffa:	e9 69 09 00 00       	jmp    102968 <__alltraps>

00101fff <vector31>:
.globl vector31
vector31:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $31
  102001:	6a 1f                	push   $0x1f
  jmp __alltraps
  102003:	e9 60 09 00 00       	jmp    102968 <__alltraps>

00102008 <vector32>:
.globl vector32
vector32:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $32
  10200a:	6a 20                	push   $0x20
  jmp __alltraps
  10200c:	e9 57 09 00 00       	jmp    102968 <__alltraps>

00102011 <vector33>:
.globl vector33
vector33:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $33
  102013:	6a 21                	push   $0x21
  jmp __alltraps
  102015:	e9 4e 09 00 00       	jmp    102968 <__alltraps>

0010201a <vector34>:
.globl vector34
vector34:
  pushl $0
  10201a:	6a 00                	push   $0x0
  pushl $34
  10201c:	6a 22                	push   $0x22
  jmp __alltraps
  10201e:	e9 45 09 00 00       	jmp    102968 <__alltraps>

00102023 <vector35>:
.globl vector35
vector35:
  pushl $0
  102023:	6a 00                	push   $0x0
  pushl $35
  102025:	6a 23                	push   $0x23
  jmp __alltraps
  102027:	e9 3c 09 00 00       	jmp    102968 <__alltraps>

0010202c <vector36>:
.globl vector36
vector36:
  pushl $0
  10202c:	6a 00                	push   $0x0
  pushl $36
  10202e:	6a 24                	push   $0x24
  jmp __alltraps
  102030:	e9 33 09 00 00       	jmp    102968 <__alltraps>

00102035 <vector37>:
.globl vector37
vector37:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $37
  102037:	6a 25                	push   $0x25
  jmp __alltraps
  102039:	e9 2a 09 00 00       	jmp    102968 <__alltraps>

0010203e <vector38>:
.globl vector38
vector38:
  pushl $0
  10203e:	6a 00                	push   $0x0
  pushl $38
  102040:	6a 26                	push   $0x26
  jmp __alltraps
  102042:	e9 21 09 00 00       	jmp    102968 <__alltraps>

00102047 <vector39>:
.globl vector39
vector39:
  pushl $0
  102047:	6a 00                	push   $0x0
  pushl $39
  102049:	6a 27                	push   $0x27
  jmp __alltraps
  10204b:	e9 18 09 00 00       	jmp    102968 <__alltraps>

00102050 <vector40>:
.globl vector40
vector40:
  pushl $0
  102050:	6a 00                	push   $0x0
  pushl $40
  102052:	6a 28                	push   $0x28
  jmp __alltraps
  102054:	e9 0f 09 00 00       	jmp    102968 <__alltraps>

00102059 <vector41>:
.globl vector41
vector41:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $41
  10205b:	6a 29                	push   $0x29
  jmp __alltraps
  10205d:	e9 06 09 00 00       	jmp    102968 <__alltraps>

00102062 <vector42>:
.globl vector42
vector42:
  pushl $0
  102062:	6a 00                	push   $0x0
  pushl $42
  102064:	6a 2a                	push   $0x2a
  jmp __alltraps
  102066:	e9 fd 08 00 00       	jmp    102968 <__alltraps>

0010206b <vector43>:
.globl vector43
vector43:
  pushl $0
  10206b:	6a 00                	push   $0x0
  pushl $43
  10206d:	6a 2b                	push   $0x2b
  jmp __alltraps
  10206f:	e9 f4 08 00 00       	jmp    102968 <__alltraps>

00102074 <vector44>:
.globl vector44
vector44:
  pushl $0
  102074:	6a 00                	push   $0x0
  pushl $44
  102076:	6a 2c                	push   $0x2c
  jmp __alltraps
  102078:	e9 eb 08 00 00       	jmp    102968 <__alltraps>

0010207d <vector45>:
.globl vector45
vector45:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $45
  10207f:	6a 2d                	push   $0x2d
  jmp __alltraps
  102081:	e9 e2 08 00 00       	jmp    102968 <__alltraps>

00102086 <vector46>:
.globl vector46
vector46:
  pushl $0
  102086:	6a 00                	push   $0x0
  pushl $46
  102088:	6a 2e                	push   $0x2e
  jmp __alltraps
  10208a:	e9 d9 08 00 00       	jmp    102968 <__alltraps>

0010208f <vector47>:
.globl vector47
vector47:
  pushl $0
  10208f:	6a 00                	push   $0x0
  pushl $47
  102091:	6a 2f                	push   $0x2f
  jmp __alltraps
  102093:	e9 d0 08 00 00       	jmp    102968 <__alltraps>

00102098 <vector48>:
.globl vector48
vector48:
  pushl $0
  102098:	6a 00                	push   $0x0
  pushl $48
  10209a:	6a 30                	push   $0x30
  jmp __alltraps
  10209c:	e9 c7 08 00 00       	jmp    102968 <__alltraps>

001020a1 <vector49>:
.globl vector49
vector49:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $49
  1020a3:	6a 31                	push   $0x31
  jmp __alltraps
  1020a5:	e9 be 08 00 00       	jmp    102968 <__alltraps>

001020aa <vector50>:
.globl vector50
vector50:
  pushl $0
  1020aa:	6a 00                	push   $0x0
  pushl $50
  1020ac:	6a 32                	push   $0x32
  jmp __alltraps
  1020ae:	e9 b5 08 00 00       	jmp    102968 <__alltraps>

001020b3 <vector51>:
.globl vector51
vector51:
  pushl $0
  1020b3:	6a 00                	push   $0x0
  pushl $51
  1020b5:	6a 33                	push   $0x33
  jmp __alltraps
  1020b7:	e9 ac 08 00 00       	jmp    102968 <__alltraps>

001020bc <vector52>:
.globl vector52
vector52:
  pushl $0
  1020bc:	6a 00                	push   $0x0
  pushl $52
  1020be:	6a 34                	push   $0x34
  jmp __alltraps
  1020c0:	e9 a3 08 00 00       	jmp    102968 <__alltraps>

001020c5 <vector53>:
.globl vector53
vector53:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $53
  1020c7:	6a 35                	push   $0x35
  jmp __alltraps
  1020c9:	e9 9a 08 00 00       	jmp    102968 <__alltraps>

001020ce <vector54>:
.globl vector54
vector54:
  pushl $0
  1020ce:	6a 00                	push   $0x0
  pushl $54
  1020d0:	6a 36                	push   $0x36
  jmp __alltraps
  1020d2:	e9 91 08 00 00       	jmp    102968 <__alltraps>

001020d7 <vector55>:
.globl vector55
vector55:
  pushl $0
  1020d7:	6a 00                	push   $0x0
  pushl $55
  1020d9:	6a 37                	push   $0x37
  jmp __alltraps
  1020db:	e9 88 08 00 00       	jmp    102968 <__alltraps>

001020e0 <vector56>:
.globl vector56
vector56:
  pushl $0
  1020e0:	6a 00                	push   $0x0
  pushl $56
  1020e2:	6a 38                	push   $0x38
  jmp __alltraps
  1020e4:	e9 7f 08 00 00       	jmp    102968 <__alltraps>

001020e9 <vector57>:
.globl vector57
vector57:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $57
  1020eb:	6a 39                	push   $0x39
  jmp __alltraps
  1020ed:	e9 76 08 00 00       	jmp    102968 <__alltraps>

001020f2 <vector58>:
.globl vector58
vector58:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $58
  1020f4:	6a 3a                	push   $0x3a
  jmp __alltraps
  1020f6:	e9 6d 08 00 00       	jmp    102968 <__alltraps>

001020fb <vector59>:
.globl vector59
vector59:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $59
  1020fd:	6a 3b                	push   $0x3b
  jmp __alltraps
  1020ff:	e9 64 08 00 00       	jmp    102968 <__alltraps>

00102104 <vector60>:
.globl vector60
vector60:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $60
  102106:	6a 3c                	push   $0x3c
  jmp __alltraps
  102108:	e9 5b 08 00 00       	jmp    102968 <__alltraps>

0010210d <vector61>:
.globl vector61
vector61:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $61
  10210f:	6a 3d                	push   $0x3d
  jmp __alltraps
  102111:	e9 52 08 00 00       	jmp    102968 <__alltraps>

00102116 <vector62>:
.globl vector62
vector62:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $62
  102118:	6a 3e                	push   $0x3e
  jmp __alltraps
  10211a:	e9 49 08 00 00       	jmp    102968 <__alltraps>

0010211f <vector63>:
.globl vector63
vector63:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $63
  102121:	6a 3f                	push   $0x3f
  jmp __alltraps
  102123:	e9 40 08 00 00       	jmp    102968 <__alltraps>

00102128 <vector64>:
.globl vector64
vector64:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $64
  10212a:	6a 40                	push   $0x40
  jmp __alltraps
  10212c:	e9 37 08 00 00       	jmp    102968 <__alltraps>

00102131 <vector65>:
.globl vector65
vector65:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $65
  102133:	6a 41                	push   $0x41
  jmp __alltraps
  102135:	e9 2e 08 00 00       	jmp    102968 <__alltraps>

0010213a <vector66>:
.globl vector66
vector66:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $66
  10213c:	6a 42                	push   $0x42
  jmp __alltraps
  10213e:	e9 25 08 00 00       	jmp    102968 <__alltraps>

00102143 <vector67>:
.globl vector67
vector67:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $67
  102145:	6a 43                	push   $0x43
  jmp __alltraps
  102147:	e9 1c 08 00 00       	jmp    102968 <__alltraps>

0010214c <vector68>:
.globl vector68
vector68:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $68
  10214e:	6a 44                	push   $0x44
  jmp __alltraps
  102150:	e9 13 08 00 00       	jmp    102968 <__alltraps>

00102155 <vector69>:
.globl vector69
vector69:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $69
  102157:	6a 45                	push   $0x45
  jmp __alltraps
  102159:	e9 0a 08 00 00       	jmp    102968 <__alltraps>

0010215e <vector70>:
.globl vector70
vector70:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $70
  102160:	6a 46                	push   $0x46
  jmp __alltraps
  102162:	e9 01 08 00 00       	jmp    102968 <__alltraps>

00102167 <vector71>:
.globl vector71
vector71:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $71
  102169:	6a 47                	push   $0x47
  jmp __alltraps
  10216b:	e9 f8 07 00 00       	jmp    102968 <__alltraps>

00102170 <vector72>:
.globl vector72
vector72:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $72
  102172:	6a 48                	push   $0x48
  jmp __alltraps
  102174:	e9 ef 07 00 00       	jmp    102968 <__alltraps>

00102179 <vector73>:
.globl vector73
vector73:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $73
  10217b:	6a 49                	push   $0x49
  jmp __alltraps
  10217d:	e9 e6 07 00 00       	jmp    102968 <__alltraps>

00102182 <vector74>:
.globl vector74
vector74:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $74
  102184:	6a 4a                	push   $0x4a
  jmp __alltraps
  102186:	e9 dd 07 00 00       	jmp    102968 <__alltraps>

0010218b <vector75>:
.globl vector75
vector75:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $75
  10218d:	6a 4b                	push   $0x4b
  jmp __alltraps
  10218f:	e9 d4 07 00 00       	jmp    102968 <__alltraps>

00102194 <vector76>:
.globl vector76
vector76:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $76
  102196:	6a 4c                	push   $0x4c
  jmp __alltraps
  102198:	e9 cb 07 00 00       	jmp    102968 <__alltraps>

0010219d <vector77>:
.globl vector77
vector77:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $77
  10219f:	6a 4d                	push   $0x4d
  jmp __alltraps
  1021a1:	e9 c2 07 00 00       	jmp    102968 <__alltraps>

001021a6 <vector78>:
.globl vector78
vector78:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $78
  1021a8:	6a 4e                	push   $0x4e
  jmp __alltraps
  1021aa:	e9 b9 07 00 00       	jmp    102968 <__alltraps>

001021af <vector79>:
.globl vector79
vector79:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $79
  1021b1:	6a 4f                	push   $0x4f
  jmp __alltraps
  1021b3:	e9 b0 07 00 00       	jmp    102968 <__alltraps>

001021b8 <vector80>:
.globl vector80
vector80:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $80
  1021ba:	6a 50                	push   $0x50
  jmp __alltraps
  1021bc:	e9 a7 07 00 00       	jmp    102968 <__alltraps>

001021c1 <vector81>:
.globl vector81
vector81:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $81
  1021c3:	6a 51                	push   $0x51
  jmp __alltraps
  1021c5:	e9 9e 07 00 00       	jmp    102968 <__alltraps>

001021ca <vector82>:
.globl vector82
vector82:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $82
  1021cc:	6a 52                	push   $0x52
  jmp __alltraps
  1021ce:	e9 95 07 00 00       	jmp    102968 <__alltraps>

001021d3 <vector83>:
.globl vector83
vector83:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $83
  1021d5:	6a 53                	push   $0x53
  jmp __alltraps
  1021d7:	e9 8c 07 00 00       	jmp    102968 <__alltraps>

001021dc <vector84>:
.globl vector84
vector84:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $84
  1021de:	6a 54                	push   $0x54
  jmp __alltraps
  1021e0:	e9 83 07 00 00       	jmp    102968 <__alltraps>

001021e5 <vector85>:
.globl vector85
vector85:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $85
  1021e7:	6a 55                	push   $0x55
  jmp __alltraps
  1021e9:	e9 7a 07 00 00       	jmp    102968 <__alltraps>

001021ee <vector86>:
.globl vector86
vector86:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $86
  1021f0:	6a 56                	push   $0x56
  jmp __alltraps
  1021f2:	e9 71 07 00 00       	jmp    102968 <__alltraps>

001021f7 <vector87>:
.globl vector87
vector87:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $87
  1021f9:	6a 57                	push   $0x57
  jmp __alltraps
  1021fb:	e9 68 07 00 00       	jmp    102968 <__alltraps>

00102200 <vector88>:
.globl vector88
vector88:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $88
  102202:	6a 58                	push   $0x58
  jmp __alltraps
  102204:	e9 5f 07 00 00       	jmp    102968 <__alltraps>

00102209 <vector89>:
.globl vector89
vector89:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $89
  10220b:	6a 59                	push   $0x59
  jmp __alltraps
  10220d:	e9 56 07 00 00       	jmp    102968 <__alltraps>

00102212 <vector90>:
.globl vector90
vector90:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $90
  102214:	6a 5a                	push   $0x5a
  jmp __alltraps
  102216:	e9 4d 07 00 00       	jmp    102968 <__alltraps>

0010221b <vector91>:
.globl vector91
vector91:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $91
  10221d:	6a 5b                	push   $0x5b
  jmp __alltraps
  10221f:	e9 44 07 00 00       	jmp    102968 <__alltraps>

00102224 <vector92>:
.globl vector92
vector92:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $92
  102226:	6a 5c                	push   $0x5c
  jmp __alltraps
  102228:	e9 3b 07 00 00       	jmp    102968 <__alltraps>

0010222d <vector93>:
.globl vector93
vector93:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $93
  10222f:	6a 5d                	push   $0x5d
  jmp __alltraps
  102231:	e9 32 07 00 00       	jmp    102968 <__alltraps>

00102236 <vector94>:
.globl vector94
vector94:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $94
  102238:	6a 5e                	push   $0x5e
  jmp __alltraps
  10223a:	e9 29 07 00 00       	jmp    102968 <__alltraps>

0010223f <vector95>:
.globl vector95
vector95:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $95
  102241:	6a 5f                	push   $0x5f
  jmp __alltraps
  102243:	e9 20 07 00 00       	jmp    102968 <__alltraps>

00102248 <vector96>:
.globl vector96
vector96:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $96
  10224a:	6a 60                	push   $0x60
  jmp __alltraps
  10224c:	e9 17 07 00 00       	jmp    102968 <__alltraps>

00102251 <vector97>:
.globl vector97
vector97:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $97
  102253:	6a 61                	push   $0x61
  jmp __alltraps
  102255:	e9 0e 07 00 00       	jmp    102968 <__alltraps>

0010225a <vector98>:
.globl vector98
vector98:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $98
  10225c:	6a 62                	push   $0x62
  jmp __alltraps
  10225e:	e9 05 07 00 00       	jmp    102968 <__alltraps>

00102263 <vector99>:
.globl vector99
vector99:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $99
  102265:	6a 63                	push   $0x63
  jmp __alltraps
  102267:	e9 fc 06 00 00       	jmp    102968 <__alltraps>

0010226c <vector100>:
.globl vector100
vector100:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $100
  10226e:	6a 64                	push   $0x64
  jmp __alltraps
  102270:	e9 f3 06 00 00       	jmp    102968 <__alltraps>

00102275 <vector101>:
.globl vector101
vector101:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $101
  102277:	6a 65                	push   $0x65
  jmp __alltraps
  102279:	e9 ea 06 00 00       	jmp    102968 <__alltraps>

0010227e <vector102>:
.globl vector102
vector102:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $102
  102280:	6a 66                	push   $0x66
  jmp __alltraps
  102282:	e9 e1 06 00 00       	jmp    102968 <__alltraps>

00102287 <vector103>:
.globl vector103
vector103:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $103
  102289:	6a 67                	push   $0x67
  jmp __alltraps
  10228b:	e9 d8 06 00 00       	jmp    102968 <__alltraps>

00102290 <vector104>:
.globl vector104
vector104:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $104
  102292:	6a 68                	push   $0x68
  jmp __alltraps
  102294:	e9 cf 06 00 00       	jmp    102968 <__alltraps>

00102299 <vector105>:
.globl vector105
vector105:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $105
  10229b:	6a 69                	push   $0x69
  jmp __alltraps
  10229d:	e9 c6 06 00 00       	jmp    102968 <__alltraps>

001022a2 <vector106>:
.globl vector106
vector106:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $106
  1022a4:	6a 6a                	push   $0x6a
  jmp __alltraps
  1022a6:	e9 bd 06 00 00       	jmp    102968 <__alltraps>

001022ab <vector107>:
.globl vector107
vector107:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $107
  1022ad:	6a 6b                	push   $0x6b
  jmp __alltraps
  1022af:	e9 b4 06 00 00       	jmp    102968 <__alltraps>

001022b4 <vector108>:
.globl vector108
vector108:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $108
  1022b6:	6a 6c                	push   $0x6c
  jmp __alltraps
  1022b8:	e9 ab 06 00 00       	jmp    102968 <__alltraps>

001022bd <vector109>:
.globl vector109
vector109:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $109
  1022bf:	6a 6d                	push   $0x6d
  jmp __alltraps
  1022c1:	e9 a2 06 00 00       	jmp    102968 <__alltraps>

001022c6 <vector110>:
.globl vector110
vector110:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $110
  1022c8:	6a 6e                	push   $0x6e
  jmp __alltraps
  1022ca:	e9 99 06 00 00       	jmp    102968 <__alltraps>

001022cf <vector111>:
.globl vector111
vector111:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $111
  1022d1:	6a 6f                	push   $0x6f
  jmp __alltraps
  1022d3:	e9 90 06 00 00       	jmp    102968 <__alltraps>

001022d8 <vector112>:
.globl vector112
vector112:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $112
  1022da:	6a 70                	push   $0x70
  jmp __alltraps
  1022dc:	e9 87 06 00 00       	jmp    102968 <__alltraps>

001022e1 <vector113>:
.globl vector113
vector113:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $113
  1022e3:	6a 71                	push   $0x71
  jmp __alltraps
  1022e5:	e9 7e 06 00 00       	jmp    102968 <__alltraps>

001022ea <vector114>:
.globl vector114
vector114:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $114
  1022ec:	6a 72                	push   $0x72
  jmp __alltraps
  1022ee:	e9 75 06 00 00       	jmp    102968 <__alltraps>

001022f3 <vector115>:
.globl vector115
vector115:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $115
  1022f5:	6a 73                	push   $0x73
  jmp __alltraps
  1022f7:	e9 6c 06 00 00       	jmp    102968 <__alltraps>

001022fc <vector116>:
.globl vector116
vector116:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $116
  1022fe:	6a 74                	push   $0x74
  jmp __alltraps
  102300:	e9 63 06 00 00       	jmp    102968 <__alltraps>

00102305 <vector117>:
.globl vector117
vector117:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $117
  102307:	6a 75                	push   $0x75
  jmp __alltraps
  102309:	e9 5a 06 00 00       	jmp    102968 <__alltraps>

0010230e <vector118>:
.globl vector118
vector118:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $118
  102310:	6a 76                	push   $0x76
  jmp __alltraps
  102312:	e9 51 06 00 00       	jmp    102968 <__alltraps>

00102317 <vector119>:
.globl vector119
vector119:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $119
  102319:	6a 77                	push   $0x77
  jmp __alltraps
  10231b:	e9 48 06 00 00       	jmp    102968 <__alltraps>

00102320 <vector120>:
.globl vector120
vector120:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $120
  102322:	6a 78                	push   $0x78
  jmp __alltraps
  102324:	e9 3f 06 00 00       	jmp    102968 <__alltraps>

00102329 <vector121>:
.globl vector121
vector121:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $121
  10232b:	6a 79                	push   $0x79
  jmp __alltraps
  10232d:	e9 36 06 00 00       	jmp    102968 <__alltraps>

00102332 <vector122>:
.globl vector122
vector122:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $122
  102334:	6a 7a                	push   $0x7a
  jmp __alltraps
  102336:	e9 2d 06 00 00       	jmp    102968 <__alltraps>

0010233b <vector123>:
.globl vector123
vector123:
  pushl $0
  10233b:	6a 00                	push   $0x0
  pushl $123
  10233d:	6a 7b                	push   $0x7b
  jmp __alltraps
  10233f:	e9 24 06 00 00       	jmp    102968 <__alltraps>

00102344 <vector124>:
.globl vector124
vector124:
  pushl $0
  102344:	6a 00                	push   $0x0
  pushl $124
  102346:	6a 7c                	push   $0x7c
  jmp __alltraps
  102348:	e9 1b 06 00 00       	jmp    102968 <__alltraps>

0010234d <vector125>:
.globl vector125
vector125:
  pushl $0
  10234d:	6a 00                	push   $0x0
  pushl $125
  10234f:	6a 7d                	push   $0x7d
  jmp __alltraps
  102351:	e9 12 06 00 00       	jmp    102968 <__alltraps>

00102356 <vector126>:
.globl vector126
vector126:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $126
  102358:	6a 7e                	push   $0x7e
  jmp __alltraps
  10235a:	e9 09 06 00 00       	jmp    102968 <__alltraps>

0010235f <vector127>:
.globl vector127
vector127:
  pushl $0
  10235f:	6a 00                	push   $0x0
  pushl $127
  102361:	6a 7f                	push   $0x7f
  jmp __alltraps
  102363:	e9 00 06 00 00       	jmp    102968 <__alltraps>

00102368 <vector128>:
.globl vector128
vector128:
  pushl $0
  102368:	6a 00                	push   $0x0
  pushl $128
  10236a:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10236f:	e9 f4 05 00 00       	jmp    102968 <__alltraps>

00102374 <vector129>:
.globl vector129
vector129:
  pushl $0
  102374:	6a 00                	push   $0x0
  pushl $129
  102376:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10237b:	e9 e8 05 00 00       	jmp    102968 <__alltraps>

00102380 <vector130>:
.globl vector130
vector130:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $130
  102382:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102387:	e9 dc 05 00 00       	jmp    102968 <__alltraps>

0010238c <vector131>:
.globl vector131
vector131:
  pushl $0
  10238c:	6a 00                	push   $0x0
  pushl $131
  10238e:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102393:	e9 d0 05 00 00       	jmp    102968 <__alltraps>

00102398 <vector132>:
.globl vector132
vector132:
  pushl $0
  102398:	6a 00                	push   $0x0
  pushl $132
  10239a:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10239f:	e9 c4 05 00 00       	jmp    102968 <__alltraps>

001023a4 <vector133>:
.globl vector133
vector133:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $133
  1023a6:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1023ab:	e9 b8 05 00 00       	jmp    102968 <__alltraps>

001023b0 <vector134>:
.globl vector134
vector134:
  pushl $0
  1023b0:	6a 00                	push   $0x0
  pushl $134
  1023b2:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1023b7:	e9 ac 05 00 00       	jmp    102968 <__alltraps>

001023bc <vector135>:
.globl vector135
vector135:
  pushl $0
  1023bc:	6a 00                	push   $0x0
  pushl $135
  1023be:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1023c3:	e9 a0 05 00 00       	jmp    102968 <__alltraps>

001023c8 <vector136>:
.globl vector136
vector136:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $136
  1023ca:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1023cf:	e9 94 05 00 00       	jmp    102968 <__alltraps>

001023d4 <vector137>:
.globl vector137
vector137:
  pushl $0
  1023d4:	6a 00                	push   $0x0
  pushl $137
  1023d6:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1023db:	e9 88 05 00 00       	jmp    102968 <__alltraps>

001023e0 <vector138>:
.globl vector138
vector138:
  pushl $0
  1023e0:	6a 00                	push   $0x0
  pushl $138
  1023e2:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1023e7:	e9 7c 05 00 00       	jmp    102968 <__alltraps>

001023ec <vector139>:
.globl vector139
vector139:
  pushl $0
  1023ec:	6a 00                	push   $0x0
  pushl $139
  1023ee:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1023f3:	e9 70 05 00 00       	jmp    102968 <__alltraps>

001023f8 <vector140>:
.globl vector140
vector140:
  pushl $0
  1023f8:	6a 00                	push   $0x0
  pushl $140
  1023fa:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1023ff:	e9 64 05 00 00       	jmp    102968 <__alltraps>

00102404 <vector141>:
.globl vector141
vector141:
  pushl $0
  102404:	6a 00                	push   $0x0
  pushl $141
  102406:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10240b:	e9 58 05 00 00       	jmp    102968 <__alltraps>

00102410 <vector142>:
.globl vector142
vector142:
  pushl $0
  102410:	6a 00                	push   $0x0
  pushl $142
  102412:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102417:	e9 4c 05 00 00       	jmp    102968 <__alltraps>

0010241c <vector143>:
.globl vector143
vector143:
  pushl $0
  10241c:	6a 00                	push   $0x0
  pushl $143
  10241e:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102423:	e9 40 05 00 00       	jmp    102968 <__alltraps>

00102428 <vector144>:
.globl vector144
vector144:
  pushl $0
  102428:	6a 00                	push   $0x0
  pushl $144
  10242a:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10242f:	e9 34 05 00 00       	jmp    102968 <__alltraps>

00102434 <vector145>:
.globl vector145
vector145:
  pushl $0
  102434:	6a 00                	push   $0x0
  pushl $145
  102436:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10243b:	e9 28 05 00 00       	jmp    102968 <__alltraps>

00102440 <vector146>:
.globl vector146
vector146:
  pushl $0
  102440:	6a 00                	push   $0x0
  pushl $146
  102442:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102447:	e9 1c 05 00 00       	jmp    102968 <__alltraps>

0010244c <vector147>:
.globl vector147
vector147:
  pushl $0
  10244c:	6a 00                	push   $0x0
  pushl $147
  10244e:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102453:	e9 10 05 00 00       	jmp    102968 <__alltraps>

00102458 <vector148>:
.globl vector148
vector148:
  pushl $0
  102458:	6a 00                	push   $0x0
  pushl $148
  10245a:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10245f:	e9 04 05 00 00       	jmp    102968 <__alltraps>

00102464 <vector149>:
.globl vector149
vector149:
  pushl $0
  102464:	6a 00                	push   $0x0
  pushl $149
  102466:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10246b:	e9 f8 04 00 00       	jmp    102968 <__alltraps>

00102470 <vector150>:
.globl vector150
vector150:
  pushl $0
  102470:	6a 00                	push   $0x0
  pushl $150
  102472:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102477:	e9 ec 04 00 00       	jmp    102968 <__alltraps>

0010247c <vector151>:
.globl vector151
vector151:
  pushl $0
  10247c:	6a 00                	push   $0x0
  pushl $151
  10247e:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102483:	e9 e0 04 00 00       	jmp    102968 <__alltraps>

00102488 <vector152>:
.globl vector152
vector152:
  pushl $0
  102488:	6a 00                	push   $0x0
  pushl $152
  10248a:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10248f:	e9 d4 04 00 00       	jmp    102968 <__alltraps>

00102494 <vector153>:
.globl vector153
vector153:
  pushl $0
  102494:	6a 00                	push   $0x0
  pushl $153
  102496:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10249b:	e9 c8 04 00 00       	jmp    102968 <__alltraps>

001024a0 <vector154>:
.globl vector154
vector154:
  pushl $0
  1024a0:	6a 00                	push   $0x0
  pushl $154
  1024a2:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1024a7:	e9 bc 04 00 00       	jmp    102968 <__alltraps>

001024ac <vector155>:
.globl vector155
vector155:
  pushl $0
  1024ac:	6a 00                	push   $0x0
  pushl $155
  1024ae:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1024b3:	e9 b0 04 00 00       	jmp    102968 <__alltraps>

001024b8 <vector156>:
.globl vector156
vector156:
  pushl $0
  1024b8:	6a 00                	push   $0x0
  pushl $156
  1024ba:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1024bf:	e9 a4 04 00 00       	jmp    102968 <__alltraps>

001024c4 <vector157>:
.globl vector157
vector157:
  pushl $0
  1024c4:	6a 00                	push   $0x0
  pushl $157
  1024c6:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1024cb:	e9 98 04 00 00       	jmp    102968 <__alltraps>

001024d0 <vector158>:
.globl vector158
vector158:
  pushl $0
  1024d0:	6a 00                	push   $0x0
  pushl $158
  1024d2:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1024d7:	e9 8c 04 00 00       	jmp    102968 <__alltraps>

001024dc <vector159>:
.globl vector159
vector159:
  pushl $0
  1024dc:	6a 00                	push   $0x0
  pushl $159
  1024de:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1024e3:	e9 80 04 00 00       	jmp    102968 <__alltraps>

001024e8 <vector160>:
.globl vector160
vector160:
  pushl $0
  1024e8:	6a 00                	push   $0x0
  pushl $160
  1024ea:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1024ef:	e9 74 04 00 00       	jmp    102968 <__alltraps>

001024f4 <vector161>:
.globl vector161
vector161:
  pushl $0
  1024f4:	6a 00                	push   $0x0
  pushl $161
  1024f6:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1024fb:	e9 68 04 00 00       	jmp    102968 <__alltraps>

00102500 <vector162>:
.globl vector162
vector162:
  pushl $0
  102500:	6a 00                	push   $0x0
  pushl $162
  102502:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102507:	e9 5c 04 00 00       	jmp    102968 <__alltraps>

0010250c <vector163>:
.globl vector163
vector163:
  pushl $0
  10250c:	6a 00                	push   $0x0
  pushl $163
  10250e:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102513:	e9 50 04 00 00       	jmp    102968 <__alltraps>

00102518 <vector164>:
.globl vector164
vector164:
  pushl $0
  102518:	6a 00                	push   $0x0
  pushl $164
  10251a:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10251f:	e9 44 04 00 00       	jmp    102968 <__alltraps>

00102524 <vector165>:
.globl vector165
vector165:
  pushl $0
  102524:	6a 00                	push   $0x0
  pushl $165
  102526:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10252b:	e9 38 04 00 00       	jmp    102968 <__alltraps>

00102530 <vector166>:
.globl vector166
vector166:
  pushl $0
  102530:	6a 00                	push   $0x0
  pushl $166
  102532:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102537:	e9 2c 04 00 00       	jmp    102968 <__alltraps>

0010253c <vector167>:
.globl vector167
vector167:
  pushl $0
  10253c:	6a 00                	push   $0x0
  pushl $167
  10253e:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102543:	e9 20 04 00 00       	jmp    102968 <__alltraps>

00102548 <vector168>:
.globl vector168
vector168:
  pushl $0
  102548:	6a 00                	push   $0x0
  pushl $168
  10254a:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10254f:	e9 14 04 00 00       	jmp    102968 <__alltraps>

00102554 <vector169>:
.globl vector169
vector169:
  pushl $0
  102554:	6a 00                	push   $0x0
  pushl $169
  102556:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10255b:	e9 08 04 00 00       	jmp    102968 <__alltraps>

00102560 <vector170>:
.globl vector170
vector170:
  pushl $0
  102560:	6a 00                	push   $0x0
  pushl $170
  102562:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102567:	e9 fc 03 00 00       	jmp    102968 <__alltraps>

0010256c <vector171>:
.globl vector171
vector171:
  pushl $0
  10256c:	6a 00                	push   $0x0
  pushl $171
  10256e:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102573:	e9 f0 03 00 00       	jmp    102968 <__alltraps>

00102578 <vector172>:
.globl vector172
vector172:
  pushl $0
  102578:	6a 00                	push   $0x0
  pushl $172
  10257a:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10257f:	e9 e4 03 00 00       	jmp    102968 <__alltraps>

00102584 <vector173>:
.globl vector173
vector173:
  pushl $0
  102584:	6a 00                	push   $0x0
  pushl $173
  102586:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10258b:	e9 d8 03 00 00       	jmp    102968 <__alltraps>

00102590 <vector174>:
.globl vector174
vector174:
  pushl $0
  102590:	6a 00                	push   $0x0
  pushl $174
  102592:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102597:	e9 cc 03 00 00       	jmp    102968 <__alltraps>

0010259c <vector175>:
.globl vector175
vector175:
  pushl $0
  10259c:	6a 00                	push   $0x0
  pushl $175
  10259e:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1025a3:	e9 c0 03 00 00       	jmp    102968 <__alltraps>

001025a8 <vector176>:
.globl vector176
vector176:
  pushl $0
  1025a8:	6a 00                	push   $0x0
  pushl $176
  1025aa:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1025af:	e9 b4 03 00 00       	jmp    102968 <__alltraps>

001025b4 <vector177>:
.globl vector177
vector177:
  pushl $0
  1025b4:	6a 00                	push   $0x0
  pushl $177
  1025b6:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1025bb:	e9 a8 03 00 00       	jmp    102968 <__alltraps>

001025c0 <vector178>:
.globl vector178
vector178:
  pushl $0
  1025c0:	6a 00                	push   $0x0
  pushl $178
  1025c2:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1025c7:	e9 9c 03 00 00       	jmp    102968 <__alltraps>

001025cc <vector179>:
.globl vector179
vector179:
  pushl $0
  1025cc:	6a 00                	push   $0x0
  pushl $179
  1025ce:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1025d3:	e9 90 03 00 00       	jmp    102968 <__alltraps>

001025d8 <vector180>:
.globl vector180
vector180:
  pushl $0
  1025d8:	6a 00                	push   $0x0
  pushl $180
  1025da:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1025df:	e9 84 03 00 00       	jmp    102968 <__alltraps>

001025e4 <vector181>:
.globl vector181
vector181:
  pushl $0
  1025e4:	6a 00                	push   $0x0
  pushl $181
  1025e6:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025eb:	e9 78 03 00 00       	jmp    102968 <__alltraps>

001025f0 <vector182>:
.globl vector182
vector182:
  pushl $0
  1025f0:	6a 00                	push   $0x0
  pushl $182
  1025f2:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1025f7:	e9 6c 03 00 00       	jmp    102968 <__alltraps>

001025fc <vector183>:
.globl vector183
vector183:
  pushl $0
  1025fc:	6a 00                	push   $0x0
  pushl $183
  1025fe:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102603:	e9 60 03 00 00       	jmp    102968 <__alltraps>

00102608 <vector184>:
.globl vector184
vector184:
  pushl $0
  102608:	6a 00                	push   $0x0
  pushl $184
  10260a:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10260f:	e9 54 03 00 00       	jmp    102968 <__alltraps>

00102614 <vector185>:
.globl vector185
vector185:
  pushl $0
  102614:	6a 00                	push   $0x0
  pushl $185
  102616:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10261b:	e9 48 03 00 00       	jmp    102968 <__alltraps>

00102620 <vector186>:
.globl vector186
vector186:
  pushl $0
  102620:	6a 00                	push   $0x0
  pushl $186
  102622:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102627:	e9 3c 03 00 00       	jmp    102968 <__alltraps>

0010262c <vector187>:
.globl vector187
vector187:
  pushl $0
  10262c:	6a 00                	push   $0x0
  pushl $187
  10262e:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102633:	e9 30 03 00 00       	jmp    102968 <__alltraps>

00102638 <vector188>:
.globl vector188
vector188:
  pushl $0
  102638:	6a 00                	push   $0x0
  pushl $188
  10263a:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10263f:	e9 24 03 00 00       	jmp    102968 <__alltraps>

00102644 <vector189>:
.globl vector189
vector189:
  pushl $0
  102644:	6a 00                	push   $0x0
  pushl $189
  102646:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10264b:	e9 18 03 00 00       	jmp    102968 <__alltraps>

00102650 <vector190>:
.globl vector190
vector190:
  pushl $0
  102650:	6a 00                	push   $0x0
  pushl $190
  102652:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102657:	e9 0c 03 00 00       	jmp    102968 <__alltraps>

0010265c <vector191>:
.globl vector191
vector191:
  pushl $0
  10265c:	6a 00                	push   $0x0
  pushl $191
  10265e:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102663:	e9 00 03 00 00       	jmp    102968 <__alltraps>

00102668 <vector192>:
.globl vector192
vector192:
  pushl $0
  102668:	6a 00                	push   $0x0
  pushl $192
  10266a:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10266f:	e9 f4 02 00 00       	jmp    102968 <__alltraps>

00102674 <vector193>:
.globl vector193
vector193:
  pushl $0
  102674:	6a 00                	push   $0x0
  pushl $193
  102676:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10267b:	e9 e8 02 00 00       	jmp    102968 <__alltraps>

00102680 <vector194>:
.globl vector194
vector194:
  pushl $0
  102680:	6a 00                	push   $0x0
  pushl $194
  102682:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102687:	e9 dc 02 00 00       	jmp    102968 <__alltraps>

0010268c <vector195>:
.globl vector195
vector195:
  pushl $0
  10268c:	6a 00                	push   $0x0
  pushl $195
  10268e:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102693:	e9 d0 02 00 00       	jmp    102968 <__alltraps>

00102698 <vector196>:
.globl vector196
vector196:
  pushl $0
  102698:	6a 00                	push   $0x0
  pushl $196
  10269a:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10269f:	e9 c4 02 00 00       	jmp    102968 <__alltraps>

001026a4 <vector197>:
.globl vector197
vector197:
  pushl $0
  1026a4:	6a 00                	push   $0x0
  pushl $197
  1026a6:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1026ab:	e9 b8 02 00 00       	jmp    102968 <__alltraps>

001026b0 <vector198>:
.globl vector198
vector198:
  pushl $0
  1026b0:	6a 00                	push   $0x0
  pushl $198
  1026b2:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1026b7:	e9 ac 02 00 00       	jmp    102968 <__alltraps>

001026bc <vector199>:
.globl vector199
vector199:
  pushl $0
  1026bc:	6a 00                	push   $0x0
  pushl $199
  1026be:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1026c3:	e9 a0 02 00 00       	jmp    102968 <__alltraps>

001026c8 <vector200>:
.globl vector200
vector200:
  pushl $0
  1026c8:	6a 00                	push   $0x0
  pushl $200
  1026ca:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1026cf:	e9 94 02 00 00       	jmp    102968 <__alltraps>

001026d4 <vector201>:
.globl vector201
vector201:
  pushl $0
  1026d4:	6a 00                	push   $0x0
  pushl $201
  1026d6:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1026db:	e9 88 02 00 00       	jmp    102968 <__alltraps>

001026e0 <vector202>:
.globl vector202
vector202:
  pushl $0
  1026e0:	6a 00                	push   $0x0
  pushl $202
  1026e2:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1026e7:	e9 7c 02 00 00       	jmp    102968 <__alltraps>

001026ec <vector203>:
.globl vector203
vector203:
  pushl $0
  1026ec:	6a 00                	push   $0x0
  pushl $203
  1026ee:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1026f3:	e9 70 02 00 00       	jmp    102968 <__alltraps>

001026f8 <vector204>:
.globl vector204
vector204:
  pushl $0
  1026f8:	6a 00                	push   $0x0
  pushl $204
  1026fa:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1026ff:	e9 64 02 00 00       	jmp    102968 <__alltraps>

00102704 <vector205>:
.globl vector205
vector205:
  pushl $0
  102704:	6a 00                	push   $0x0
  pushl $205
  102706:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10270b:	e9 58 02 00 00       	jmp    102968 <__alltraps>

00102710 <vector206>:
.globl vector206
vector206:
  pushl $0
  102710:	6a 00                	push   $0x0
  pushl $206
  102712:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102717:	e9 4c 02 00 00       	jmp    102968 <__alltraps>

0010271c <vector207>:
.globl vector207
vector207:
  pushl $0
  10271c:	6a 00                	push   $0x0
  pushl $207
  10271e:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102723:	e9 40 02 00 00       	jmp    102968 <__alltraps>

00102728 <vector208>:
.globl vector208
vector208:
  pushl $0
  102728:	6a 00                	push   $0x0
  pushl $208
  10272a:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10272f:	e9 34 02 00 00       	jmp    102968 <__alltraps>

00102734 <vector209>:
.globl vector209
vector209:
  pushl $0
  102734:	6a 00                	push   $0x0
  pushl $209
  102736:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10273b:	e9 28 02 00 00       	jmp    102968 <__alltraps>

00102740 <vector210>:
.globl vector210
vector210:
  pushl $0
  102740:	6a 00                	push   $0x0
  pushl $210
  102742:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102747:	e9 1c 02 00 00       	jmp    102968 <__alltraps>

0010274c <vector211>:
.globl vector211
vector211:
  pushl $0
  10274c:	6a 00                	push   $0x0
  pushl $211
  10274e:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102753:	e9 10 02 00 00       	jmp    102968 <__alltraps>

00102758 <vector212>:
.globl vector212
vector212:
  pushl $0
  102758:	6a 00                	push   $0x0
  pushl $212
  10275a:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10275f:	e9 04 02 00 00       	jmp    102968 <__alltraps>

00102764 <vector213>:
.globl vector213
vector213:
  pushl $0
  102764:	6a 00                	push   $0x0
  pushl $213
  102766:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10276b:	e9 f8 01 00 00       	jmp    102968 <__alltraps>

00102770 <vector214>:
.globl vector214
vector214:
  pushl $0
  102770:	6a 00                	push   $0x0
  pushl $214
  102772:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102777:	e9 ec 01 00 00       	jmp    102968 <__alltraps>

0010277c <vector215>:
.globl vector215
vector215:
  pushl $0
  10277c:	6a 00                	push   $0x0
  pushl $215
  10277e:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102783:	e9 e0 01 00 00       	jmp    102968 <__alltraps>

00102788 <vector216>:
.globl vector216
vector216:
  pushl $0
  102788:	6a 00                	push   $0x0
  pushl $216
  10278a:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10278f:	e9 d4 01 00 00       	jmp    102968 <__alltraps>

00102794 <vector217>:
.globl vector217
vector217:
  pushl $0
  102794:	6a 00                	push   $0x0
  pushl $217
  102796:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10279b:	e9 c8 01 00 00       	jmp    102968 <__alltraps>

001027a0 <vector218>:
.globl vector218
vector218:
  pushl $0
  1027a0:	6a 00                	push   $0x0
  pushl $218
  1027a2:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1027a7:	e9 bc 01 00 00       	jmp    102968 <__alltraps>

001027ac <vector219>:
.globl vector219
vector219:
  pushl $0
  1027ac:	6a 00                	push   $0x0
  pushl $219
  1027ae:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1027b3:	e9 b0 01 00 00       	jmp    102968 <__alltraps>

001027b8 <vector220>:
.globl vector220
vector220:
  pushl $0
  1027b8:	6a 00                	push   $0x0
  pushl $220
  1027ba:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1027bf:	e9 a4 01 00 00       	jmp    102968 <__alltraps>

001027c4 <vector221>:
.globl vector221
vector221:
  pushl $0
  1027c4:	6a 00                	push   $0x0
  pushl $221
  1027c6:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1027cb:	e9 98 01 00 00       	jmp    102968 <__alltraps>

001027d0 <vector222>:
.globl vector222
vector222:
  pushl $0
  1027d0:	6a 00                	push   $0x0
  pushl $222
  1027d2:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1027d7:	e9 8c 01 00 00       	jmp    102968 <__alltraps>

001027dc <vector223>:
.globl vector223
vector223:
  pushl $0
  1027dc:	6a 00                	push   $0x0
  pushl $223
  1027de:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1027e3:	e9 80 01 00 00       	jmp    102968 <__alltraps>

001027e8 <vector224>:
.globl vector224
vector224:
  pushl $0
  1027e8:	6a 00                	push   $0x0
  pushl $224
  1027ea:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1027ef:	e9 74 01 00 00       	jmp    102968 <__alltraps>

001027f4 <vector225>:
.globl vector225
vector225:
  pushl $0
  1027f4:	6a 00                	push   $0x0
  pushl $225
  1027f6:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1027fb:	e9 68 01 00 00       	jmp    102968 <__alltraps>

00102800 <vector226>:
.globl vector226
vector226:
  pushl $0
  102800:	6a 00                	push   $0x0
  pushl $226
  102802:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102807:	e9 5c 01 00 00       	jmp    102968 <__alltraps>

0010280c <vector227>:
.globl vector227
vector227:
  pushl $0
  10280c:	6a 00                	push   $0x0
  pushl $227
  10280e:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102813:	e9 50 01 00 00       	jmp    102968 <__alltraps>

00102818 <vector228>:
.globl vector228
vector228:
  pushl $0
  102818:	6a 00                	push   $0x0
  pushl $228
  10281a:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  10281f:	e9 44 01 00 00       	jmp    102968 <__alltraps>

00102824 <vector229>:
.globl vector229
vector229:
  pushl $0
  102824:	6a 00                	push   $0x0
  pushl $229
  102826:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10282b:	e9 38 01 00 00       	jmp    102968 <__alltraps>

00102830 <vector230>:
.globl vector230
vector230:
  pushl $0
  102830:	6a 00                	push   $0x0
  pushl $230
  102832:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102837:	e9 2c 01 00 00       	jmp    102968 <__alltraps>

0010283c <vector231>:
.globl vector231
vector231:
  pushl $0
  10283c:	6a 00                	push   $0x0
  pushl $231
  10283e:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102843:	e9 20 01 00 00       	jmp    102968 <__alltraps>

00102848 <vector232>:
.globl vector232
vector232:
  pushl $0
  102848:	6a 00                	push   $0x0
  pushl $232
  10284a:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10284f:	e9 14 01 00 00       	jmp    102968 <__alltraps>

00102854 <vector233>:
.globl vector233
vector233:
  pushl $0
  102854:	6a 00                	push   $0x0
  pushl $233
  102856:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  10285b:	e9 08 01 00 00       	jmp    102968 <__alltraps>

00102860 <vector234>:
.globl vector234
vector234:
  pushl $0
  102860:	6a 00                	push   $0x0
  pushl $234
  102862:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102867:	e9 fc 00 00 00       	jmp    102968 <__alltraps>

0010286c <vector235>:
.globl vector235
vector235:
  pushl $0
  10286c:	6a 00                	push   $0x0
  pushl $235
  10286e:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102873:	e9 f0 00 00 00       	jmp    102968 <__alltraps>

00102878 <vector236>:
.globl vector236
vector236:
  pushl $0
  102878:	6a 00                	push   $0x0
  pushl $236
  10287a:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10287f:	e9 e4 00 00 00       	jmp    102968 <__alltraps>

00102884 <vector237>:
.globl vector237
vector237:
  pushl $0
  102884:	6a 00                	push   $0x0
  pushl $237
  102886:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10288b:	e9 d8 00 00 00       	jmp    102968 <__alltraps>

00102890 <vector238>:
.globl vector238
vector238:
  pushl $0
  102890:	6a 00                	push   $0x0
  pushl $238
  102892:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102897:	e9 cc 00 00 00       	jmp    102968 <__alltraps>

0010289c <vector239>:
.globl vector239
vector239:
  pushl $0
  10289c:	6a 00                	push   $0x0
  pushl $239
  10289e:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1028a3:	e9 c0 00 00 00       	jmp    102968 <__alltraps>

001028a8 <vector240>:
.globl vector240
vector240:
  pushl $0
  1028a8:	6a 00                	push   $0x0
  pushl $240
  1028aa:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1028af:	e9 b4 00 00 00       	jmp    102968 <__alltraps>

001028b4 <vector241>:
.globl vector241
vector241:
  pushl $0
  1028b4:	6a 00                	push   $0x0
  pushl $241
  1028b6:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1028bb:	e9 a8 00 00 00       	jmp    102968 <__alltraps>

001028c0 <vector242>:
.globl vector242
vector242:
  pushl $0
  1028c0:	6a 00                	push   $0x0
  pushl $242
  1028c2:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1028c7:	e9 9c 00 00 00       	jmp    102968 <__alltraps>

001028cc <vector243>:
.globl vector243
vector243:
  pushl $0
  1028cc:	6a 00                	push   $0x0
  pushl $243
  1028ce:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1028d3:	e9 90 00 00 00       	jmp    102968 <__alltraps>

001028d8 <vector244>:
.globl vector244
vector244:
  pushl $0
  1028d8:	6a 00                	push   $0x0
  pushl $244
  1028da:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1028df:	e9 84 00 00 00       	jmp    102968 <__alltraps>

001028e4 <vector245>:
.globl vector245
vector245:
  pushl $0
  1028e4:	6a 00                	push   $0x0
  pushl $245
  1028e6:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028eb:	e9 78 00 00 00       	jmp    102968 <__alltraps>

001028f0 <vector246>:
.globl vector246
vector246:
  pushl $0
  1028f0:	6a 00                	push   $0x0
  pushl $246
  1028f2:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1028f7:	e9 6c 00 00 00       	jmp    102968 <__alltraps>

001028fc <vector247>:
.globl vector247
vector247:
  pushl $0
  1028fc:	6a 00                	push   $0x0
  pushl $247
  1028fe:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102903:	e9 60 00 00 00       	jmp    102968 <__alltraps>

00102908 <vector248>:
.globl vector248
vector248:
  pushl $0
  102908:	6a 00                	push   $0x0
  pushl $248
  10290a:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  10290f:	e9 54 00 00 00       	jmp    102968 <__alltraps>

00102914 <vector249>:
.globl vector249
vector249:
  pushl $0
  102914:	6a 00                	push   $0x0
  pushl $249
  102916:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10291b:	e9 48 00 00 00       	jmp    102968 <__alltraps>

00102920 <vector250>:
.globl vector250
vector250:
  pushl $0
  102920:	6a 00                	push   $0x0
  pushl $250
  102922:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102927:	e9 3c 00 00 00       	jmp    102968 <__alltraps>

0010292c <vector251>:
.globl vector251
vector251:
  pushl $0
  10292c:	6a 00                	push   $0x0
  pushl $251
  10292e:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102933:	e9 30 00 00 00       	jmp    102968 <__alltraps>

00102938 <vector252>:
.globl vector252
vector252:
  pushl $0
  102938:	6a 00                	push   $0x0
  pushl $252
  10293a:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  10293f:	e9 24 00 00 00       	jmp    102968 <__alltraps>

00102944 <vector253>:
.globl vector253
vector253:
  pushl $0
  102944:	6a 00                	push   $0x0
  pushl $253
  102946:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  10294b:	e9 18 00 00 00       	jmp    102968 <__alltraps>

00102950 <vector254>:
.globl vector254
vector254:
  pushl $0
  102950:	6a 00                	push   $0x0
  pushl $254
  102952:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102957:	e9 0c 00 00 00       	jmp    102968 <__alltraps>

0010295c <vector255>:
.globl vector255
vector255:
  pushl $0
  10295c:	6a 00                	push   $0x0
  pushl $255
  10295e:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102963:	e9 00 00 00 00       	jmp    102968 <__alltraps>

00102968 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe//把可能用到的寄存器都入栈
    pushl %ds
  102968:	1e                   	push   %ds
    pushl %es
  102969:	06                   	push   %es
    pushl %fs
  10296a:	0f a0                	push   %fs
    pushl %gs
  10296c:	0f a8                	push   %gs
    pushal               #压入所有通用寄存器
  10296e:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  10296f:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102974:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102976:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()把esp当做指向trapframe的指针，传参给trap函数
    pushl %esp
  102978:	54                   	push   %esp

    # call trap(tf), where tf=%esp调用trap函数，
    call trap
  102979:	e8 67 f5 ff ff       	call   101ee5 <trap>

    # pop the pushed stack pointer
    popl %esp
  10297e:	5c                   	pop    %esp

0010297f <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  10297f:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102980:	0f a9                	pop    %gs
    popl %fs
  102982:	0f a1                	pop    %fs
    popl %es
  102984:	07                   	pop    %es
    popl %ds
  102985:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102986:	83 c4 08             	add    $0x8,%esp
    iret
  102989:	cf                   	iret   

0010298a <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  10298a:	55                   	push   %ebp
  10298b:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  10298d:	8b 45 08             	mov    0x8(%ebp),%eax
  102990:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102993:	b8 23 00 00 00       	mov    $0x23,%eax
  102998:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  10299a:	b8 23 00 00 00       	mov    $0x23,%eax
  10299f:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  1029a1:	b8 10 00 00 00       	mov    $0x10,%eax
  1029a6:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  1029a8:	b8 10 00 00 00       	mov    $0x10,%eax
  1029ad:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  1029af:	b8 10 00 00 00       	mov    $0x10,%eax
  1029b4:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  1029b6:	ea bd 29 10 00 08 00 	ljmp   $0x8,$0x1029bd
}
  1029bd:	5d                   	pop    %ebp
  1029be:	c3                   	ret    

001029bf <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  1029bf:	55                   	push   %ebp
  1029c0:	89 e5                	mov    %esp,%ebp
  1029c2:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  1029c5:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  1029ca:	05 00 04 00 00       	add    $0x400,%eax
  1029cf:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  1029d4:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  1029db:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1029dd:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  1029e4:	68 00 
  1029e6:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029eb:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  1029f1:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029f6:	c1 e8 10             	shr    $0x10,%eax
  1029f9:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1029fe:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a05:	83 e0 f0             	and    $0xfffffff0,%eax
  102a08:	83 c8 09             	or     $0x9,%eax
  102a0b:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a10:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a17:	83 c8 10             	or     $0x10,%eax
  102a1a:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a1f:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a26:	83 e0 9f             	and    $0xffffff9f,%eax
  102a29:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a2e:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a35:	83 c8 80             	or     $0xffffff80,%eax
  102a38:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a3d:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a44:	83 e0 f0             	and    $0xfffffff0,%eax
  102a47:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a4c:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a53:	83 e0 ef             	and    $0xffffffef,%eax
  102a56:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a5b:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a62:	83 e0 df             	and    $0xffffffdf,%eax
  102a65:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a6a:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a71:	83 c8 40             	or     $0x40,%eax
  102a74:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a79:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a80:	83 e0 7f             	and    $0x7f,%eax
  102a83:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a88:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102a8d:	c1 e8 18             	shr    $0x18,%eax
  102a90:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102a95:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a9c:	83 e0 ef             	and    $0xffffffef,%eax
  102a9f:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102aa4:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102aab:	e8 da fe ff ff       	call   10298a <lgdt>
  102ab0:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102ab6:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102aba:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102abd:	c9                   	leave  
  102abe:	c3                   	ret    

00102abf <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102abf:	55                   	push   %ebp
  102ac0:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102ac2:	e8 f8 fe ff ff       	call   1029bf <gdt_init>
}
  102ac7:	5d                   	pop    %ebp
  102ac8:	c3                   	ret    

00102ac9 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102ac9:	55                   	push   %ebp
  102aca:	89 e5                	mov    %esp,%ebp
  102acc:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102acf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102ad6:	eb 04                	jmp    102adc <strlen+0x13>
        cnt ++;
  102ad8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102adc:	8b 45 08             	mov    0x8(%ebp),%eax
  102adf:	8d 50 01             	lea    0x1(%eax),%edx
  102ae2:	89 55 08             	mov    %edx,0x8(%ebp)
  102ae5:	0f b6 00             	movzbl (%eax),%eax
  102ae8:	84 c0                	test   %al,%al
  102aea:	75 ec                	jne    102ad8 <strlen+0xf>
    }
    return cnt;
  102aec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102aef:	c9                   	leave  
  102af0:	c3                   	ret    

00102af1 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102af1:	55                   	push   %ebp
  102af2:	89 e5                	mov    %esp,%ebp
  102af4:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102af7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102afe:	eb 04                	jmp    102b04 <strnlen+0x13>
        cnt ++;
  102b00:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b07:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102b0a:	73 10                	jae    102b1c <strnlen+0x2b>
  102b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0f:	8d 50 01             	lea    0x1(%eax),%edx
  102b12:	89 55 08             	mov    %edx,0x8(%ebp)
  102b15:	0f b6 00             	movzbl (%eax),%eax
  102b18:	84 c0                	test   %al,%al
  102b1a:	75 e4                	jne    102b00 <strnlen+0xf>
    }
    return cnt;
  102b1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b1f:	c9                   	leave  
  102b20:	c3                   	ret    

00102b21 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102b21:	55                   	push   %ebp
  102b22:	89 e5                	mov    %esp,%ebp
  102b24:	57                   	push   %edi
  102b25:	56                   	push   %esi
  102b26:	83 ec 20             	sub    $0x20,%esp
  102b29:	8b 45 08             	mov    0x8(%ebp),%eax
  102b2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b32:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102b35:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b3b:	89 d1                	mov    %edx,%ecx
  102b3d:	89 c2                	mov    %eax,%edx
  102b3f:	89 ce                	mov    %ecx,%esi
  102b41:	89 d7                	mov    %edx,%edi
  102b43:	ac                   	lods   %ds:(%esi),%al
  102b44:	aa                   	stos   %al,%es:(%edi)
  102b45:	84 c0                	test   %al,%al
  102b47:	75 fa                	jne    102b43 <strcpy+0x22>
  102b49:	89 fa                	mov    %edi,%edx
  102b4b:	89 f1                	mov    %esi,%ecx
  102b4d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102b50:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102b53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102b59:	83 c4 20             	add    $0x20,%esp
  102b5c:	5e                   	pop    %esi
  102b5d:	5f                   	pop    %edi
  102b5e:	5d                   	pop    %ebp
  102b5f:	c3                   	ret    

00102b60 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102b60:	55                   	push   %ebp
  102b61:	89 e5                	mov    %esp,%ebp
  102b63:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102b66:	8b 45 08             	mov    0x8(%ebp),%eax
  102b69:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102b6c:	eb 21                	jmp    102b8f <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102b6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b71:	0f b6 10             	movzbl (%eax),%edx
  102b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b77:	88 10                	mov    %dl,(%eax)
  102b79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b7c:	0f b6 00             	movzbl (%eax),%eax
  102b7f:	84 c0                	test   %al,%al
  102b81:	74 04                	je     102b87 <strncpy+0x27>
            src ++;
  102b83:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102b87:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102b8b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102b8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102b93:	75 d9                	jne    102b6e <strncpy+0xe>
    }
    return dst;
  102b95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102b98:	c9                   	leave  
  102b99:	c3                   	ret    

00102b9a <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102b9a:	55                   	push   %ebp
  102b9b:	89 e5                	mov    %esp,%ebp
  102b9d:	57                   	push   %edi
  102b9e:	56                   	push   %esi
  102b9f:	83 ec 20             	sub    $0x20,%esp
  102ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  102ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102bae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102bb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bb4:	89 d1                	mov    %edx,%ecx
  102bb6:	89 c2                	mov    %eax,%edx
  102bb8:	89 ce                	mov    %ecx,%esi
  102bba:	89 d7                	mov    %edx,%edi
  102bbc:	ac                   	lods   %ds:(%esi),%al
  102bbd:	ae                   	scas   %es:(%edi),%al
  102bbe:	75 08                	jne    102bc8 <strcmp+0x2e>
  102bc0:	84 c0                	test   %al,%al
  102bc2:	75 f8                	jne    102bbc <strcmp+0x22>
  102bc4:	31 c0                	xor    %eax,%eax
  102bc6:	eb 04                	jmp    102bcc <strcmp+0x32>
  102bc8:	19 c0                	sbb    %eax,%eax
  102bca:	0c 01                	or     $0x1,%al
  102bcc:	89 fa                	mov    %edi,%edx
  102bce:	89 f1                	mov    %esi,%ecx
  102bd0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102bd3:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102bd6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102bd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102bdc:	83 c4 20             	add    $0x20,%esp
  102bdf:	5e                   	pop    %esi
  102be0:	5f                   	pop    %edi
  102be1:	5d                   	pop    %ebp
  102be2:	c3                   	ret    

00102be3 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102be3:	55                   	push   %ebp
  102be4:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102be6:	eb 0c                	jmp    102bf4 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  102be8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102bec:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102bf0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102bf4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102bf8:	74 1a                	je     102c14 <strncmp+0x31>
  102bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  102bfd:	0f b6 00             	movzbl (%eax),%eax
  102c00:	84 c0                	test   %al,%al
  102c02:	74 10                	je     102c14 <strncmp+0x31>
  102c04:	8b 45 08             	mov    0x8(%ebp),%eax
  102c07:	0f b6 10             	movzbl (%eax),%edx
  102c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c0d:	0f b6 00             	movzbl (%eax),%eax
  102c10:	38 c2                	cmp    %al,%dl
  102c12:	74 d4                	je     102be8 <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102c14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c18:	74 18                	je     102c32 <strncmp+0x4f>
  102c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c1d:	0f b6 00             	movzbl (%eax),%eax
  102c20:	0f b6 d0             	movzbl %al,%edx
  102c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c26:	0f b6 00             	movzbl (%eax),%eax
  102c29:	0f b6 c0             	movzbl %al,%eax
  102c2c:	29 c2                	sub    %eax,%edx
  102c2e:	89 d0                	mov    %edx,%eax
  102c30:	eb 05                	jmp    102c37 <strncmp+0x54>
  102c32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c37:	5d                   	pop    %ebp
  102c38:	c3                   	ret    

00102c39 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102c39:	55                   	push   %ebp
  102c3a:	89 e5                	mov    %esp,%ebp
  102c3c:	83 ec 04             	sub    $0x4,%esp
  102c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c42:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c45:	eb 14                	jmp    102c5b <strchr+0x22>
        if (*s == c) {
  102c47:	8b 45 08             	mov    0x8(%ebp),%eax
  102c4a:	0f b6 00             	movzbl (%eax),%eax
  102c4d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102c50:	75 05                	jne    102c57 <strchr+0x1e>
            return (char *)s;
  102c52:	8b 45 08             	mov    0x8(%ebp),%eax
  102c55:	eb 13                	jmp    102c6a <strchr+0x31>
        }
        s ++;
  102c57:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c5e:	0f b6 00             	movzbl (%eax),%eax
  102c61:	84 c0                	test   %al,%al
  102c63:	75 e2                	jne    102c47 <strchr+0xe>
    }
    return NULL;
  102c65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c6a:	c9                   	leave  
  102c6b:	c3                   	ret    

00102c6c <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102c6c:	55                   	push   %ebp
  102c6d:	89 e5                	mov    %esp,%ebp
  102c6f:	83 ec 04             	sub    $0x4,%esp
  102c72:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c75:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c78:	eb 11                	jmp    102c8b <strfind+0x1f>
        if (*s == c) {
  102c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7d:	0f b6 00             	movzbl (%eax),%eax
  102c80:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102c83:	75 02                	jne    102c87 <strfind+0x1b>
            break;
  102c85:	eb 0e                	jmp    102c95 <strfind+0x29>
        }
        s ++;
  102c87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8e:	0f b6 00             	movzbl (%eax),%eax
  102c91:	84 c0                	test   %al,%al
  102c93:	75 e5                	jne    102c7a <strfind+0xe>
    }
    return (char *)s;
  102c95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c98:	c9                   	leave  
  102c99:	c3                   	ret    

00102c9a <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102c9a:	55                   	push   %ebp
  102c9b:	89 e5                	mov    %esp,%ebp
  102c9d:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102ca0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102ca7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102cae:	eb 04                	jmp    102cb4 <strtol+0x1a>
        s ++;
  102cb0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb7:	0f b6 00             	movzbl (%eax),%eax
  102cba:	3c 20                	cmp    $0x20,%al
  102cbc:	74 f2                	je     102cb0 <strtol+0x16>
  102cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc1:	0f b6 00             	movzbl (%eax),%eax
  102cc4:	3c 09                	cmp    $0x9,%al
  102cc6:	74 e8                	je     102cb0 <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
  102cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  102ccb:	0f b6 00             	movzbl (%eax),%eax
  102cce:	3c 2b                	cmp    $0x2b,%al
  102cd0:	75 06                	jne    102cd8 <strtol+0x3e>
        s ++;
  102cd2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102cd6:	eb 15                	jmp    102ced <strtol+0x53>
    }
    else if (*s == '-') {
  102cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  102cdb:	0f b6 00             	movzbl (%eax),%eax
  102cde:	3c 2d                	cmp    $0x2d,%al
  102ce0:	75 0b                	jne    102ced <strtol+0x53>
        s ++, neg = 1;
  102ce2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102ce6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102ced:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102cf1:	74 06                	je     102cf9 <strtol+0x5f>
  102cf3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102cf7:	75 24                	jne    102d1d <strtol+0x83>
  102cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  102cfc:	0f b6 00             	movzbl (%eax),%eax
  102cff:	3c 30                	cmp    $0x30,%al
  102d01:	75 1a                	jne    102d1d <strtol+0x83>
  102d03:	8b 45 08             	mov    0x8(%ebp),%eax
  102d06:	83 c0 01             	add    $0x1,%eax
  102d09:	0f b6 00             	movzbl (%eax),%eax
  102d0c:	3c 78                	cmp    $0x78,%al
  102d0e:	75 0d                	jne    102d1d <strtol+0x83>
        s += 2, base = 16;
  102d10:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102d14:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102d1b:	eb 2a                	jmp    102d47 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  102d1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d21:	75 17                	jne    102d3a <strtol+0xa0>
  102d23:	8b 45 08             	mov    0x8(%ebp),%eax
  102d26:	0f b6 00             	movzbl (%eax),%eax
  102d29:	3c 30                	cmp    $0x30,%al
  102d2b:	75 0d                	jne    102d3a <strtol+0xa0>
        s ++, base = 8;
  102d2d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102d31:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102d38:	eb 0d                	jmp    102d47 <strtol+0xad>
    }
    else if (base == 0) {
  102d3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d3e:	75 07                	jne    102d47 <strtol+0xad>
        base = 10;
  102d40:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102d47:	8b 45 08             	mov    0x8(%ebp),%eax
  102d4a:	0f b6 00             	movzbl (%eax),%eax
  102d4d:	3c 2f                	cmp    $0x2f,%al
  102d4f:	7e 1b                	jle    102d6c <strtol+0xd2>
  102d51:	8b 45 08             	mov    0x8(%ebp),%eax
  102d54:	0f b6 00             	movzbl (%eax),%eax
  102d57:	3c 39                	cmp    $0x39,%al
  102d59:	7f 11                	jg     102d6c <strtol+0xd2>
            dig = *s - '0';
  102d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5e:	0f b6 00             	movzbl (%eax),%eax
  102d61:	0f be c0             	movsbl %al,%eax
  102d64:	83 e8 30             	sub    $0x30,%eax
  102d67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d6a:	eb 48                	jmp    102db4 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6f:	0f b6 00             	movzbl (%eax),%eax
  102d72:	3c 60                	cmp    $0x60,%al
  102d74:	7e 1b                	jle    102d91 <strtol+0xf7>
  102d76:	8b 45 08             	mov    0x8(%ebp),%eax
  102d79:	0f b6 00             	movzbl (%eax),%eax
  102d7c:	3c 7a                	cmp    $0x7a,%al
  102d7e:	7f 11                	jg     102d91 <strtol+0xf7>
            dig = *s - 'a' + 10;
  102d80:	8b 45 08             	mov    0x8(%ebp),%eax
  102d83:	0f b6 00             	movzbl (%eax),%eax
  102d86:	0f be c0             	movsbl %al,%eax
  102d89:	83 e8 57             	sub    $0x57,%eax
  102d8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d8f:	eb 23                	jmp    102db4 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102d91:	8b 45 08             	mov    0x8(%ebp),%eax
  102d94:	0f b6 00             	movzbl (%eax),%eax
  102d97:	3c 40                	cmp    $0x40,%al
  102d99:	7e 3d                	jle    102dd8 <strtol+0x13e>
  102d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d9e:	0f b6 00             	movzbl (%eax),%eax
  102da1:	3c 5a                	cmp    $0x5a,%al
  102da3:	7f 33                	jg     102dd8 <strtol+0x13e>
            dig = *s - 'A' + 10;
  102da5:	8b 45 08             	mov    0x8(%ebp),%eax
  102da8:	0f b6 00             	movzbl (%eax),%eax
  102dab:	0f be c0             	movsbl %al,%eax
  102dae:	83 e8 37             	sub    $0x37,%eax
  102db1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102db4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102db7:	3b 45 10             	cmp    0x10(%ebp),%eax
  102dba:	7c 02                	jl     102dbe <strtol+0x124>
            break;
  102dbc:	eb 1a                	jmp    102dd8 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  102dbe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102dc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102dc5:	0f af 45 10          	imul   0x10(%ebp),%eax
  102dc9:	89 c2                	mov    %eax,%edx
  102dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102dce:	01 d0                	add    %edx,%eax
  102dd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  102dd3:	e9 6f ff ff ff       	jmp    102d47 <strtol+0xad>

    if (endptr) {
  102dd8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102ddc:	74 08                	je     102de6 <strtol+0x14c>
        *endptr = (char *) s;
  102dde:	8b 45 0c             	mov    0xc(%ebp),%eax
  102de1:	8b 55 08             	mov    0x8(%ebp),%edx
  102de4:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102de6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102dea:	74 07                	je     102df3 <strtol+0x159>
  102dec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102def:	f7 d8                	neg    %eax
  102df1:	eb 03                	jmp    102df6 <strtol+0x15c>
  102df3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102df6:	c9                   	leave  
  102df7:	c3                   	ret    

00102df8 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102df8:	55                   	push   %ebp
  102df9:	89 e5                	mov    %esp,%ebp
  102dfb:	57                   	push   %edi
  102dfc:	83 ec 24             	sub    $0x24,%esp
  102dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e02:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102e05:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102e09:	8b 55 08             	mov    0x8(%ebp),%edx
  102e0c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102e0f:	88 45 f7             	mov    %al,-0x9(%ebp)
  102e12:	8b 45 10             	mov    0x10(%ebp),%eax
  102e15:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102e18:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102e1b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102e1f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102e22:	89 d7                	mov    %edx,%edi
  102e24:	f3 aa                	rep stos %al,%es:(%edi)
  102e26:	89 fa                	mov    %edi,%edx
  102e28:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e2b:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102e2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102e31:	83 c4 24             	add    $0x24,%esp
  102e34:	5f                   	pop    %edi
  102e35:	5d                   	pop    %ebp
  102e36:	c3                   	ret    

00102e37 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102e37:	55                   	push   %ebp
  102e38:	89 e5                	mov    %esp,%ebp
  102e3a:	57                   	push   %edi
  102e3b:	56                   	push   %esi
  102e3c:	53                   	push   %ebx
  102e3d:	83 ec 30             	sub    $0x30,%esp
  102e40:	8b 45 08             	mov    0x8(%ebp),%eax
  102e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e46:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e49:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102e4c:	8b 45 10             	mov    0x10(%ebp),%eax
  102e4f:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102e52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e55:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102e58:	73 42                	jae    102e9c <memmove+0x65>
  102e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102e60:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e63:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102e66:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e69:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102e6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102e6f:	c1 e8 02             	shr    $0x2,%eax
  102e72:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102e74:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102e77:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e7a:	89 d7                	mov    %edx,%edi
  102e7c:	89 c6                	mov    %eax,%esi
  102e7e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102e80:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102e83:	83 e1 03             	and    $0x3,%ecx
  102e86:	74 02                	je     102e8a <memmove+0x53>
  102e88:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102e8a:	89 f0                	mov    %esi,%eax
  102e8c:	89 fa                	mov    %edi,%edx
  102e8e:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102e91:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102e94:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102e97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e9a:	eb 36                	jmp    102ed2 <memmove+0x9b>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102e9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ea2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ea5:	01 c2                	add    %eax,%edx
  102ea7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eaa:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102ead:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eb0:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102eb3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eb6:	89 c1                	mov    %eax,%ecx
  102eb8:	89 d8                	mov    %ebx,%eax
  102eba:	89 d6                	mov    %edx,%esi
  102ebc:	89 c7                	mov    %eax,%edi
  102ebe:	fd                   	std    
  102ebf:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ec1:	fc                   	cld    
  102ec2:	89 f8                	mov    %edi,%eax
  102ec4:	89 f2                	mov    %esi,%edx
  102ec6:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102ec9:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102ecc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102ed2:	83 c4 30             	add    $0x30,%esp
  102ed5:	5b                   	pop    %ebx
  102ed6:	5e                   	pop    %esi
  102ed7:	5f                   	pop    %edi
  102ed8:	5d                   	pop    %ebp
  102ed9:	c3                   	ret    

00102eda <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102eda:	55                   	push   %ebp
  102edb:	89 e5                	mov    %esp,%ebp
  102edd:	57                   	push   %edi
  102ede:	56                   	push   %esi
  102edf:	83 ec 20             	sub    $0x20,%esp
  102ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  102ee5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102eeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eee:	8b 45 10             	mov    0x10(%ebp),%eax
  102ef1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102ef4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ef7:	c1 e8 02             	shr    $0x2,%eax
  102efa:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102efc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102eff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f02:	89 d7                	mov    %edx,%edi
  102f04:	89 c6                	mov    %eax,%esi
  102f06:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f08:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102f0b:	83 e1 03             	and    $0x3,%ecx
  102f0e:	74 02                	je     102f12 <memcpy+0x38>
  102f10:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f12:	89 f0                	mov    %esi,%eax
  102f14:	89 fa                	mov    %edi,%edx
  102f16:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102f19:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102f1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102f22:	83 c4 20             	add    $0x20,%esp
  102f25:	5e                   	pop    %esi
  102f26:	5f                   	pop    %edi
  102f27:	5d                   	pop    %ebp
  102f28:	c3                   	ret    

00102f29 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102f29:	55                   	push   %ebp
  102f2a:	89 e5                	mov    %esp,%ebp
  102f2c:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102f32:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102f35:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f38:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102f3b:	eb 30                	jmp    102f6d <memcmp+0x44>
        if (*s1 != *s2) {
  102f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f40:	0f b6 10             	movzbl (%eax),%edx
  102f43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f46:	0f b6 00             	movzbl (%eax),%eax
  102f49:	38 c2                	cmp    %al,%dl
  102f4b:	74 18                	je     102f65 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f50:	0f b6 00             	movzbl (%eax),%eax
  102f53:	0f b6 d0             	movzbl %al,%edx
  102f56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f59:	0f b6 00             	movzbl (%eax),%eax
  102f5c:	0f b6 c0             	movzbl %al,%eax
  102f5f:	29 c2                	sub    %eax,%edx
  102f61:	89 d0                	mov    %edx,%eax
  102f63:	eb 1a                	jmp    102f7f <memcmp+0x56>
        }
        s1 ++, s2 ++;
  102f65:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102f69:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  102f6d:	8b 45 10             	mov    0x10(%ebp),%eax
  102f70:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f73:	89 55 10             	mov    %edx,0x10(%ebp)
  102f76:	85 c0                	test   %eax,%eax
  102f78:	75 c3                	jne    102f3d <memcmp+0x14>
    }
    return 0;
  102f7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f7f:	c9                   	leave  
  102f80:	c3                   	ret    

00102f81 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102f81:	55                   	push   %ebp
  102f82:	89 e5                	mov    %esp,%ebp
  102f84:	83 ec 58             	sub    $0x58,%esp
  102f87:	8b 45 10             	mov    0x10(%ebp),%eax
  102f8a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102f8d:	8b 45 14             	mov    0x14(%ebp),%eax
  102f90:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102f93:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102f96:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102f99:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f9c:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102f9f:	8b 45 18             	mov    0x18(%ebp),%eax
  102fa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102fa5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fa8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102fab:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102fae:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102fb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102fb7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102fbb:	74 1c                	je     102fd9 <printnum+0x58>
  102fbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fc0:	ba 00 00 00 00       	mov    $0x0,%edx
  102fc5:	f7 75 e4             	divl   -0x1c(%ebp)
  102fc8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102fcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fce:	ba 00 00 00 00       	mov    $0x0,%edx
  102fd3:	f7 75 e4             	divl   -0x1c(%ebp)
  102fd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fdf:	f7 75 e4             	divl   -0x1c(%ebp)
  102fe2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102fe5:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102fe8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102feb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102fee:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102ff1:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102ff4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102ff7:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102ffa:	8b 45 18             	mov    0x18(%ebp),%eax
  102ffd:	ba 00 00 00 00       	mov    $0x0,%edx
  103002:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  103005:	77 56                	ja     10305d <printnum+0xdc>
  103007:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  10300a:	72 05                	jb     103011 <printnum+0x90>
  10300c:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  10300f:	77 4c                	ja     10305d <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  103011:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103014:	8d 50 ff             	lea    -0x1(%eax),%edx
  103017:	8b 45 20             	mov    0x20(%ebp),%eax
  10301a:	89 44 24 18          	mov    %eax,0x18(%esp)
  10301e:	89 54 24 14          	mov    %edx,0x14(%esp)
  103022:	8b 45 18             	mov    0x18(%ebp),%eax
  103025:	89 44 24 10          	mov    %eax,0x10(%esp)
  103029:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10302c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10302f:	89 44 24 08          	mov    %eax,0x8(%esp)
  103033:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103037:	8b 45 0c             	mov    0xc(%ebp),%eax
  10303a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10303e:	8b 45 08             	mov    0x8(%ebp),%eax
  103041:	89 04 24             	mov    %eax,(%esp)
  103044:	e8 38 ff ff ff       	call   102f81 <printnum>
  103049:	eb 1c                	jmp    103067 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  10304b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10304e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103052:	8b 45 20             	mov    0x20(%ebp),%eax
  103055:	89 04 24             	mov    %eax,(%esp)
  103058:	8b 45 08             	mov    0x8(%ebp),%eax
  10305b:	ff d0                	call   *%eax
        while (-- width > 0)
  10305d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  103061:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  103065:	7f e4                	jg     10304b <printnum+0xca>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  103067:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10306a:	05 30 3e 10 00       	add    $0x103e30,%eax
  10306f:	0f b6 00             	movzbl (%eax),%eax
  103072:	0f be c0             	movsbl %al,%eax
  103075:	8b 55 0c             	mov    0xc(%ebp),%edx
  103078:	89 54 24 04          	mov    %edx,0x4(%esp)
  10307c:	89 04 24             	mov    %eax,(%esp)
  10307f:	8b 45 08             	mov    0x8(%ebp),%eax
  103082:	ff d0                	call   *%eax
}
  103084:	c9                   	leave  
  103085:	c3                   	ret    

00103086 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103086:	55                   	push   %ebp
  103087:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103089:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10308d:	7e 14                	jle    1030a3 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  10308f:	8b 45 08             	mov    0x8(%ebp),%eax
  103092:	8b 00                	mov    (%eax),%eax
  103094:	8d 48 08             	lea    0x8(%eax),%ecx
  103097:	8b 55 08             	mov    0x8(%ebp),%edx
  10309a:	89 0a                	mov    %ecx,(%edx)
  10309c:	8b 50 04             	mov    0x4(%eax),%edx
  10309f:	8b 00                	mov    (%eax),%eax
  1030a1:	eb 30                	jmp    1030d3 <getuint+0x4d>
    }
    else if (lflag) {
  1030a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030a7:	74 16                	je     1030bf <getuint+0x39>
        return va_arg(*ap, unsigned long);
  1030a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ac:	8b 00                	mov    (%eax),%eax
  1030ae:	8d 48 04             	lea    0x4(%eax),%ecx
  1030b1:	8b 55 08             	mov    0x8(%ebp),%edx
  1030b4:	89 0a                	mov    %ecx,(%edx)
  1030b6:	8b 00                	mov    (%eax),%eax
  1030b8:	ba 00 00 00 00       	mov    $0x0,%edx
  1030bd:	eb 14                	jmp    1030d3 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  1030bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c2:	8b 00                	mov    (%eax),%eax
  1030c4:	8d 48 04             	lea    0x4(%eax),%ecx
  1030c7:	8b 55 08             	mov    0x8(%ebp),%edx
  1030ca:	89 0a                	mov    %ecx,(%edx)
  1030cc:	8b 00                	mov    (%eax),%eax
  1030ce:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1030d3:	5d                   	pop    %ebp
  1030d4:	c3                   	ret    

001030d5 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1030d5:	55                   	push   %ebp
  1030d6:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1030d8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1030dc:	7e 14                	jle    1030f2 <getint+0x1d>
        return va_arg(*ap, long long);
  1030de:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e1:	8b 00                	mov    (%eax),%eax
  1030e3:	8d 48 08             	lea    0x8(%eax),%ecx
  1030e6:	8b 55 08             	mov    0x8(%ebp),%edx
  1030e9:	89 0a                	mov    %ecx,(%edx)
  1030eb:	8b 50 04             	mov    0x4(%eax),%edx
  1030ee:	8b 00                	mov    (%eax),%eax
  1030f0:	eb 28                	jmp    10311a <getint+0x45>
    }
    else if (lflag) {
  1030f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030f6:	74 12                	je     10310a <getint+0x35>
        return va_arg(*ap, long);
  1030f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030fb:	8b 00                	mov    (%eax),%eax
  1030fd:	8d 48 04             	lea    0x4(%eax),%ecx
  103100:	8b 55 08             	mov    0x8(%ebp),%edx
  103103:	89 0a                	mov    %ecx,(%edx)
  103105:	8b 00                	mov    (%eax),%eax
  103107:	99                   	cltd   
  103108:	eb 10                	jmp    10311a <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  10310a:	8b 45 08             	mov    0x8(%ebp),%eax
  10310d:	8b 00                	mov    (%eax),%eax
  10310f:	8d 48 04             	lea    0x4(%eax),%ecx
  103112:	8b 55 08             	mov    0x8(%ebp),%edx
  103115:	89 0a                	mov    %ecx,(%edx)
  103117:	8b 00                	mov    (%eax),%eax
  103119:	99                   	cltd   
    }
}
  10311a:	5d                   	pop    %ebp
  10311b:	c3                   	ret    

0010311c <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10311c:	55                   	push   %ebp
  10311d:	89 e5                	mov    %esp,%ebp
  10311f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  103122:	8d 45 14             	lea    0x14(%ebp),%eax
  103125:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  103128:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10312b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10312f:	8b 45 10             	mov    0x10(%ebp),%eax
  103132:	89 44 24 08          	mov    %eax,0x8(%esp)
  103136:	8b 45 0c             	mov    0xc(%ebp),%eax
  103139:	89 44 24 04          	mov    %eax,0x4(%esp)
  10313d:	8b 45 08             	mov    0x8(%ebp),%eax
  103140:	89 04 24             	mov    %eax,(%esp)
  103143:	e8 02 00 00 00       	call   10314a <vprintfmt>
    va_end(ap);
}
  103148:	c9                   	leave  
  103149:	c3                   	ret    

0010314a <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  10314a:	55                   	push   %ebp
  10314b:	89 e5                	mov    %esp,%ebp
  10314d:	56                   	push   %esi
  10314e:	53                   	push   %ebx
  10314f:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103152:	eb 18                	jmp    10316c <vprintfmt+0x22>
            if (ch == '\0') {
  103154:	85 db                	test   %ebx,%ebx
  103156:	75 05                	jne    10315d <vprintfmt+0x13>
                return;
  103158:	e9 d1 03 00 00       	jmp    10352e <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  10315d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103160:	89 44 24 04          	mov    %eax,0x4(%esp)
  103164:	89 1c 24             	mov    %ebx,(%esp)
  103167:	8b 45 08             	mov    0x8(%ebp),%eax
  10316a:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10316c:	8b 45 10             	mov    0x10(%ebp),%eax
  10316f:	8d 50 01             	lea    0x1(%eax),%edx
  103172:	89 55 10             	mov    %edx,0x10(%ebp)
  103175:	0f b6 00             	movzbl (%eax),%eax
  103178:	0f b6 d8             	movzbl %al,%ebx
  10317b:	83 fb 25             	cmp    $0x25,%ebx
  10317e:	75 d4                	jne    103154 <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103180:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  103184:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  10318b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10318e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103191:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  103198:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10319b:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  10319e:	8b 45 10             	mov    0x10(%ebp),%eax
  1031a1:	8d 50 01             	lea    0x1(%eax),%edx
  1031a4:	89 55 10             	mov    %edx,0x10(%ebp)
  1031a7:	0f b6 00             	movzbl (%eax),%eax
  1031aa:	0f b6 d8             	movzbl %al,%ebx
  1031ad:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1031b0:	83 f8 55             	cmp    $0x55,%eax
  1031b3:	0f 87 44 03 00 00    	ja     1034fd <vprintfmt+0x3b3>
  1031b9:	8b 04 85 54 3e 10 00 	mov    0x103e54(,%eax,4),%eax
  1031c0:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1031c2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1031c6:	eb d6                	jmp    10319e <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1031c8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1031cc:	eb d0                	jmp    10319e <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1031ce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1031d5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031d8:	89 d0                	mov    %edx,%eax
  1031da:	c1 e0 02             	shl    $0x2,%eax
  1031dd:	01 d0                	add    %edx,%eax
  1031df:	01 c0                	add    %eax,%eax
  1031e1:	01 d8                	add    %ebx,%eax
  1031e3:	83 e8 30             	sub    $0x30,%eax
  1031e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1031e9:	8b 45 10             	mov    0x10(%ebp),%eax
  1031ec:	0f b6 00             	movzbl (%eax),%eax
  1031ef:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1031f2:	83 fb 2f             	cmp    $0x2f,%ebx
  1031f5:	7e 0b                	jle    103202 <vprintfmt+0xb8>
  1031f7:	83 fb 39             	cmp    $0x39,%ebx
  1031fa:	7f 06                	jg     103202 <vprintfmt+0xb8>
            for (precision = 0; ; ++ fmt) {
  1031fc:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                    break;
                }
            }
  103200:	eb d3                	jmp    1031d5 <vprintfmt+0x8b>
            goto process_precision;
  103202:	eb 33                	jmp    103237 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  103204:	8b 45 14             	mov    0x14(%ebp),%eax
  103207:	8d 50 04             	lea    0x4(%eax),%edx
  10320a:	89 55 14             	mov    %edx,0x14(%ebp)
  10320d:	8b 00                	mov    (%eax),%eax
  10320f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  103212:	eb 23                	jmp    103237 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  103214:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103218:	79 0c                	jns    103226 <vprintfmt+0xdc>
                width = 0;
  10321a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  103221:	e9 78 ff ff ff       	jmp    10319e <vprintfmt+0x54>
  103226:	e9 73 ff ff ff       	jmp    10319e <vprintfmt+0x54>

        case '#':
            altflag = 1;
  10322b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  103232:	e9 67 ff ff ff       	jmp    10319e <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  103237:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10323b:	79 12                	jns    10324f <vprintfmt+0x105>
                width = precision, precision = -1;
  10323d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103240:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103243:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  10324a:	e9 4f ff ff ff       	jmp    10319e <vprintfmt+0x54>
  10324f:	e9 4a ff ff ff       	jmp    10319e <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103254:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  103258:	e9 41 ff ff ff       	jmp    10319e <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  10325d:	8b 45 14             	mov    0x14(%ebp),%eax
  103260:	8d 50 04             	lea    0x4(%eax),%edx
  103263:	89 55 14             	mov    %edx,0x14(%ebp)
  103266:	8b 00                	mov    (%eax),%eax
  103268:	8b 55 0c             	mov    0xc(%ebp),%edx
  10326b:	89 54 24 04          	mov    %edx,0x4(%esp)
  10326f:	89 04 24             	mov    %eax,(%esp)
  103272:	8b 45 08             	mov    0x8(%ebp),%eax
  103275:	ff d0                	call   *%eax
            break;
  103277:	e9 ac 02 00 00       	jmp    103528 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10327c:	8b 45 14             	mov    0x14(%ebp),%eax
  10327f:	8d 50 04             	lea    0x4(%eax),%edx
  103282:	89 55 14             	mov    %edx,0x14(%ebp)
  103285:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103287:	85 db                	test   %ebx,%ebx
  103289:	79 02                	jns    10328d <vprintfmt+0x143>
                err = -err;
  10328b:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10328d:	83 fb 06             	cmp    $0x6,%ebx
  103290:	7f 0b                	jg     10329d <vprintfmt+0x153>
  103292:	8b 34 9d 14 3e 10 00 	mov    0x103e14(,%ebx,4),%esi
  103299:	85 f6                	test   %esi,%esi
  10329b:	75 23                	jne    1032c0 <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  10329d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1032a1:	c7 44 24 08 41 3e 10 	movl   $0x103e41,0x8(%esp)
  1032a8:	00 
  1032a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1032b3:	89 04 24             	mov    %eax,(%esp)
  1032b6:	e8 61 fe ff ff       	call   10311c <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1032bb:	e9 68 02 00 00       	jmp    103528 <vprintfmt+0x3de>
                printfmt(putch, putdat, "%s", p);
  1032c0:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1032c4:	c7 44 24 08 4a 3e 10 	movl   $0x103e4a,0x8(%esp)
  1032cb:	00 
  1032cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1032d6:	89 04 24             	mov    %eax,(%esp)
  1032d9:	e8 3e fe ff ff       	call   10311c <printfmt>
            break;
  1032de:	e9 45 02 00 00       	jmp    103528 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1032e3:	8b 45 14             	mov    0x14(%ebp),%eax
  1032e6:	8d 50 04             	lea    0x4(%eax),%edx
  1032e9:	89 55 14             	mov    %edx,0x14(%ebp)
  1032ec:	8b 30                	mov    (%eax),%esi
  1032ee:	85 f6                	test   %esi,%esi
  1032f0:	75 05                	jne    1032f7 <vprintfmt+0x1ad>
                p = "(null)";
  1032f2:	be 4d 3e 10 00       	mov    $0x103e4d,%esi
            }
            if (width > 0 && padc != '-') {
  1032f7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032fb:	7e 3e                	jle    10333b <vprintfmt+0x1f1>
  1032fd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  103301:	74 38                	je     10333b <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  103303:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  103306:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103309:	89 44 24 04          	mov    %eax,0x4(%esp)
  10330d:	89 34 24             	mov    %esi,(%esp)
  103310:	e8 dc f7 ff ff       	call   102af1 <strnlen>
  103315:	29 c3                	sub    %eax,%ebx
  103317:	89 d8                	mov    %ebx,%eax
  103319:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10331c:	eb 17                	jmp    103335 <vprintfmt+0x1eb>
                    putch(padc, putdat);
  10331e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  103322:	8b 55 0c             	mov    0xc(%ebp),%edx
  103325:	89 54 24 04          	mov    %edx,0x4(%esp)
  103329:	89 04 24             	mov    %eax,(%esp)
  10332c:	8b 45 08             	mov    0x8(%ebp),%eax
  10332f:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  103331:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103335:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103339:	7f e3                	jg     10331e <vprintfmt+0x1d4>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10333b:	eb 38                	jmp    103375 <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  10333d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103341:	74 1f                	je     103362 <vprintfmt+0x218>
  103343:	83 fb 1f             	cmp    $0x1f,%ebx
  103346:	7e 05                	jle    10334d <vprintfmt+0x203>
  103348:	83 fb 7e             	cmp    $0x7e,%ebx
  10334b:	7e 15                	jle    103362 <vprintfmt+0x218>
                    putch('?', putdat);
  10334d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103350:	89 44 24 04          	mov    %eax,0x4(%esp)
  103354:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  10335b:	8b 45 08             	mov    0x8(%ebp),%eax
  10335e:	ff d0                	call   *%eax
  103360:	eb 0f                	jmp    103371 <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  103362:	8b 45 0c             	mov    0xc(%ebp),%eax
  103365:	89 44 24 04          	mov    %eax,0x4(%esp)
  103369:	89 1c 24             	mov    %ebx,(%esp)
  10336c:	8b 45 08             	mov    0x8(%ebp),%eax
  10336f:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103371:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103375:	89 f0                	mov    %esi,%eax
  103377:	8d 70 01             	lea    0x1(%eax),%esi
  10337a:	0f b6 00             	movzbl (%eax),%eax
  10337d:	0f be d8             	movsbl %al,%ebx
  103380:	85 db                	test   %ebx,%ebx
  103382:	74 10                	je     103394 <vprintfmt+0x24a>
  103384:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103388:	78 b3                	js     10333d <vprintfmt+0x1f3>
  10338a:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  10338e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103392:	79 a9                	jns    10333d <vprintfmt+0x1f3>
                }
            }
            for (; width > 0; width --) {
  103394:	eb 17                	jmp    1033ad <vprintfmt+0x263>
                putch(' ', putdat);
  103396:	8b 45 0c             	mov    0xc(%ebp),%eax
  103399:	89 44 24 04          	mov    %eax,0x4(%esp)
  10339d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1033a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1033a7:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  1033a9:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  1033ad:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033b1:	7f e3                	jg     103396 <vprintfmt+0x24c>
            }
            break;
  1033b3:	e9 70 01 00 00       	jmp    103528 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  1033b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1033bb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033bf:	8d 45 14             	lea    0x14(%ebp),%eax
  1033c2:	89 04 24             	mov    %eax,(%esp)
  1033c5:	e8 0b fd ff ff       	call   1030d5 <getint>
  1033ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033cd:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  1033d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033d6:	85 d2                	test   %edx,%edx
  1033d8:	79 26                	jns    103400 <vprintfmt+0x2b6>
                putch('-', putdat);
  1033da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033e1:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1033e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1033eb:	ff d0                	call   *%eax
                num = -(long long)num;
  1033ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033f3:	f7 d8                	neg    %eax
  1033f5:	83 d2 00             	adc    $0x0,%edx
  1033f8:	f7 da                	neg    %edx
  1033fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  103400:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103407:	e9 a8 00 00 00       	jmp    1034b4 <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  10340c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10340f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103413:	8d 45 14             	lea    0x14(%ebp),%eax
  103416:	89 04 24             	mov    %eax,(%esp)
  103419:	e8 68 fc ff ff       	call   103086 <getuint>
  10341e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103421:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  103424:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10342b:	e9 84 00 00 00       	jmp    1034b4 <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103430:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103433:	89 44 24 04          	mov    %eax,0x4(%esp)
  103437:	8d 45 14             	lea    0x14(%ebp),%eax
  10343a:	89 04 24             	mov    %eax,(%esp)
  10343d:	e8 44 fc ff ff       	call   103086 <getuint>
  103442:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103445:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103448:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10344f:	eb 63                	jmp    1034b4 <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  103451:	8b 45 0c             	mov    0xc(%ebp),%eax
  103454:	89 44 24 04          	mov    %eax,0x4(%esp)
  103458:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  10345f:	8b 45 08             	mov    0x8(%ebp),%eax
  103462:	ff d0                	call   *%eax
            putch('x', putdat);
  103464:	8b 45 0c             	mov    0xc(%ebp),%eax
  103467:	89 44 24 04          	mov    %eax,0x4(%esp)
  10346b:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  103472:	8b 45 08             	mov    0x8(%ebp),%eax
  103475:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103477:	8b 45 14             	mov    0x14(%ebp),%eax
  10347a:	8d 50 04             	lea    0x4(%eax),%edx
  10347d:	89 55 14             	mov    %edx,0x14(%ebp)
  103480:	8b 00                	mov    (%eax),%eax
  103482:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103485:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  10348c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103493:	eb 1f                	jmp    1034b4 <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103495:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103498:	89 44 24 04          	mov    %eax,0x4(%esp)
  10349c:	8d 45 14             	lea    0x14(%ebp),%eax
  10349f:	89 04 24             	mov    %eax,(%esp)
  1034a2:	e8 df fb ff ff       	call   103086 <getuint>
  1034a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  1034ad:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  1034b4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  1034b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034bb:	89 54 24 18          	mov    %edx,0x18(%esp)
  1034bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1034c2:	89 54 24 14          	mov    %edx,0x14(%esp)
  1034c6:	89 44 24 10          	mov    %eax,0x10(%esp)
  1034ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034d0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1034d4:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1034d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034df:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e2:	89 04 24             	mov    %eax,(%esp)
  1034e5:	e8 97 fa ff ff       	call   102f81 <printnum>
            break;
  1034ea:	eb 3c                	jmp    103528 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1034ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f3:	89 1c 24             	mov    %ebx,(%esp)
  1034f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1034f9:	ff d0                	call   *%eax
            break;
  1034fb:	eb 2b                	jmp    103528 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1034fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  103500:	89 44 24 04          	mov    %eax,0x4(%esp)
  103504:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  10350b:	8b 45 08             	mov    0x8(%ebp),%eax
  10350e:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  103510:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103514:	eb 04                	jmp    10351a <vprintfmt+0x3d0>
  103516:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10351a:	8b 45 10             	mov    0x10(%ebp),%eax
  10351d:	83 e8 01             	sub    $0x1,%eax
  103520:	0f b6 00             	movzbl (%eax),%eax
  103523:	3c 25                	cmp    $0x25,%al
  103525:	75 ef                	jne    103516 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  103527:	90                   	nop
        }
    }
  103528:	90                   	nop
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103529:	e9 3e fc ff ff       	jmp    10316c <vprintfmt+0x22>
}
  10352e:	83 c4 40             	add    $0x40,%esp
  103531:	5b                   	pop    %ebx
  103532:	5e                   	pop    %esi
  103533:	5d                   	pop    %ebp
  103534:	c3                   	ret    

00103535 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103535:	55                   	push   %ebp
  103536:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103538:	8b 45 0c             	mov    0xc(%ebp),%eax
  10353b:	8b 40 08             	mov    0x8(%eax),%eax
  10353e:	8d 50 01             	lea    0x1(%eax),%edx
  103541:	8b 45 0c             	mov    0xc(%ebp),%eax
  103544:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103547:	8b 45 0c             	mov    0xc(%ebp),%eax
  10354a:	8b 10                	mov    (%eax),%edx
  10354c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10354f:	8b 40 04             	mov    0x4(%eax),%eax
  103552:	39 c2                	cmp    %eax,%edx
  103554:	73 12                	jae    103568 <sprintputch+0x33>
        *b->buf ++ = ch;
  103556:	8b 45 0c             	mov    0xc(%ebp),%eax
  103559:	8b 00                	mov    (%eax),%eax
  10355b:	8d 48 01             	lea    0x1(%eax),%ecx
  10355e:	8b 55 0c             	mov    0xc(%ebp),%edx
  103561:	89 0a                	mov    %ecx,(%edx)
  103563:	8b 55 08             	mov    0x8(%ebp),%edx
  103566:	88 10                	mov    %dl,(%eax)
    }
}
  103568:	5d                   	pop    %ebp
  103569:	c3                   	ret    

0010356a <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  10356a:	55                   	push   %ebp
  10356b:	89 e5                	mov    %esp,%ebp
  10356d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103570:	8d 45 14             	lea    0x14(%ebp),%eax
  103573:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103576:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103579:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10357d:	8b 45 10             	mov    0x10(%ebp),%eax
  103580:	89 44 24 08          	mov    %eax,0x8(%esp)
  103584:	8b 45 0c             	mov    0xc(%ebp),%eax
  103587:	89 44 24 04          	mov    %eax,0x4(%esp)
  10358b:	8b 45 08             	mov    0x8(%ebp),%eax
  10358e:	89 04 24             	mov    %eax,(%esp)
  103591:	e8 08 00 00 00       	call   10359e <vsnprintf>
  103596:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103599:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10359c:	c9                   	leave  
  10359d:	c3                   	ret    

0010359e <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10359e:	55                   	push   %ebp
  10359f:	89 e5                	mov    %esp,%ebp
  1035a1:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  1035a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1035aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  1035b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1035b3:	01 d0                	add    %edx,%eax
  1035b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1035bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1035c3:	74 0a                	je     1035cf <vsnprintf+0x31>
  1035c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1035c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1035cb:	39 c2                	cmp    %eax,%edx
  1035cd:	76 07                	jbe    1035d6 <vsnprintf+0x38>
        return -E_INVAL;
  1035cf:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1035d4:	eb 2a                	jmp    103600 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1035d6:	8b 45 14             	mov    0x14(%ebp),%eax
  1035d9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1035dd:	8b 45 10             	mov    0x10(%ebp),%eax
  1035e0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1035e4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1035e7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035eb:	c7 04 24 35 35 10 00 	movl   $0x103535,(%esp)
  1035f2:	e8 53 fb ff ff       	call   10314a <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1035f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035fa:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1035fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103600:	c9                   	leave  
  103601:	c3                   	ret    
