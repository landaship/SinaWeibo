//
//  DetailViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-11.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "DetailViewController.h"
#import "UIButton+YE.h"

// 底部转发评论栏的高度
#define kToolImageVIewH 44

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    // 0. 设置标题
    self.title = @"微博正文";
    
    // 2.让Dock一起返回和消失
           // 在MainViewController里实现
    
    // 3.添加底部转发评论条
    [self addToolBarVIew];
    
    self.view.backgroundColor = kHomeViewBackGroundColor;
}

#pragma mark 重写这个方法的目的。去掉父类默认的操作：显示滚动条
- (void)viewDidAppear:(BOOL)animated { }

#pragma mark - addToolBarVIew
- (void) addToolBarVIew
{
    UIImageView *toolBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kToolImageVIewH, 320, kToolImageVIewH)];
    
    // 1. 添加背景
    toolBarView.backgroundColor = kHomeViewBackGroundColor;
    
    // 2.添加Items到toolImageView上
    UIButton *commentBtn = [UIButton buttonWithImageNomal:@"statusdetail_comment_icon_comment" imageSelected:@"statusdetail_comment_icon_comment_highlighted.png"];
    [toolBarView addSubview:commentBtn];
    
    UIButton *retweetedBtn = [UIButton buttonWithImageNomal:@"statusdetail_comment_icon_comment" imageSelected:@"statusdetail_comment_icon_comment_highlighted.png"];
    [toolBarView addSubview:retweetedBtn];
    
    UIButton *likeBtn = [UIButton buttonWithImageNomal:@"statusdetail_comment_icon_comment" imageSelected:@"statusdetail_comment_icon_comment_highlighted.png"];
    [toolBarView addSubview:likeBtn];
    
    // 3. 设置文字标题
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [retweetedBtn setTitle:@"转发" forState:UIControlStateNormal];
    [likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    
    // 4.调节item的frame
     commentBtn.frame = CGRectMake(0, 0, 80, 40);
     retweetedBtn.frame = CGRectMake(90, 0, 80, 40);
     likeBtn.frame = CGRectMake(180, 0, 80, 40);
    
    // 3.添加到主视图
    [self.view addSubview:toolBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =  [NSString stringWithFormat:@"第%d行 第%d列",  indexPath.section, indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end
