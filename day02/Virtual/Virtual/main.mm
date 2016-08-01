//
//  main.m
//  Virtual
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "One.h"
#import <iostream>
// http://blog.csdn.net/ljianhui/article/details/46487951 C++ 对象模型之 RTTI 的实现原理
using namespace std;
/*
 纯虚函数是在基类中声明的虚函数，它在基类中没有定义，但要求任何派生类都要定义自己的实现方法。
 在基类中实现纯虚函数的方法是在函数原型后加“=0”
 
 引入原因：
 1、为了方便使用多态特性，我们常常需要在基类中定义虚拟函数。
 2、在很多情况下，基类本身生成对象是不合情理的。例如，动物作为一个基类可以派生出老虎、孔雀等子类，
    但动物本身生成对象明显不合常理。
 
 为了解决上述问题，引入了纯虚函数的概念，将函数定义为纯虚函数（方法：virtual ReturnType Function()= 0;），
 则编译器要求在派生类中必须予以重载以实现多态性。同时含有纯虚拟函数的类称为抽象类，它不能生成对象。
 这样就很好地解决了上述两个问题
 
 1、多态性
 指相同对象收到不同消息或不同对象收到相同消息时产生不同的实现动作。C++支持两种多态性：编译时多态性，运行时多态性。
 a.编译时多态性：通过重载函数实现
 b 运行时多态性：通过虚函数实现。
 
 2、虚函数
 虚函数是在基类中被声明为virtual，并在派生类中重新定义的成员函数，可实现成员函数的动态重载
 
 3、抽象类
 包含纯虚函数的类称为抽象类。由于抽象类包含了没有定义的纯虚函数，所以不能定义抽象类的对象。
 */
class X
{
public:
    virtual ~X()
    {
        cout << "X::~X()" << endl;
    }
    virtual void print()
    {
        cout << "X::print()" << endl;
    }
    int mData;
};
class XX : public X
{
public:
XX():X() {
    
}
    virtual ~XX()
    {
        cout << "XX::~XX()" << endl;
    }
    virtual void print()
    {
        cout << "XX::print()" << endl;
    }
    int mN;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        X *x = new XX;
        x->print();
        delete x;
        /*
         XX::print()
         XX::~XX()
         X::~X()
         
         从运行结果可以看出，利用X的指针调用print函数，调用的是类XX的print函数，且在delete析构时也是调用了类XX的析构函数，先析构派生类再析构基类。
         注意：如果这个 print 函数不是 virtual 虚函数的话，此时 x->print();会调用父类的 print 函数，
              个人理解：加上 virtual 关键字的话，编译器，会利用多态，正确的辨认该 x 变量的类型，然后正确调用
                      而不加 virtual 关键字，则会，很死板的认为，什么类型的指针引用，就从该类型中查找方法，如果该类没有改方法，就会编译不通过，不会动态的来辨认该变量的类型
         */
        One *one = [[One alloc]init];
        [one run];
    }
    return 0;
}
