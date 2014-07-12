//
//  StatusTool.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//  管理微博的工具类

#import <Foundation/Foundation.h>

typedef void (^statusSuccessBlock) (NSArray *status);
typedef void (^statusFailureBlock) (NSError *error);

@interface StatusTool : NSObject

+ (void)statusWithSinceID:(long long)sinceID maxID:(long long)maxID  Success:(statusSuccessBlock)Success failure:(statusFailureBlock)failure;

@end
