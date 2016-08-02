//
//  RootObject.m
//  MVVMFrame
//
//  Created by HW on 16/8/2.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "RootObject.h"
#import <iostream>
//#import <objc/runtime.h>

class Object {
public:
    Object(){
        std::cout <<" 初始化 " << std::endl;
    }
};
@implementation RootObject

+ (void *)new {
    static MyClass isa ;
    IMP imp = description;
    isa.pointer = imp;
//    
//    std::string str = "name";
//    char *p;
//    str.copy(p, str.size(),0);
//    isa.name = "name";
    void *poiner = &isa;
    
    return poiner;
}
//description
/*
 获取 description 方法的地址以后，通过 lldb 命令：di -s 0x0000000100001b40，查看调用栈步骤如下：
 TeamplateStudy`description:
 0x100001b40 <+0>:  pushq  %rbp                      将 rbp 的值压入栈
 0x100001b41 <+1>:  movq   %rsp, %rbp                将 rsp 的值赋值给 rbp
 0x100001b44 <+4>:  subq   $0x10, %rsp               栈顶向第地址增长 0x10 10 个字节
 0x100001b48 <+8>:  leaq   0x3edb(%rip), %rdi        ; "\xe6\x8f\x8f\xe8\xbf\xb0\n"  将变量 rdi 的地址赋给  rip 
                                                     LEA指令的功能是取偏移地址,例如LEAAX,[1000H],作用是将源操作数[1000H]的偏移地址1000H送至AX
 0x100001b4f <+15>: movb   $0x0, %al
 0x100001b51 <+17>: callq  0x1000058aa               ; symbol stub for: printf  调用函数
 0x100001b56 <+22>: movl   %eax, -0x4(%rbp)          把 %eax 放在 -0x4(%rbp) 的位置(参数的调用栈位置通过ebp保存的栈帧栈底地址索引，栈从内存高地址向低地址生长，所以索引值为负数，减少esp寄存器的值表示扩展栈帧)
 0x100001b59 <+25>: addq   $0x10, %rsp
 0x100001b5d <+29>: popq   %rbp
 0x100001b5e <+30>: retq
 0x100001b5f:       nop
 */
void description(){
    printf("描述\n");
}
@end
