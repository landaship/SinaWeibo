//
//  Status.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "Status.h"
#import "StatusFrame.h"

@implementation Status


- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.picUrls = dict[@"pic_urls"];
        self.source = dict[@"source"];
        
        NSDictionary *dictStatus = dict[@"retweeted_status"];
        if (dictStatus) {
            self.retweetedStatus = [[Status alloc]initWithDict:dictStatus];
        }
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }

    return  self;
}

-(void)setSource:(NSString *)source
{
    int begin = [source rangeOfString:@">"].location + 1;
    int end = [source rangeOfString:@"</"].location;
    
    _source =  [NSString stringWithFormat:@"来自:%@", [source substringWithRange:NSMakeRange(begin, end - begin)]];
}

#pragma mark 为什么setter 和getter不能同时设置呢，必须写@synthesize才可以，如果不写synthesize则会自动生成带下划线的成员变量，从写以后就会
//-(NSString *)source
//{
//    int begin = [_source rangeOfString:@">"].location + 1;
//    int end = [_source rangeOfString:@"</"].location;
//    
//    return [NSString stringWithFormat:@"来自:%@", [_source substringWithRange:NSMakeRange(begin, end - begin)]];
//}

@end
