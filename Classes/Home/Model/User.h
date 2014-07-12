//
//  User.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
// 用户模型

#import <Foundation/Foundation.h>

@interface User : NSObject

typedef enum {
    kVerifiedTypeNone = - 1, // 没有认证
    kVerifiedTypePersonal = 0, // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    kVerifiedTypeDaren = 220 // 微博达人
} VerifiedType;

typedef enum {
    kMBTypeNone = 0, // 没有
    kMBTypeNormal, // 普通
    kMBTypeYear // 年费
} MBType;

- (User *) initWithDict:(NSDictionary *)dict;

@property (nonatomic, copy)NSString *profile_image_url;  //用户头像地址（中图），50×50像素
@property (nonatomic, copy)NSString *screen_name; //用户昵称
@property (nonatomic, assign)BOOL verified; //是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic, assign)VerifiedType verified_type; // 认证类型 3 企业认证
@property (nonatomic, assign) MBType mbrank; // 会员等级
@property (nonatomic, assign) int mbtype; // 会员类型

@end
