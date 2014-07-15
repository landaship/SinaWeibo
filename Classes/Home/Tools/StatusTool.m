//
//  StatusTool.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTools.h"
#import "AccountTool.h"
#import "Status.h"
#import "Comment.h"

@implementation StatusTool

+ (void)statusWithSinceID:(long long)sinceID maxID:(long long)maxID  Success:(statusSuccessBlock)Success failure:(statusFailureBlock)failure
{
    [HttpTools getWithPath:@"2/statuses/home_timeline.json"
                     param:@{
                             @"access_token": [AccountTool sharedAccountTool].account.accessToken,
                             @"count":@5,
                             @"since_id":@(sinceID),
                             @"max_id":@(maxID)
                             }
     
                   success:^(id JSON) {
                       if (Success == nil) {
                           return ;
                       }
                       
                       NSMutableArray *statuses = [NSMutableArray array];
                       
                       NSArray *array = JSON[@"statuses"];
                       
                        //  直接拆分成能直接读取的数组
                       for (NSDictionary *dict in array) {
                           Status *s = [[Status alloc]initWithDict:dict];
                           [statuses addObject:s];
                       }
                   
                        // 回调block
                       Success(statuses);
                   }
     
                   failure:^(NSError *error) {
                       failure(error);
                   }];
}



+ (void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure
{
    [HttpTools getWithPath:@"2/comments/show.json"
                    param:@{
                                           @"id" : @(statusId),
                                           @"since_id" : @(sinceId),
                                           @"max_id" : @(maxId),
                                           @"count" : @20
                                    }
                   success:^(id JSON) {
                                           if (success == nil) return;
                                           
                                           // JSON数组（装着所有的评论）
                                           NSArray *array = JSON[@"comments"];
                                           
                                           NSMutableArray *comments = [NSMutableArray array];
                                           
                                           for (NSDictionary *dict in array) {
                                               Comment *c = [[Comment alloc] initWithDict:dict];
                                               [comments addObject:c];
                                           }
                                           
                                           success(comments, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
                                           
                    }
                   failure:^(NSError *error) {
                                           if (failure == nil) return;
                                           
                                           failure(error);
                                       }];
}

+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure
{
    [HttpTools getWithPath:@"2/statuses/repost_timeline.json"
                     param:@{
                                                                      @"id" : @(statusId),
                                                                      @"since_id" : @(sinceId),
                                                                      @"max_id" : @(maxId),
                                                                      @"count" : @20
                                                                      }
                   success:^(id JSON) {
                                                                          if (success == nil) return;
                                                                          
                                                                          NSArray *array = JSON[@"reposts"];
                                                                          
                                                                          NSMutableArray *reposts = [NSMutableArray array];
                                                                          
                                                                          for (NSDictionary *dict in array) {
                                                                              Status *r = [[Status alloc] initWithDict:dict];
                                                                              [reposts addObject:r];
                                                                          }
                                                                          
                                                                          success(reposts, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
                   }
                   failure:^(NSError *error) {
                              if (failure == nil) return;
                              
                              failure(error);
                       NSLog(@"error:%@", error);
                   }];
}

+ (void)statusWithId:(long long)ID success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure
{
    [HttpTools getWithPath:@"2/statuses/show.json"
                    param:@{
                                                           @"id" : @(ID),
                                                           }
                   success:^(id JSON) {
                                                               if (success == nil) return;
                                                               
                                                               Status *s = [[Status alloc] initWithDict:JSON];
                                                               
                                                               success(s);
                                                               
                                                           }
                   failure:^(NSError *error) {
                                                               if (failure == nil) return;
                                                               
                                                               failure(error);
                                                           }];
}

@end
