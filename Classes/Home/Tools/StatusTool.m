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

@end
