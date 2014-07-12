//
//  Singleton.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#ifndef ________Singleton_h
#define ________Singleton_h

//h文件
#define singleton_interface(class)  +(class*)shared##class;

//m文件
#define singleton_implementation(class) \
static class  *_instance;\
+(class *)shared##class      \
{                                             \
    if (_instance == nil)           \
    {\
        _instance = [[self alloc]init];\
    }\
    \
    return _instance;\
}\
\
+ (id)allocWithZone:(NSZone *)zone\
{\
    static dispatch_once_t once_token;\
    dispatch_once(&once_token, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    \
    return _instance;\
}

#endif
