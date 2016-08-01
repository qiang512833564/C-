//
//  Typeid.h
//  RTTI
//
//  Created by lizhongqiang on 16/7/30.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#if 1
#ifdef __cplusplus
///类type_info的定义大概如下：
class my_type_info
{
public:
//    my_type_info();
    bool operator== (const my_type_info&)const;
    bool operator!= (const my_type_info&)const;
    bool before(const my_type_info&)const;
    const char* name() const;
private:
//    my_type_info(const my_type_info&);
//    my_type_info& operator= (const my_type_info&);
};
#endif

extern "C" {
    class children:public my_type_info {
        
    };
    
}
#endif



@interface Typeid : NSObject

@end
