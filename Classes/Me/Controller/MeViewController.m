//
//  MeViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-25.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "MeViewController.h"
#import "UIImage+YE.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // 构建显示的button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;  // 取消按钮响应事件
    btn.adjustsImageWhenDisabled = NO;  // 防止按下的时候按钮变颜色
    NSString *title = @"当前没有新微博";
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    CGFloat width = self.view.bounds.size.width;
    CGFloat y = self.navigationController.navigationBar.frame.size.height;
    [btn setBackgroundImage:[UIImage stretchImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];

    // 设置更新下拉条的Frame
    btn.frame = CGRectMake(0,  y , width, 34);
      [self.view addSubview:btn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
