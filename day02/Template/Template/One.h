//
//  One.h
//  Template
//
//  Created by lizhongqiang on 16/7/29.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class Hello;
//#ifdef __cplusplus
/*
 #ifdef __cplusplus
 一般用于将 C++ 代码以标准 C 形式输出（即以 C 的形式被调用），效果与 extern "C" { C++代码 } 效果是一样的
 这是因为 C++ 虽然被确认为是 C 的超集，
 但是 C++ 的编译器还是与 C 的编译器不同的。
 C 中调用 C++ 中的代码这样定义会是安全的
 extern "C" //告诉C+++编译器,扩号里按照C的命名规则编译
 */
extern "C" {
    class Hello {
    private:
        id greeting_text;
    public:
        Hello() {
            greeting_text = @"Hello, world!";
            printf("init = %p\n",this);
        }
        Hello(const char *initial_greeting_text) {
            greeting_text = [[NSString alloc]initWithUTF8String:initial_greeting_text];
            printf("init = %p\n",this);
        }
        void say_hello();
        ~Hello(){
            printf("Hello 对象被释放掉了 %p \n",this);
        }
        char* operator + (char *);
        int square(volatile int *ptr);
        /*
         + 操作符，只能能有小于等于一个参数，否则会报错 overloaded operator+ must be a unary or binary operator
         这是因为 + 操作符，相加的一放默认为 this，且只能为 this
         */
//        const char * operator+ (const char *a,const char *b)();
    };
    
};

//#endif

//#ifdef __OBJC__
//#ifndef __cplusplus
//typedef void Hello;
//
//
//
//#endif
//#endif

@interface One : NSObject

- (void)sayGreeting;
- (void)sayGreeting:(void *)greeting;
@end
