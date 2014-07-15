//
//  User.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
// 用户模型

#import "BaseModel.h"

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

@interface User : BaseModel
@property (nonatomic, copy) NSString *screenName;  //用户昵称
@property (nonatomic, copy) NSString *profileImageUrl;  //用户头像地址（中图），50×50像素
@property (nonatomic, assign) BOOL verified; //是否是微博认证用户，即加V用户
@property (nonatomic, assign) VerifiedType verifiedType; // 认证类型
@property (nonatomic, assign) int mbrank; // 会员等级
@property (nonatomic, assign) MBType mbtype; // 会员类型
@end

