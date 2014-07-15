//
//  StatusTool.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//  管理微博的工具类

#import <Foundation/Foundation.h>
@class Status;

typedef void (^statusSuccessBlock) (NSArray *status);
typedef void (^statusFailureBlock) (NSError *error);
typedef void (^CommentsSuccessBlock)(NSArray *comments, int totalNumber, long long nextCursor);
typedef void (^CommentsFailureBlock)(NSError *error);

typedef void (^RepostsSuccessBlock)(NSArray *reposts, int totoalNumber, long long nextCursor);
typedef void (^RepostsFailureBlock)(NSError *error);

typedef void (^SingleStatusSuccessBlock)(Status *status);
typedef void (^SingleStatusFailureBlock)(NSError *error);


@interface StatusTool : NSObject

+ (void)statusWithSinceID:(long long)sinceID maxID:(long long)maxID  Success:(statusSuccessBlock)Success failure:(statusFailureBlock)failure;

// 抓取某条微博的评论数据
+ (void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure;

// 抓取某条微博的转发数据
+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure;

// 抓取单条微博数据
+ (void)statusWithId:(long long)ID  success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure;
@end
