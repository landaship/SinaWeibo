//
//  UIButton+YE.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-20.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "UIButton+YE.h"

@implementation UIButton (YE)
+(UIButton *)buttonWithImageNomal:(NSString *)normal imageSelected:(NSString *)seleted
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:seleted] forState:UIControlStateSelected];
    
    return button;
}


@end
