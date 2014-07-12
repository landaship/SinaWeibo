//
//  UIPictureCell.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-7.
//  Copyright (c) 2014年 Louis. All rights reserved.
//  类功能：实现微博分享图片的布局展示

#import <UIKit/UIKit.h>

@interface UIPictureCell : UIView

// 分享的图片
@property (nonatomic, strong)NSArray *pictures;

+ (CGSize) UIPictureCellSizeWithCount:(int) count;

@end
