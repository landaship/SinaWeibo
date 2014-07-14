//
//  YENavigationController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-25.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "YENavigationController.h"

@interface YENavigationController ()

@end

@implementation YENavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 2.设置导航栏的背景图片 --背景图片高度不对导致的那个现象
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;

    // 3.设置导航栏文字的主题
    //    [bar setTitleTextAttributes:@{
    //                                  NSForegroundColorAttributeName : [UIColor blackColor]
    //                                  UITextAttributeTextColor : [UIColor blackColor],
    //                                  UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
    //                                  }];

    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 5.修改item的背景图片
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 修改item上面的文字样式
//    NSDictionary *dict = @{
//                           UITextAttributeTextColor : [UIColor darkGrayColor],
//                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
//                           };
//    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
