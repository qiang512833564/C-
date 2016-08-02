//
//  TemplateOne.h
//  TeamplateStudy
//
//  Created by HW on 16/8/2.
//  Copyright © 2016年 HW. All rights reserved.
//

#import <Foundation/Foundation.h>
struct S {
    short b[3];
}__attribute__((__aligned__));//__aligned__(16)
/*
 aligned (alignment)
 该属性设定一个指定大小的对齐格式（以字节 为单位）
 
 可以手动指定对齐的格式，同样，你也可以使用默认的对齐方式。如果aligned 后面不紧跟一个指定的数字值，那么编译器将依据你的目标机器情况使用最大最有益的对齐方式
 */

struct unpacked_struct {
    char c;
    int i;
}__attribute__((__aligned__(16)));
/*
 __attrubte__ ((packed)) 的作用就是告诉编译器取消结构在编译过程中的优化对齐,按照实际占用字节数进行对齐。
 使用该属性对struct 或者union 类型进行定义，设定其类型的每一个变量的内存约束。当用在enum 类型 定义时，暗示了应该使用最小完整的类型（it indicates that the smallest integral type should be used）。
 
 */
struct packed_struct {
    char c;
    int i;
    struct unpacked_struct s;
}__attribute__((__packed__));

@interface TemplateOne : NSObject

@end
