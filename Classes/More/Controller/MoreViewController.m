//
//  MoreViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-25.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

@interface LogoutBtn : UIButton

@end

@implementation LogoutBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    NSLog(@"contentRect.size.width:%f", contentRect.size.width);
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
    //   记住button里frame的width不由你控制，你填写多少都是320

//    return CGRectMake(10, 0, contentRect.size.width - 2*10, contentRect.size.height);
}

@end


#import "MoreViewController.h"
#import "UIImage+YE.h"
#import "CustomCell.h"
#import "AccountsController.h"

@interface MoreViewController () <UIActionSheetDelegate>
{
    NSArray *_data;
}

@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"更多";
    // 设置按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(settingClick)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];

    // 1.  读取plist数据
    [self readPlistData];
    
    // 3.调整试图
    [self adjustTableViewCell];
}

- (void) settingClick
{
    NSLog(@"settingClick");
}

#pragma mark - 调整视图
- (void) adjustTableViewCell
{
    // 设置tableview的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    
    // add a bottom button at the foot
    LogoutBtn *footButon = [LogoutBtn buttonWithType:UIButtonTypeCustom];
    [footButon  setImage:[UIImage stretchImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [footButon setImage:[UIImage stretchImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateSelected];
    
    //   记住button里frame的with不由你控制，你填写多少都是320
    footButon.bounds = CGRectMake(0, 0, 1000, 44);
    // 设置边距
    //    footButon.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [footButon setTitle:@"退出当前账号" forState:UIControlStateNormal];
    self.tableView.tableFooterView = footButon;
    [footButon addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 底部扩充10个像素
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

- (void) logoutClick
{
    //    NSLog(@"--------logoutcliek");
    UIActionSheet *logoutActionSheet = [[UIActionSheet alloc]initWithTitle:@"退出" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"这个是"otherButtonTitles:@"nage", nil];
    
    logoutActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    //    [self.view addSubview:logoutActionSheet];
    [logoutActionSheet showInView:self.view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _data.count - 1) {
        return 10;
    }
    
    return 0;
}
#pragma mark - 读取plist数据
- (void)readPlistData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"More" ofType:@"plist"];
    _data = [NSArray arrayWithContentsOfFile:path];
}

#pragma mark 设置多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
       NSLog(@"_data.count:%d", _data.count);
    return _data.count;
}

#pragma mark 设置每一个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"Cell";

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.myTableView = tableView;
    }

    // 取出这一行的数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    //    ios 7 this quality does not make effects
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    // 设置文字
    cell.textLabel.text = dict[@"name"];
    
    //    设置背景
    cell.indexPath = indexPath;
    
    //    设置样式
    if (indexPath.section == 2)
    {
        cell.accessoryViewStyle = kAccessoryViewStyleLable;
        cell.accessoryViewLable.text = indexPath.row?@"经典模式":@"有图模式";
    }
//    else if (indexPath.section ==  0)
//    {
//        cell.AccessoryViewStyle = kAccessoryViewStyleSwith;
//    }
    else
    {
        cell.accessoryViewStyle = kAccessoryViewStyleArrows;
    }

    return cell;
}

#pragma mark 设置section里有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_data[section] count:%d", [_data[section] count]);
    return [_data[section] count];
}

#pragma mark 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"section:%d row:%d", indexPath.section, indexPath.row);
    
#warning mark - 我草，这个为什么section的值会计算错误！！！！
    if (indexPath.section == 1) { // select the accout manage button
        AccountsController *accountVC = [[AccountsController alloc]init];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
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
