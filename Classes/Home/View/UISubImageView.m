//
//  UISubImageView.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-7.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "UISubImageView.h"
#import "HttpTools.h"

@implementation UISubImageView
{
    UIImageView *_gifView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
    
    // 1.加载图片
    [HttpTools setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"Icon.png"] addToView:self];
    
    // 2. 判断图片类型
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
//    _gifView.hidden = NO;
}

-(void)setFrame:(CGRect)frame
{
    CGRect rect = _gifView.frame;
    rect.origin.x = frame.size.width - rect.size.width;
    rect.origin.y = frame.size.height - rect.size.height;
    _gifView.frame = rect;
    
    [super setFrame:frame];
}

@end
