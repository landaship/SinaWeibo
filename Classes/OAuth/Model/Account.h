//
//  Account.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic , copy) NSString *accessToken;
@property (nonatomic, copy)NSString *uid;

@end
