//
//  StatusDock.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-8.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "StatusDock.h"
#import "UIImage+YE.h"
#import "NSString+YE.h"
#import "StatusFrame.h"

@implementation StatusDock
{
    UIButton *_retweetBtn;
    UIButton *_unlikeBtn;
    UIButton *_commentBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  0.设置自动伸缩属性
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        self.userInteractionEnabled = YES;
    
        // 1.添加3个按钮
          _retweetBtn = [self addButtons:@"转发" icon:@"timeline_icon_retweet.png" backgroundImg:@"timeline_card_leftbottom.png" index:0];

       _unlikeBtn = [self addButtons:@"赞" icon:@"timeline_icon_unlike.png" backgroundImg:@"timeline_card_middlebottom.png" index:1];

        _commentBtn = [self addButtons:@"评论" icon:@"timeline_icon_comment.png" backgroundImg:@"timeline_card_rightbottom.png" index:2];
        
        // 2. 添加背景图片
        self.image = [UIImage stretchImage:@"timeline_card_bottom.png"];
    }
    return self;
}

- (UIButton *)addButtons:(NSString *)titile icon:(NSString *)icon backgroundImg:(NSString *)bgImg index:(NSInteger)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置标题
    [btn setTitle:titile forState:UIControlStateNormal];
    // 设置按钮图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 设置普通背景
    [btn setBackgroundImage:[UIImage imageNamed:bgImg] forState:UIControlStateNormal];
    // 设置高亮背景
    [btn setBackgroundImage:[UIImage imageNamed:[bgImg appendFileName:@"_highlighted"]] forState:UIControlStateHighlighted];

    // 设置按钮文字颜色
    [btn setTitleColor:kColor(188, 188, 188)   forState:UIControlStateNormal];
    // 设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    // 设置文字和图片的间隙位置
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
 
    // 设置按钮的frame
     CGFloat btnW =  self.bounds.size.width / 3;
    btn.frame = CGRectMake(btnW *index, 0, btnW , kStatusDockHeight);
    [self addSubview:btn];
    
    //  添加分隔线
    if (index != 0 ) {
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *diliverView = [[UIImageView alloc]initWithImage:image];
        diliverView.center = CGPointMake(btn.frame.origin.x, kStatusDockHeight * 0.5);
        [self addSubview:diliverView];
    }
    
    return btn;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2*kCellBorderWidth;
    frame.size.height = kStatusDockHeight;
    
    [super setFrame:frame];
}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    NSString *title = status.repostsCount ? [NSString stringWithFormat:@"%d", status.repostsCount]:@"转发";
    [_retweetBtn setTitle:title forState:UIControlStateNormal];
    
    title = status.commentsCount ? [NSString stringWithFormat:@"%d", status.commentsCount]:@"评论";
    [_commentBtn setTitle:title forState:UIControlStateNormal];
    
    title = status.attitudesCount ? [NSString stringWithFormat:@"%d", status.attitudesCount]:@"转发";
    [_unlikeBtn setTitle:title forState:UIControlStateNormal];
}
@end
