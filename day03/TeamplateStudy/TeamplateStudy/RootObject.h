//
//  RootObject.h
//  MVVMFrame
//
//  Created by HW on 16/8/2.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import <string.h>
struct MyClass {
    const char *name;
    Method method;
    IMP pointer;
};
typedef struct MyClass Cls;
/*
 事实上会有一个方法缓存来提升查找速度，像这样：
 id objc_msgSend(id self, SEL _cmd, ...)
 {
 Class c = object_getClass(self);
 IMP imp = cache_lookup(c, _cmd);
 if(!imp)
 imp = class_getMethodImplementation(c, _cmd);
 return imp(self, _cmd, ...);
 }
 通常为了速度，cache_lookup 使用 inline 函数实现。
 */
void objc_sendMessage(void *p, SEL sel) {
    Cls cls = *(Cls *)p;
    Method method = cls.method;
    const char *name = sel_getName(method_getName(method)) ;
    const char *invokeName = sel_getName(sel);
    int result ;
    strcmp(name, invokeName);
    if(result  == 0 ){
        IMP imp = method_getImplementation(method);
        imp();
    }
    cls.pointer();
}


/*
 用于声明一个根类:
 至于自己的根类有什么用处，我也不太清楚。能知道的是，由于不继承自NSObject，意味着没有-alloc,-init等方法。似乎是没办法实例化的。
 
 visibility用于设置动态链接库中函数的可见性，将变量或函数设置为hidden，则该符号仅在本so库中可见，在其他库中则不可见。
 
 
 gcc __attribute__ ((deprecated))，可以修饰函数或是某个个变量，对函数表明此函数属性指示存在某个函数，但如果使用这个不提倡使用的函数，编译器必须生成警告；对变量表明可以使用 deprecated 变量属性声明不提倡使用的变量，而不会导致编译器发出任何警告或错误。但是，对 deprecated 变量的任何访问都会生成警告，但仍会进行编译。警告指出了使用和定义变量的位置。这有助于确定不提倡使用特定定义的原因。
 　　在iOS的AvailabilityMacros 中，对__attribute__ ((deprecated)) 进行了宏定义，DEPRECATED_MSG_ATTRIBUTE(s)，其中s是可选参数表明编译是发出警告的内容，根据gcc标准其必须是字符串类型。
 */
__attribute__((objc_root_class))
__attribute__((visibility("default")))
@interface RootObject {
    Cls myIsa DEPRECATED_MSG_ATTRIBUTE("不能使用该属性");
}
+ (void *)new;//instancetype

- (void)description;
@end
