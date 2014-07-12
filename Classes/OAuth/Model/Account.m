//
//  Account.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
// 用户数据保存

#import "Account.h"

@implementation Account

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_accessToken forKey:@"accessToken"];
    [encoder encodeObject:_uid forKey:@"uid"];
}

@end
