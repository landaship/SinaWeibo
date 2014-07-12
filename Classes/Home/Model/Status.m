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


-(Status *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.user = [[User alloc ]initWithDict:dict[@"user"]];
        
        self.pic_urls = dict[@"pic_urls"];
        self.source = dict[@"source"];
        self.created_at = dict[@"created_at"];
        self.ID = [dict[@"id"] longLongValue];
        
        NSDictionary *dictStatus = dict[@"retweeted_status"];
        if (dictStatus) {
            self.retweeted_status = [[Status alloc]initWithDict:dictStatus];
        }
        
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.attitudes_count = [dict[@"attitudes_count"] intValue];
    }

    return  self;
}

#pragma mark 重写created_at方法
-(NSString *)created_at
{
    // 1.获取微博时间NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_created_at];
    
    // 2.获得当前时间
    NSDate *now = [NSDate date];
    
    // 3.获得当前时间和微博发送时间的间隔（差多少秒）
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    // 4.根据时间间隔算出合理的字符串
    if (delta < 60) { // 1分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
    } else {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
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
