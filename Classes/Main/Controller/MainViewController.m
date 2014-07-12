
//
//  MainViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-19.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "MainViewController.h"
#import "DockViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "SquareViewController.h"
#import "MoreViewController.h"
#import "YENavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    
    // 2.添加Dock
    [self addDockItems];
}

- (void)addAllChildControllers
{
    // 1.首页
    HomeViewController *home = [[HomeViewController alloc] init];
    //    TestViewController *home = [[TestViewController alloc]init];

    YENavigationController *nav1 = [[YENavigationController alloc] initWithRootViewController:home];
    nav1.delegate = self;
    // self在，添加的子控制器就存在
    [self addChildViewController:nav1];
    
    // 2.消息
    MessageViewController *msg = [[MessageViewController alloc] initWithStyle:UITableViewStyleGrouped];
    YENavigationController *nav2 = [[YENavigationController alloc] initWithRootViewController:msg];
    nav2.delegate = self;
    [self addChildViewController:nav2];
    
    // 3.我
    MeViewController *me = [[MeViewController alloc] init];
    YENavigationController *nav3 = [[YENavigationController alloc] initWithRootViewController:me];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    // 4.广场
    SquareViewController *square = [[SquareViewController alloc] init];
    YENavigationController *nav4 = [[YENavigationController alloc] initWithRootViewController:square];
    nav4.delegate = self;
    [self addChildViewController:nav4];
    
    // 5.更多
    MoreViewController *more = [[MoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    YENavigationController *nav5 = [[YENavigationController alloc] initWithRootViewController:more];
    nav5.delegate = self;
    [self addChildViewController:nav5];
}

- (void) addDockItems
{
    // MainViewController 继承自DockViewController
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];

    // 添加每一个items：包括：image lable还有action
    [_dock addItemWithIcon:@"tabbar_home.png" SelectedIcon:@"tabbar_home_selected.png" lableTitle:@"首页"];
    [_dock setFocusItem:0];
    
    [_dock addItemWithIcon:@"tabbar_message_center.png" SelectedIcon:@"tabbar_message_center_selected.png" lableTitle:@"消息"];
    
    [_dock addItemWithIcon:@"tabbar_profile.png" SelectedIcon:@"tabbar_profile_selected.png" lableTitle:@"我"];
    
    [_dock addItemWithIcon:@"tabbar_discover.png" SelectedIcon:@"tabbar_discover_selected.png" lableTitle:@"广场"];
    
    [_dock addItemWithIcon:@"tabbar_more.png" SelectedIcon:@"tabbar_more_selected.png"  lableTitle:@"更多"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 设置默认不支持屏幕翻转
-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - 设置屏幕支持的翻转方向，在shouldAutorotate为YES时起作用
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 即将推出下一个VC
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController  *root = navigationController.viewControllers[0];
    if ([viewController isKindOfClass:[root class]]) { // 如果是主页VC，则Dock不动
        // 拉伸frame
        CGRect rect = navigationController.view.frame;
        rect.size.height =  [UIScreen mainScreen].applicationFrame.size.height - _dock.frame.size.height + 20;
        
        NSLog(@"－－rect:%@", NSStringFromCGRect(rect));
        navigationController.view.frame = rect;
    }
    else
    {
        // 拉伸frame
        CGRect rect = navigationController.view.frame;
        rect.size.height = [UIScreen mainScreen].applicationFrame.size.height + 20;

        NSLog(@"＋＋rect:%@", NSStringFromCGRect(rect));
        navigationController.view.frame = rect;
    }
}

#pragma mark - 已经推出下一个VC
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}


@end
