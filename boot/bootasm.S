#include <asm.h>

# Start the CPU: switch to 32-bit protected mode, jump into C.
# The BIOS loads this code from the first sector of the hard disk into
# memory at physical address 0x7c00 and starts executing in real mode
# with %cs=0 %ip=7c00.这段代码的地址

.set PROT_MODE_CSEG,        0x8                     # kernel code segment selector
.set PROT_MODE_DSEG,        0x10                    # kernel data segment selector
.set CR0_PE_ON,             0x1                     # protected mode enable flag

# start address should be 0:7c00, in real mode, the beginning address of the running bootloader
.globl start
start:
.code16                                             # Assemble for 16-bit mode      
    cli                                             # Disable interrupts        禁止中断发生
    cld                                             # String operations increment    df置0，使得si，di每次操作后递减

    # Set up the important data segment registers (DS, ES, SS).
    xorw %ax, %ax                                   # Segment number zero   进行异或运算      初值为0
    movw %ax, %ds                                   # -> Data Segment        data，stack，extern段地址为0
    movw %ax, %es                                   # -> Extra Segment       
    movw %ax, %ss                                   # -> Stack Segment

    # Enable A20:
    #  For backwards compatibility with the earliest PCs, physical
    #  address line 20 is tied low, so that addresses higher than
    #  1MB wrap around to zero by default. This code undoes this.
seta20.1:
                                                    # 将0x2处内容与0x64端口值比较，如果相同，把0xdl处的值写入0x64端口
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).在0x64地址处读取一个字节长度到al中
    testb $0x2, %al                                 #0x2处的值与al进行与运算（1byte）--结果为0，zf置1
    jnz seta20.1                                   # zf处为1，跳转，继续做seta20.1
                                                    #最后结果为 al与0x2处内容相同
    movb $0xd1, %al                                 # 0xd1 -> port 0x64
    outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port  一个命令   把0xdl处一个字节的内容写入0x64
                                                    #上面这步才最重要，发送命令（读取8042输出端口）
seta20.2:
                                                    # 将0x2处内容与0x64端口值比较，如果相同，把0xdf(193)处的值写入0x60端口
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.2
                                                    #最后结果为 al与0x2处内容相同
    movb $0xdf, %al                                 # 0xdf -> port 0x60
    outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1 置1，写进8042端口
                                                    # 完成A20的开启
    # Switch from real to protected mode, using a bootstrap GDT
    # and segment translation that makes virtual addresses
    # identical to physical addresses, so that the
    # effective memory map does not change during the switch.
    lgdt gdtdesc          #加载全局描述符到gdtr
    movl %cr0, %eax       #读cr0
    orl $CR0_PE_ON, %eax    #进行或运算
    movl %eax, %cr0         #开启cr0 进入保护模式

    # Jump to next instruction, but in 32-bit code segment.
    # Switches processor into 32-bit mode.
    ljmp $PROT_MODE_CSEG, $protcseg      #长转移 到protcseg

.code32                                             # Assemble for 32-bit mode
protcseg:
    # Set up the protected-mode data segment registers
    movw $PROT_MODE_DSEG, %ax                       # Our data segment selector     数据段选择子
    movw %ax, %ds                                   # -> DS: Data Segment
    movw %ax, %es                                   # -> ES: Extra Segment
    movw %ax, %fs                                   # -> FS
    movw %ax, %gs                                   # -> GS
    movw %ax, %ss                                   # -> SS: Stack Segment
    #让各个段寄存器值为我们的选择子               有了堆栈才能运行C
    # Set up the stack pointer and call into C. The stack region is from 0--start(0x7c00)
    movl $0x0, %ebp          #ebp初值0
    movl $start, %esp        #调用start
    call bootmain           #调用bootmain.c中

    # If bootmain returns (it shouldn't), loop.
spin:
    jmp spin

# Bootstrap GDT
.p2align 2                                          # force 4 byte alignment
gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel      x或者r型的段表     段基值和限制
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:                                            #全局描述符表
    .word 0x17                                      # 在0x17处声明16位字节  大小sizeof(gdt) - 1
    .long gdt                                       # address gdt   gdt处声明一个32位字节
