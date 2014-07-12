//
//  DockItem.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-21.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "DockItem.h"

#define kDockItemSelectedBG @"tabbar_slider.png"
#define kTitleRatio 0.3

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#pragma mark - 设置Item里字体和图片的属性
        // 设置文本居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // 设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置选中时的背景
        [self setBackgroundImage:[UIImage imageNamed:kDockItemSelectedBG] forState:UIControlStateSelected];
        
    }
    return self;
}

#pragma mark - 从写父类，防止点击；按钮时按钮高亮
- (void)setHighlighted:(BOOL)highlighted
{
    
}

#pragma mark - 系统带的调整图片的api
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * ( 1- kTitleRatio );
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
