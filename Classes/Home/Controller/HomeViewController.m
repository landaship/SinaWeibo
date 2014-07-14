//
//  HomeViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-25.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+YE.h"
#import "HttpTools.h"
#import "AccountTool.h"
#import "Status.h"
#import "User.h"
#import "StatusTool.h"
#import "StatusFrame.h"
#import "StatusCell.h"
#import "UIImage+YE.h"
#import "DetailViewController.h"

// 展示更新了几条微博的button的高度
#define kShowNewStatusButtonH 35

@interface HomeViewController ()
{
    NSMutableArray *_statusFrameArrary;
}

@end

@implementation HomeViewController  

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 320 *460
    //    NSLog(@"%s HomeViewController的Frame:%@", __FUNCTION__,     NSStringFromCGRect(self.view.frame));
    //    设置界面
    [self setUIView];
    
    //    加载微博数据
    [self loadWeiboData];
    
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark 重写这个方法的目的。去掉父类默认的操作：显示滚动条
- (void)viewDidAppear:(BOOL)animated { }

#pragma mark 设置界面
- (void)setUIView
{
    self.title = @"首页";
    
    self.navigationItem.leftBarButtonItem =
        [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png" highlightedIcon:@"navigationbar_compose_highlighted.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem =
        [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png" highlightedIcon:@"navigationbar_pop_highlighted.png" target:self action:@selector(popMenu)];
    
    // 4.背景颜色
    self.view.backgroundColor = kHomeViewBackGroundColor;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    // 添加下拉刷新 上拉加载控件
    MJRefreshHeaderView *headFresh = [MJRefreshHeaderView header];
    headFresh.scrollView = self.tableView;
    headFresh.delegate = self;
    //    [headFresh beginRefreshing];  一进来就主动加载数据，然后就出现了声音
    //    NSLog(@"self view frame :%@", NSStringFromCGRect( self.view.frame));
    //    NSLog(@"tableview frame :%@", NSStringFromCGRect( self.tableView.frame));
    MJRefreshFooterView *footerFresh = [MJRefreshFooterView footer];
    footerFresh.scrollView = self.tableView;
    footerFresh.delegate = self;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {  // 下拉刷新
        [self loadNewStatusData:refreshView];
    }
    else   // 上拉加载
    {
        [self loadMoreStatusData:refreshView];
    }
}

#pragma mark 上拉加载更多数据
- (void) loadMoreStatusData:(MJRefreshBaseView *)refreshView
{
    StatusFrame *f = [_statusFrameArrary lastObject ];
    Status *s = f.Status;
    long long maxID = s.ID;
    
    // 为什么要－1 maxID - 1
    [StatusTool statusWithSinceID:0 maxID:maxID - 1 Success:^(NSArray *status) {
        // 设置计算每个cell里面控件的高度
        NSMutableArray *newArrary = [NSMutableArray array];
        for (Status *s  in status) {
            // NSLog(@"sinceID:%lld", s.ID);// 数组的第一个数据是ID最大的，应该是最新的数据
            
            StatusFrame *f = [[StatusFrame alloc]init];
            f.Status = s;
            [newArrary addObject:f];
        }
        
        // 2.将newFrames整体插入到旧数据的后面
        [_statusFrameArrary addObjectsFromArray:newArrary];
        
        // 更新表格
        [self.tableView reloadData];
        
        // 停止刷新
        [refreshView endRefreshing];
        
    } failure:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}

#pragma mark 下拉加载新数据
- (void) loadNewStatusData:(MJRefreshBaseView *)refreshView
{
    StatusFrame *f = _statusFrameArrary.count ? _statusFrameArrary[0]: nil;
    Status *s = f.Status;
    long long sinceID = s.ID;
    
    [StatusTool statusWithSinceID:sinceID maxID:0 Success:^(NSArray *status) {
        // 设置计算每个cell里面控件的高度
        NSMutableArray *newArrary = [NSMutableArray array];
        for (Status *s  in status) {
            // NSLog(@"sinceID:%lld", s.ID);// 数组的第一个数据是ID最大的，应该是最新的数据
       
            StatusFrame *f = [[StatusFrame alloc]init];
            f.Status = s;
            [newArrary addObject:f];
        }

        [_statusFrameArrary insertObjects:newArrary atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newArrary.count)]];
        
        [self.tableView reloadData];
        
        // 停止刷新
        [refreshView endRefreshing];
        
        // 显示更新了对少条微博
        [self showStatusNum:newArrary.count];
    } failure:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}

#pragma mark 显示更新了多少条微博
- (void) showStatusNum:(NSInteger )count
{
    // 构建显示的button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;  // 取消按钮响应事件
    btn.adjustsImageWhenDisabled = NO;  // 防止按下的时候按钮变颜色
    
    // 设置标题
    NSString *title = count ? [NSString stringWithFormat:@"更新了%d 条微博", count]:@"当前没有新微博";
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  
    //设置背景图片
    [btn setBackgroundImage:[UIImage stretchImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];

    // 设置更新下拉条的Frame  一定要设置完背景神马之后才能设置frame，否则背景加载不出来
    CGFloat width = self.view.bounds.size.width;
    CGFloat y = self.navigationController.navigationBar.frame.size.height;
    btn.frame = CGRectMake(0,  y -  kShowNewStatusButtonH + 20, width, kShowNewStatusButtonH);

    // 动画显示
    NSTimeInterval timeInteral = 0.5;
    [UIView animateWithDuration:timeInteral animations:^{
        btn.transform =  CGAffineTransformMakeTranslation(0, kShowNewStatusButtonH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:timeInteral delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
           [btn removeFromSuperview];
        }];
    }];
    
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
}

#pragma mark 加载用户数据
- (void) loadWeiboData
{
    _statusFrameArrary = [NSMutableArray array];
    
    [StatusTool statusWithSinceID:0 maxID:0  Success:^(NSArray *status) {
        // 设置计算每个cell里面控件的高度
        for (Status *s  in status) {
            StatusFrame *f = [[StatusFrame alloc]init];
            f.Status = s;
            [_statusFrameArrary addObject:f];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"failure --- %@", error);
    }];
}

#pragma mark 发微博
- (void)sendStatus
{
    MyLog(@"发微博");
}

#pragma mark 弹出菜单
- (void)popMenu
{
    MyLog(@"弹出菜单");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrameArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 + 1 green:arc4random()%256/255.0  blue:arc4random()%256/255.0  alpha:2.5];
        
//        cell.textLabel.numberOfLines = 0;  // 自动换行
//        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
//        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
#if 1
    cell.statusFrame = _statusFrameArrary[indexPath.row];
   
#else
    
//    cell.textLabel.text = text;
//    cell.detailTextLabel.text = status.user.screen_name;
//    
//    // 这两个的frame后来都自动变化了
//    //    CGRect rect =  cell.textLabel.frame;
//    //    CGRect rect2 = cell.detailTextLabel.frame;
//    //    
//    //    NSLog(@"rect:%@, rect2:%@", NSStringFromCGRect(rect), NSStringFromCGRect(rect2));
//
//    // 获取图片只能用异步的方式
//    //    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:status.user.profile_image_url]];
//    //    cell.imageView.image = [UIImage imageWithData:data];
//#pragma mark - 用SDWebImage框架加载图片
//    // 有占位图标  还有加载图片的优先级
//    [cell.imageView setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
#endif
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 取出微博内容
//    Status *s = _dataArray[indexPath.row];
//    
//    NSString *text = s.text;
//    if (s.retweeted_status) {
//        text = [text stringByAppendingString:s.retweeted_status.text];
//    }
//    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
//
//     // 计算微博内容高度
//    CGSize textSize = [text
//                        //boundingRectWithSize:tableView.bounds.size
//                       boundingRectWithSize:CGSizeMake(220.0, 1000000)  // cell老是越界是因为这个计算值不对，宽的设置只能设置成220，否则计算出来的大小不正确，倒是显示越界
//                        options:NSStringDrawingUsesLineFragmentOrigin
//                        attributes:attribute
//                        context:nil].size;
//    
//    CGFloat detailTextHight = [UIFont systemFontOfSize:13.0].lineHeight;
//    
//    // 为什么会cell重叠了 不明白因为cell的高度计算错误了
    
//    CGFloat cellHight = detailTextHight + textSize.height + 10;
//
//    return  cellHight > 70 ? cellHight:70;
 
    return [_statusFrameArrary[indexPath.row] cellHeight];
}

#pragma mark - didSelectRowAtIndexPath
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc]init];

    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
