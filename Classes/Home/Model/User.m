//
//  User.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.screen_name = dict[@"screen_name"];
        self.profile_image_url = dict[@"profile_image_url"];
        self.verified = [dict[@"verified"]intValue];
        self.verified_type =  [dict[@"verified_type"]intValue];
        self.mbrank =  [dict[@"mbrank"]intValue];
        self.mbtype =  [dict[@"mbtype"]intValue];
    }
    
    return self;
}

@end
