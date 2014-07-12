//
//  DockViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-21.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "DockViewController.h"
#import "Dock.h"

#define kDockHight 44   // Dock的高

@interface DockViewController () <DockDelegate>

@end

@implementation DockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 这里需要继承DockViewController，这样就能够把Dock这个类独立出来了，减少耦合性
    [self addDock];
}

#pragma mark - 添加Dock
- (void) addDock
{
    Dock *dock = [[Dock alloc]init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHight, 320, kDockHight);
    dock.delegate = self;
    
    [self.view addSubview:dock];
    _dock = dock;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 收到消息
-(void)itemSelected:(Dock *)dock fromItemNum:(int)from toItemNum:(int)to
{
    // 过滤掉错误的选项，防止段错误
    if (to < 0 || to >= self.childViewControllers.count) return;
    
    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
//    newVc.view.backgroundColor = [UIColor redColor];
    
    //    newVc 是navigationcontroller 不是homeVC
    //    NSLog(@"t newVc.view.frame :%@", NSStringFromCGRect(  newVc.view.frame));
    //    NSLog(@"newvc :%@", newVc);
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
}

@end
