//
//  InitList.m
//  RTTI
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "InitList.h"
#import <iostream>
using namespace std;

#warning 总结：1.构造函数 为什么要 初始化阶段 与 计算阶段：\
              是因为：编译器要保证，执行用户构造函数里面的代码之前，先调用必要类成员的默认构造函数，\
              编译器具体的操作是：编译器会扩张已存在的构造函数，在其中安插一些代码，将成员变量中需要调用的所有必要的默认构造的程序代码安插进去。\
              2.不管是不是通过初始化列表来初始化成员变量，都需要进行构造函数的初始化阶段 \
              而构造函数的初始化阶段是发生在构造函数的调用（即：计算阶段）之前。\
              初始化列表的语法： \
              变量名 (对应该变量的构造函数需要传入的实参，如果该成员变量使用的是默认构造函数则不需要传入任何参数) \
              注意：静态变量 static 不能通过初始化列表来进行初始化 \
                   派生类被初始化后，会自动一个基类的对象（由编译器自动生成）
/*
 初始化列表
 
 与其他函数不同，构造函数除了有名字，参数列表和函数体之外，还可以有初始化列表，初始化列表以冒号开头，后跟一系列以逗号分隔的初始化字段。
 在C++中，struct和class的唯一区别是默认的访问性不同，而这里我们不考虑访问性的问题，所以下面的代码都以struct来演示
 注意： struct 也可以像 class 一样存在继承的关系。
 */
struct foo
{
    string name ;
    int id ;
    foo(string s, int i):name(s), id(i){} ; // 初始化列表
};

struct Test1
{
    Test1() // 无参构造函数
    {
        cout << "Construct Test1" <<"地址：" << this << endl ;
    }
    
    Test1(const Test1& t1) // 拷贝构造函数
    {
        cout << "Copy constructor for Test1" << endl ;
        cout << this << "===" << &t1 <<endl;
        this->a = t1.a ;
    }
    
    Test1& operator = (const Test1& t1) // 赋值运算符
    {
        cout << "assignment for Test1" << endl ;
        this->a = t1.a ;
        return *this;
    }
    
    int a ;
};
#define __condition__ 0
/*
===========》 构造函数的两个执行阶段
 1> 初始化阶段
 所有类类型的成员都会在初始化阶段初始化，即使该成员没有出现在构造函数的初始化列表中
 2> 计算阶段
 一般用于执行构造函数体内的赋值操作
 
 ==========》为什么要使用初始化列表？
 因为：
 使用初始化列表少了一次调用默认构造函数的过程（但是成员的初始化，仍然是有的---即：构造函数的初始化阶段是有的，而计算阶段不会被执行调用），这对于数据密集型的类来说，是非常高效的。
 
 =======-===》必须使用初始化列表的情况：
 常量成员，因为常量只能初始化不能赋值，所以必须放在初始化列表里面
 引用类型，引用必须在定义的时候初始化，并且不能重新赋值，所以也要写在初始化列表里面
 没有默认构造函数的类类型，因为使用初始化列表可以不必调用默认构造函数来初始化，而是直接调用拷贝构造函数初始化。
 */
struct Test2
{
    Test1 test1 ;
    Test2 () {
        cout << "默认构造函数！" << endl;
    }
#if __condition__
    Test2(Test1 &t1)
    {
        cout << "构造函数!" << endl;
        test1 = t1 ;///对test1执行赋值操作，这就是所谓的计算阶段。
        /*
         输出结果：
         Construct Test1地址：0x7fff5fbfccb8
         Construct Test1地址：0x7fff5fbfccb0
         构造函数!
         assignment for Test1
         */
    }
#else
    Test2(Test1 &t1):test1(t1) {
        cout << &test1 << endl;
        test1 = t1 ;
        /*
         输出结果：
         Construct Test1地址：0x7fff5fbfccb8
         Copy constructor for Test1
         0x7fff5fbfccb0===0x7fff5fbfccb8 --- 这里就可以看出：成员的初始化，仍然是有的---即：构造函数的初始化阶段是有的，而计算阶段不会被执行调用
         assignment for Test1
         */
    }
#endif
};


struct TestOne
{
    TestOne(int a):i(a){}
    int i ;
};

struct TestTwo
{
    const TestOne test1 ;
    /*
     错误写法：
     
     TestTwo(TestOne &t1)
     {
        test1 = t1 ;
     }
     因为Test2类中Test1 test1;需要调用默认的构造函数（这是因为 TestTwo 在构造函数处于初始化阶段的时候，会对 TestOne test1 成员变量进行初始化，调用其默认的构造函数）
     ，但是Test1类没有无参的构造函数，但是由于Test1没有默认的构造函数，故而编译错误
     */
    
    /*
     正确写法
     */
    TestTwo(TestOne &t1):test1(t1)
    {
        //test1 = t1 ;
    }
};

@implementation InitList
+ (void) load {
    NSLog(@"%s",_cmd);
    
    Test1 t1 ;
    Test2 t2(t1) ;
}
@end
