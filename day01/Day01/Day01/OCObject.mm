//
//  OCObject.m
//  Day01
//
//  Created by lizhongqiang on 16/7/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "OCObject.h"
#import "CppObject.cpp"

@interface OCObject () {
    CppObject *wrapped;
}
@end
@implementation OCObject

- (void)exampleMethodWithString:(NSString *)str {
    std::string cpp_str([str UTF8String],[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    wrapped->ExampleMethod(cpp_str);
}

@end
