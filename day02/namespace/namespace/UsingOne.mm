//
//  UsingOne.m
//  namespace
//
//  Created by lizhongqiang on 16/7/31.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UsingOne.h"
#import "NameSpace.h"
#import <iostream>
using std::string;
using std::cout;
using std::endl;

@implementation UsingOne

+ (void)load {
    NSTimeInterval interval = 200;
    
    ASDN:: ScopeTimer *timer = new ASDN::ScopeTimer(interval);
    
    cout << "timer = " << timer->begin << endl;
}

@end
