//
//  One.m
//  Template
//
//  Created by lizhongqiang on 16/7/29.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "One.h"
#import <iostream>
using namespace std;

@interface One () {
    
@private
    Hello *hello;
}
@end

@implementation One

void Hello::say_hello() {
    string orignal = [greeting_text UTF8String];
    std::string hello_one = orignal + "YOU";//也可以通过强转类型//
    /*
     类型强转的方法：
     方法一：
     static_cast<string>([greeting_text UTF8String])+"YOU";
     方法二：
     (string)[greeting_text UTF8String] + "YOU";
     
     static_cast
         该运算符把expression转换为type-id类型，但没有运行时类型检查来保证转换的安全性。
         注意：static_cast不能转换掉expression的const、volatile、或者__unaligned属性。
     reinterpret_cast
         type-id 必须是一个指针、引用、算术类型、函数指针或者成员指针
     dynamic_cast
         将一个基类对象指针（或引用）cast到继承类指针，dynamic_cast会根据基类指针是否真正指向继承类指针来做相应处理
     const_cast
         用于修改类型的const或volatile属性
     
     volatile 
         就像大家更熟悉的const一样，volatile是一个类型修饰符（type specifier）。它是被设计用来修饰被不同线程访问和修改的变量。如果不加入volatile，基本上会导致这样的结果：要么无法编写多线程程序，要么编译器失去大量优化的机会。
         一个定义为volatile的变量是说这变量可能会被意想不到地改变，这样，编译器就不会去假设这个变量的值了。精确地说就是，优化器在用到这个变量时必须每次都小心地重新读取这个变量的值，而不是使用保存在寄存器里的备份。
         volatile应该解释为“直接存取原始内存地址”比较合适，“易变的”这种解释简直有点误导人
         当要求使用volatile 声明的变量的值的时候，系统总是重新从它所在的内存读取数据，即使它前面的指令刚刚从该处读取过数据。而且读取的数据立刻被保存
         用到 volatile 变量的几个例子：
             1）并行设备的硬件寄存器（如：状态寄存器）
             2）一个中断服务子程序中会访问到的非自动变量
             3）多线程应用中被几个任务共享的变量
     
        模拟多线程或者寄存器中，改变了变量内存中的值，
         #include<stdio.h>
         void main(int argc,char *argv[])
         {
           int i = 10;// 此时 i 为 没有设置为 volatile，后面改变变量内存中值（改变的时候，不让编译器知道的目的是为了让系统不知道改变了进行了修改，从而捕捉不到修改信号，进而不会更新变量缓存中的值），使得后面 i 获取值的时候（这是因为系统会对变量做一定的优化，缓存变量值），会不正确，为了避免这种情况需使用 volatile 关键字 
           int a = i;
           printf("i=%d",a);
           // 下面汇编语句的作用就是改变内存中 i 的值，但是又不让编译器知道
           __asm
          {
              mov dword ptr[ebp-4],20h
          }
          int b = i;
          printf("i=%d",b);
         }
     */
    /*
     注意：
     在标准 C++ 中，+ 加操作运算符，两边不能同时为 const char 类型的
     因此，需要 + 两边只有有一个为 string 类型的数据
     */
    int i = 20;
    double d = 100.05;
    i = static_cast<int>(d);
    printf("%d",i);
    
    printf("%s\n",hello_one.c_str());
}

int Hello::square(volatile int *ptr) {
    return ((*ptr)*(*ptr));
}

- (instancetype)init {
    if (self = [super init]) {
        hello = new Hello();
    }
    return self;
}
- (void)dealloc {
    delete hello;
}
- (void)sayGreeting {
    hello->say_hello();
}
- (void)sayGreeting:(Hello *)greeting {
    greeting->say_hello();
}
@end
