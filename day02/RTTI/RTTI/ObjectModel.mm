//
//  ObjectModel.m
//  RTTI
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ObjectModel.h"
#import <iostream>
using namespace std;

//http://blog.csdn.net/ljianhui/article/details/45903939
//http://blog.csdn.net/ljianhui/article/details/46247897 C++ 对象模型之默认构造函数的构造操作

//#ifdef __cpulsplus
class Person {
public:
    Person():mId(0),mAge(20) // ===> 初始化列表中添加：mId, mAge 两个基本类型的初始化
    {
    }
    virtual void print()
    {
        cout << "id: " << mId
        << ", age: " << mAge << endl;
    }
    virtual void job()
    {
        cout << "Person" << endl;
    }
    virtual ~Person()
    {
        //--sCount;
        cout << "~Person" << endl;
    }
    
    
    
private:
//    static int sCount;
    int mId;
    int mAge;
    
};
//#endif
@implementation ObjectModel
+ (void)load {
    Person p1;
    cout << "sizeof(p1) == " << sizeof(p1) << endl;
    int *p = (int*)&p1;
    cout << "p.id == " << *p << ", address: "  << p << endl;
    ++p;
    cout << "p.age == " << *p << ", address: " << p << endl;
    ++p;
    cout << "p == " << typeid(p).name() << ", address: " << p << endl;
    cout << endl;
    
    Person p2;
    cout << "sizeof(p2) == " << sizeof(p1) << endl;
    p = (int*)&p2;
    cout << "p.id == " << *p << ", address: " << p << endl;
    ++p;
    cout << "p.age == " << *p << ", address: " << p << endl;
    ++p;
    cout << "p == " << typeid(p).name() << ", address: " << p << endl;
    /*
     ==========》含有static和非static成员变量和成员函数的类的对象的内存分布
     据此，可以得出结论，在C++中，非static被被放置于每一个类对象中，
     而 static 成员变量被放在类对象之外，
     非static成员函数放在类的对象之外，
     且非static成员变量在内存中的存放顺序与其在类内的声明顺序一致。
     */
    
    
    Person person;
    cout << sizeof(person) << endl;
    p = (int*)&person;
    for (int i = 0; i < sizeof(person) / sizeof(int); ++i, ++p)
    {
        cout << *p << endl;
    }
    /*
     ===========》 加入virtual成员函数的类的对象的内存分布
     加virtual成员函数后，类的对象的大小为16字节，增加了8。
     通过int＊指针遍历该对象的内存，可以看到，最后两行显示的是成员数据的值。
     
     可以大胆的猜测：
     C++中的虚函数是通过虚函数表（vtbl）来实现，每一个类为每一个virtual函数产生一个指针，放在表格中，这个表格就是虚函数表。每一个类对象会被安插一个指针（vptr），指向该类的虚函数表。vptr的设定和重置都由每一个类的构造函数、析构函数和复制赋值运算符自动完成。
     
     在64位的系统，一个指针的大小为8字节，所以可以推出，在该的环境中，类的对象的安插的vptr放在该对象所占内存的最前面
     */
    
    typedef void (*FuncPtr)();
    /*
     代码解释：
     由于虚函数表位于对象的首位置上，且虚函数表保存的是函数的指针，若把虚函数表当作一个数组，则要指向该数组需要一个双指针。我们可以通过如下方式获取Person类的对象的地址，并转化成int**指针：
     
     int **p
     解释：首先变量p和指针运算符*结合，表明这是一个指针
          然后再和第二个*结合表明这个指针指向的是一个指针的地址
     
     这里 之所以 需要用到两次取指针获取 Person 实例对象的首地址，是因为
     Person personOne 变量本身就是一个指向实例变量首地址的指针，
     */
    Person personOne ;
    // 1. 获取实例对象的首地址（带有虚函数的首地址，是一个二级指针）
    // 这里之所以用 int ** 来接收，是因为：&personOne 对象，首地址，执行的值，存的就是一个虚函数表指针，因此需要拿一个 ** 双指针接收 personOne 对象的首地址
    int **vtbl = (int**)&personOne;
    // 2. 获取虚函数表的首地址（同样虚函数表的首地址，也是一个二级指针，第二级指针，指向的是方法函数的地址）
    // *vtbl 是取地址内存中的值，因为该值是指向一个虚函数表的指针，所以也需要用 ** 来接受首地址存着的值（即：虚函数表的首地址）
    int **funct = (int **)*vtbl;
    for (int i = 0; i < 2 && *funct != NULL; ++i)
    {
        cout << *vtbl <<"==" <<typeid(**funct).name()<< endl;
        FuncPtr func = (FuncPtr)*funct;
        func();
        ++funct;
    }
//
    cout << "开始输出 " <<endl;
    
//    vtbl += 2;
    while (*funct)
    {
        cout << "*vtbl == " << *funct << endl;
//        type_info *info = dynamic_cast<type_info *>((type_info *)vtbl);
//        if (info) {
//            cout << "*vtbl == " <<((type_info *)vtbl)->name() << *vtbl << endl;
//        }
        
        ++funct;
    }
}
@end
