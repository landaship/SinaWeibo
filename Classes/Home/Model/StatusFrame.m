//
//  StatusFrame.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "StatusFrame.h"

@implementation StatusFrame

#pragma mark -  重写父类方法,重新计算cell高度
- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    _cellHeight += kStatusDockHeight;
}
@end
