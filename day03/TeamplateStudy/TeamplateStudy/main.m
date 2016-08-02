//
//  main.m
//  TeamplateStudy
//
//  Created by HW on 16/8/2.
//  Copyright © 2016年 HW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootObject.h"

// 0-100(包括100),是内部保留的，所以在编码的时候需要注意.
/*
 __attribute__((constructor/destructor))
 若函数被设定为constructor属性，则该函数会在main（）函数执行之前被自动的执行。类似的，若函数被设定为destructor属性，则该 函数会在main（）函数执行之后或者exit（）被调用后被自动的执行。拥有此类属性的函数经常隐式的用在程序的初始化数据方面。
 例如：
 */
__attribute__((constructor(101))) void pre_proc_1(void)
{
    printf("\n%d pre_proc_1\n",__LINE__);
}

__attribute__((destructor(101))) void end_proc_1(void)
{
    printf("\n%d end_proc_1\n",__LINE__);
}

__attribute__((constructor(102))) void pre_proc_2(void)
{
    printf("\n%d pre_proc_2\n",__LINE__);
}

__attribute__((destructor(102))) void end_proc_2(void)
{
    printf("\n%d end_proc_2\n",__LINE__);
}
/// 从输出的信息看出，前处理都是按照优先级先后执行的，而后处理则是相反的。
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        void *obc = [RootObject new];
        objc_sendMessage(obc, sel_registerName("description"));
        //((void (*)(void *, SEL) )objc_msgSend)(obc, sel_registerName("description"));
        // insert code here...
    }
    return 0;
}
