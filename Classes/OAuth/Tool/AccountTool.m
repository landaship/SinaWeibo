//
//  AccountTool.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "AccountTool.h"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

singleton_implementation(AccountTool)

-(id) init
{
    if (self = [super init]) {
        // 读取沙盒数据
        _account =  [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    
    return self;
}

- (void) saveAccount:(Account *)account
{
    // 归档一个账号
    _account = account;
    
    // 归档数据
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

@end
