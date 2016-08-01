//
//  main.m
//  Template
//
//  Created by lizhongqiang on 16/7/29.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "One.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        One *one = [[One alloc]init];
        [one sayGreeting];
        
        Hello *hello = new Hello();
        [one sayGreeting:hello];
        
        
        delete hello;
    }
    return 0;
}
