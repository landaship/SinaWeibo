//
//  Status.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//    微博信息模型

#import <Foundation/Foundation.h>
#import "User.h"

@interface Status : NSObject

-(Status *) initWithDict:(NSDictionary *)dict;

@property (nonatomic, copy)NSString *text;   // 微博信息内容
@property (nonatomic, strong)User *user;   // 微博作者的用户信息字段
@property (nonatomic, strong) NSArray *pic_urls; //微博配图地址。多图时返回多图链接。无配图返回“[]”
@property (nonatomic, copy)NSString *source; //微博来源
@property (nonatomic, strong) Status *retweeted_status;//被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic, assign)int reposts_count;//转发数
@property (nonatomic, assign)int comments_count;//评论数
@property (nonatomic, assign)int attitudes_count;//表态数
@property (nonatomic, copy)NSString *created_at; //	微博创建时间
@property (nonatomic, assign) long long ID; // 微博ID

@end
