//
//  BaseText.m
//  新浪微博
//
//  Created by apple on 13-11-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseText.h"
#import "User.h"

@implementation BaseText
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.text = dict[@"text"];
        self.user = [[User alloc] initWithDict:dict[@"user"]];
    }
    return self;
}
@end
