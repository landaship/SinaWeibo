//
//  StatusFrame.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//  cell 里面所有控件的frame的model

#import <Foundation/Foundation.h>
@class Status;

@interface StatusFrame : NSObject

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

//    1.头像
@property (nonatomic, readonly) CGRect iconFrame;
//    2.昵称
@property (nonatomic, readonly) CGRect screenNameFrame;
//    2.1 会员标示
@property (nonatomic, readonly) CGRect mbIconFrame;
//    3.更新时间
@property (nonatomic, readonly) CGRect timeFrame;
//    4.消息来源
@property (nonatomic, readonly) CGRect sourceFrame;
//    5.内容
@property (nonatomic, readonly) CGRect textFrame;
//    6.配图
@property (nonatomic, readonly) CGRect imageFrame;

//    1.转发微博父控件
@property (nonatomic, readonly) CGRect reweetedFrame;
//    2..昵称
@property (nonatomic, readonly) CGRect reweetedScreeNameFrame;
//    3.内容
@property (nonatomic, readonly) CGRect reweetedTextFrame;
//    4.配图
@property (nonatomic, readonly) CGRect reweetedImageFrame;

@property (nonatomic, strong)Status *Status;
@end
