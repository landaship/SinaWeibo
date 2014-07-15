//
//  Status.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-2.
//  Copyright (c) 2014年 Louis. All rights reserved.
//    微博信息模型

#import "BaseText.h"

@interface Status : BaseText
@property (nonatomic, strong) NSArray *picUrls; // 微博配图
@property (nonatomic, strong) Status *retweetedStatus; // 被转发的微博
@property (nonatomic, assign) int repostsCount; // 转发数
@property (nonatomic, assign) int commentsCount; // 评论数
@property (nonatomic, assign) int attitudesCount; // 表态数(被赞)
@property (nonatomic, copy) NSString *source; // 微博来源
@end


//@property (nonatomic, copy)NSString *created_at; //	微博创建时间
//@property (nonatomic, assign) long long ID; // 微博ID
//@property (nonatomic, copy) NSString *text;
//@property (nonatomic, strong) User *user;

//-(Status *) initWithDict:(NSDictionary *)dict;

//@end
