//
//  BaseStatusCell.h
//  新浪微博
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  

#import "BaseWordCell.h"

@class BaseStatusCellFrame;
@interface BaseStatusCell : BaseWordCell
{
    UIImageView *_retweeted; // 被转发微博的父控件
}
@property (nonatomic, strong) BaseStatusCellFrame *cellFrame;
@end