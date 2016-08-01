//
//  namespace.m
//  namespace
//
//  Created by lizhongqiang on 16/7/31.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "NameSpace.h"
using namespace ASDN;
#warning  http://developer.51cto.com/art/201002/182803.htm \
          模板参数：指模板类构造函数调用时，传入的参数，通常 模板类构造函数，是拿 class T 来接受的 \
          


//类模板 在使用时必须由指定明确。
//      typedef只是定义别名，vector 的模板参数必须指定清楚
typedef Locker<Mutex> lock;//typedef Locker<Mutex> lock;

@implementation NameSpace

//B. 在类定义体外定义成员函数时，若此成员函数中有模板参数存在，\
     则除了需要和一般类的体外定义成员函数一样的定义外，还需在函数体外进行模板声明
template <class T>
void Locker<T>::print(){
}

template <class T>
T Locker<T>::operator+ (T x){
    
}

// C. 在类定义体外初始化const成员和static成员变量的做法和普通类体外初始化const成员和static成员变量的做法基本上是一样的，唯一的区别是需再对模板进行声明，
template<class T>
int Locker<T>::cnt=0;

+ (void)load {
    
}

@end
