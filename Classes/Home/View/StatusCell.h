//
//  StatusCell.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//  自定义每一条微博的内容

#import <Foundation/Foundation.h>
#import "StatusFrame.h"

@interface StatusCell : UITableViewCell

@property (nonatomic, strong) StatusFrame *statusFrame;

@end
