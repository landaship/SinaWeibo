
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
#import "TestViewController.h"
#import "UIBarButtonItem+YE.h"

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
    HomeViewController *home = [[HomeViewController alloc] initWithStyle:UITableViewStylePlain];
//    TestViewController *home = [[TestViewController alloc]init];`

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
    // 1. get the root vc
    UIViewController  *root = navigationController.viewControllers[0];
    if (viewController != root) { // 如果是根VC，则Dock不动
        // 拉长控制器
        CGRect viewFrame = navigationController.view.frame;
        viewFrame.size.height = [UIScreen mainScreen].applicationFrame.size.height + 20;
        navigationController.view.frame = viewFrame;
        
        navigationController.view.backgroundColor = [UIColor redColor];
        
        // 2. remove the dock from the mainVC
        [_dock removeFromSuperview];
        
        // 3. adjust the dock frame
        CGRect dockFrame = _dock.frame;
//        //dockFrame.origin.y =  navigationController.view.frame.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)root.view;
            
#pragma mark 郁闷这个为什么要这么加才有效果
            dockFrame.origin.y += scrollView.contentOffset.y -20 - 44;
        }
        _dock.frame = dockFrame;
        
        //4. add the dock to the new viewController
        [root.view addSubview:_dock];
        
        // 5. add return back item
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back.png" highlightedIcon:@"navigationbar_back_highlighted" target:self action:@selector(returnBack)];
    }
}

#pragma mark - 返回上一页
- (void) returnBack
{
    [self.childViewControllers[_dock.selectIndex] popViewControllerAnimated:YES];
}

#pragma mark - 已经推出下一个VC
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 1. get the root vc
    UIViewController  *root = navigationController.viewControllers[0];
    if (viewController == root) { // 如果是根VC，则Dock还原
        
        // 缩短控制器
        CGRect viewFrame = navigationController.view.frame;
#pragma mark 这个20到底是什么？
        viewFrame.size.height = [UIScreen mainScreen].applicationFrame.size.height - _dock.frame.size.height  + 20;
        navigationController.view.frame = viewFrame;
        
        // 2. remove the dock from the mainVC
        [_dock removeFromSuperview];
        
        // 3. adjust the dock frame
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y =  self.view.frame.size.height - 44;
        _dock.frame = dockFrame;
        
        //4. add the dock to the new viewController
        [self.view addSubview:_dock];
    }
}


@end
