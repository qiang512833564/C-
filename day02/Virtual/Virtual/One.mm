//
//  One.m
//  Virtual
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "One.h"
#import <iostream>
using namespace std;

//基类:
//纯虚函数相当于接口，不能直接实例话，需要派生类来实现函数定义
//它的作用就是为了能让这个函数在它的子类里面可以被重载，这样的话，这样编译器就可以使用后期绑定来达到多态了
//纯虚函数的类用于“介面继承”，主要用于通信协议方面。关注的是接口的统一性，实现由子类完成。
class A
{
public:
    void f1() { // 普通类函数
        printf("父类实现f1方法\n");
    }
    virtual void f2() = 0;
    virtual void f3() = 0; // 纯虚函数   纯虚函数只是继承接口，子类必须重新定义，否则编译不通过
    virtual void f4() {    // 虚函数
        printf("父类实现f4方法\n");
    }
    /*
     虚类的，不能被声明为 虚函数
    virtual  A(){
        
    }*/
    virtual ~A() {
        printf("父类析构函数\n");
    }
};

//子类:
class B : virtual public A
// C++的虚基类　　在派生类继承基类时，加上一个virtual关键词则为虚拟基类继承
{
public:
    void f1() {
        printf("子类实现f1方法\n");
    }
    void f2() {
        printf("子类实现f2方法\n");
    }
    void f3() {
        printf("子类实现f3方法\n");
    }
    void f4();
    /*
     派生类构造函数的调用次序有三个原则:
     1. 虚基类的构造函数在非虚基类之前调用
     2. 若同一层次中包含多个虚基类，这些虚基类的构造函数按它们说明的次序调用
     3. 若虚基类由非虚基类派生而来，则仍先调用基类构造函数，再调用派生类的构造函数
     */
    ~B(){
        printf("子类析构函数\n");
    }
};

void B::f4() {
    {
        printf("子类实现f4方法\n");
    }
}

@implementation One

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)run {
    A *m_j = new B();
    m_j->f1();
    m_j->f2();
    m_j->f3();
    m_j->f4();
    delete dynamic_cast<B*>(m_j);
}

@end
