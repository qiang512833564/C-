//
//  Typeid.m
//  RTTI
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "Typeid.h"
#import <iostream>

//http://blog.csdn.net/ljianhui/article/details/46487951

using namespace std;

typedef void (*FuncPtr) ();

@implementation Typeid
// RTTI -> 全称 runtime type information
///操作数的类型在编译时期是不能被确定的情况下，typeid运算符需要在程序运行时计算类型
/*
 多态的类型是可以在运行过程中被改变的，
 例如，一个基类的指针，在程序运行的过程中，它可以指向一个基类对象，也可以指向该基类的派生类的对象，而typeid运算符需要在运行过程中识别出该基类指针所指向的对象的实际类型，这就需要typeid运算符在运行过程中计算其指向的对象的实际类型。
 
 多态类型是通过在类中声明一个或多个virtual函数来区分的。因为在C++中，一个具备多态性质的类，正是内含直接声明或继承而来的virtual函数。
 
 typeid 
 关于多态类型的计算是通过基类指针或引用指向的对象（子对象）的虚函数表获得的。
 
 注意：在C++中即使一个类不具有多态的性质，仍然允许把一个派生类的指针赋值给一个基类的指针，会使得 typeid 判断有误，所以这个错误比较隐晦
 */

class X {
    virtual void printX() = 0;
};
class XX :public X {
    void printX() {
        cout << "XX::printX" << endl;
    }
};

+(void)load {
    int n = 0;
    cout << typeid(int).name()  << endl;//std::
    /*
     注：由于C++为了保证每一个类在程序中都有一个独一无二的类名，所以会对类名通过一定的规则进行改写，所以在这里显示的类名跟我们定义的有一些不一样，一般是在类名前加上 字母+数字 的前缀
     
     */
    my_type_info *info;
    children *child;
    cout << typeid(child).name() <<endl;
    cout << typeid(info).name() << endl;
    
    cout << typeid(*info).name() <<endl;
    cout << typeid(*child).name() <<endl;
    
    cout << typeid(Typeid).name() <<endl << "self=" << typeid(self).name() << endl;
    
    cout << "=================================================" << endl;
    
    
    FuncPtr func;
    
    XX x ;
    
    char *p = (char *)&x;
    // 获得虚函数表的地址
    int **vtb1 = (int **)*(int **)p;
    // 输出虚函数表的地址，即 vptr 的值
    //cout << p << vtb1 << endl;
    // 获得 type_info 对象的指针，并调用其 name 成员函数
    cout << "\t[-1]:" << (vtb1[-1]) << "->"
    << ((type_info *)(vtb1[-1]))->name() <<endl;
    
    // 调用第一个 virtual 函数
    cout << "\t[0]:" <<vtb1[0] << "->";
    func = (FuncPtr)vtb1[0];
    func();
    
    // 输出基类的成员变量的值
    p += sizeof(int **);
    cout << *(int *)p <<endl;
    // 输出派生类的成员变量的值
    p += sizeof(int);
    cout << *(int *)p <<endl;
    
    /*
     只有dynamic_case才能实现安全的向下转型。那么dynamic_case是如何实现的呢？有了上面typeid和虚函数表的知识后，这个问题并不难解释了，以转换1为例。
     1）计算指针或引用变量所指的对象的虚函数表的type_info信息，如下：
     *(type_info*)px->vptr[-1]
     2）静态推导向下转型的目标类型的type_info信息，即获取类XX的type_info信息
     3）比较1）和2）中获取到的type_info信息，若2）中的类型信息与1）中的类型信息相等或是其基类类型，则返回相应的对象或子对象的地址，否则返回NULL。
     */
}

@end
