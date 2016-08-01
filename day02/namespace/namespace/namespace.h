//
//  namespace.h
//  namespace
//
//  Created by lizhongqiang on 16/7/31.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef __cplusplus
//extern "C"
//{
    // namespace
    /*
    using namespace std，这样命名空间std内定义的所有标识符都有效（曝光）。就好像它们被声明为全局变量一样。因为标准库非常的庞大，所以程序员在选择的类的名称或函数名时就很有可能和标准库中的某个名字相同。建议使用using std::cin的格式，即：用什么就使用该命名空间。不要全盘加入，否则会造成不必要的麻烦。
     
     * 有两种形式的命名空间 --- 有名的 和 无名的
     * 命名空间的定义格式为：
     * 有名的
          namespace identifier { namespace-body }
     * 无名的
          namesapce { namespace-body }
     
     注意：当两次通过 namespace ASDS {} 来申明一个命名空间，第一次是初始化一个 命名空间，
          第二次是对该命名空间进行扩展
     */
    namespace ASDN {
        struct ScopeTimer {
            NSTimeInterval begin;
            NSTimeInterval &outT;
            ScopeTimer(NSTimeInterval &outRef) : outT(outRef), begin(10000){
                
            }
            ~ScopeTimer() {
                outT = 100000 - begin;
            }
        };
    }
    /*
     命名空间嵌套
     */
    namespace Outer {
        namespace Inner {
        }
    }
    
    namespace ASDN {
        struct Mutex {
            
        };
    }

    namespace ASDN {
#warning 注意 这里的 Type ，只是泛型指针的一个名称代码，可以自定义为你需要的名称
        template<typename Type>
        /*
         template<typename T> 解析：
         
         class用于定义类，在模板引入c++后，最初定义模板的方法为：template<class T>，这里class关键字表明T是一个类型，后来为了避免class在这两个地方的使用可能给人带来混淆，所以引入了typename这个关键字，它的作用同class一样表明后面的符号为一个类型，这样在定义模板的时候就可以使用下面的方式了：       template<typename T>.在模板定义语法中关键字class与typename的作用完全一样。
         
         A.首先要定义类，其格式为：
         template <class T>
         class foo{ }
         在类定义体中，如采用通用数据类型的成员，函数参数的前面需加上T，其中通用类型T可以作为普通成员变量的类型，还可以作为const和static成员变量以及成员函数的参数和返回类型之用
         
         */
        class Locker {
        private:
            Type n;
            const Type i;
            static int cnt;
        public:
            Locker():i(0) {
            }
            Locker(Type k);
            ~Locker() {
            }
            void print();
            Type operator+ (Type x);
        };
    }
//}
#endif
@interface NameSpace : NSObject

@end
