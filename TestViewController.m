//
//  TestViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-11.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    NSLog(@"test vc frame: %@", NSStringFromCGRect(self.view.frame));
    //    NSLog(@"test navigaton contentview frame: %@", NSStringFromCGSize(self.navigationController.preferredContentSize));
    //
    //    NSLog(@"self :%@", self);
    //    NSLog(@"self.navigation:%@", self.navigationController);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 80, 100);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"string" forState:UIControlStateNormal];
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
