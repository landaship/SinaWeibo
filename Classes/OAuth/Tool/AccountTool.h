//
//  AccountTool.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
// 管理所有账号信息

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"

@interface AccountTool : NSObject

singleton_interface(AccountTool)

- (void) saveAccount:(Account *)account;

// 获得当前账号
@property (nonatomic, readonly)Account *account;
@end
