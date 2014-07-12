//
//  MessageViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-25.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "MessageViewController.h"
#import "CustomCell.h"


@interface MessageViewController ()

@end

@implementation MessageViewController

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
    self.title = @"消息";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 设置有几个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark 设置section中有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.myTableView = tableView;
    }
    
    // 设置titile
    cell.textLabel.text = [NSString stringWithFormat:@"消息 %d %d",indexPath.section,  indexPath.row];
    
    // 设置背景
    cell.indexPath = indexPath;
    
    // 设置accssory 图标样式
    if (indexPath.section == 0)
    {
        cell.accessoryViewStyle = kAccessoryViewStyleSwith;
    }
    else
    {
        cell.accessoryViewStyle = kAccessoryViewStyleArrows;
    }
    
    return cell;
}
@end
