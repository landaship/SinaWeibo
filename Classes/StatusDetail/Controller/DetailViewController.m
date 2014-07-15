//
//  DetailViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-11.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "DetailViewController.h"
#import "UIButton+YE.h"

#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "DetailHeader.h"
#import "StatusTool.h"
#import "Status.h"
#import "CommentCellFrame.h"
#import "RepostCellFrame.h"
#import "Comment.h"
#import "RepostCell.h"
#import "CommentCell.h"
#import "MJRefresh.h"

// 底部转发评论栏的高度
#define kToolImageVIewH 44

@interface DetailViewController () <DetailHeaderDelegate, MJRefreshBaseViewDelegate>
{
    StatusDetailCellFrame *_detailFrame;
    NSMutableArray *_repostFrames; // 转发frame数据
    NSMutableArray *_commentFrames; // 评论frame数据
    
    DetailHeader *_detailHeader;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    BOOL _commentLastPage; // 评论数据是否为最后一页
    BOOL _repostLastPage; // 转发数据是否为最后一页
}
@end

@implementation DetailViewController

#pragma mark 重写这个方法的目的。去掉父类默认的操作：显示滚动条
- (void)viewDidAppear:(BOOL)animated { }

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0. 设置标题
    self.title = @"微博正文";
    self.view.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    
     // 1 . 设置微博详情的Frame
    _detailFrame = [[StatusDetailCellFrame alloc] init];
    _detailFrame.status = _status;
    
    // 2. 初始化转发和评论的数组
    _repostFrames = [NSMutableArray array];
    _commentFrames = [NSMutableArray array];
    
    // 3. 添加上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    footer.hidden = YES;
    _footer = footer;
    
    // 4. 添加下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    _header = header;
    
    // 5. 添加代理
    _detailHeader = [DetailHeader header];
    _detailHeader.delegate = self;

    // 6. 默认点击了“评论”
    [self detailHeader:nil btnClick:kDetailHeaderBtnTypeComment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 获得当前需要使用的数组
- (NSMutableArray *)currentFrames
{
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        return _commentFrames;
    } else {
        return _repostFrames;
    }
}


#pragma mark - 数据源\代理方法 6个
#pragma mark 1.有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1.判断上拉加载更多控件要不要显示
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        _footer.hidden = _commentLastPage;
    } else {
        _footer.hidden = _repostLastPage;
    }
    return 2;
}


#pragma mark 2.第section组头部控件有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return 50;
}

#pragma mark 3.第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? [[self currentFrames] count]: 1;
}

#pragma mark 4.indexPath这行的cell有多高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    } else {
        return [self.currentFrames[indexPath.row] cellHeight];
    }
}

#pragma mark 5.indexPath这行的cell长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { // 微博详情cell
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        cell.cellFrame = _detailFrame;
        
        return cell;
    } else if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost) {
        // 转发cell
        static NSString *CellIdentifier = @"RepostCell";
        RepostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[RepostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.myTableView = tableView;
        }
        
        cell.indexPath = indexPath;
        cell.cellFrame = _repostFrames[indexPath.row];
        
        return cell;
    } else {
        // 评论cell
        static NSString *CellIdentifier = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.myTableView = tableView;
        }
        
        cell.indexPath = indexPath;
        cell.cellFrame = _commentFrames[indexPath.row];
        
        return cell;
    }
}

#pragma mark 判断第indexPath行的cell能不能达到选中状态，防止微博详情的cell被选中高亮的不好的色彩变化
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}


#pragma mark 6.第section组头部显示什么控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    _detailHeader.status = _status;
    return _detailHeader;
}


#pragma mark - DetailHeader的代理方法
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index
{
    // 1.先刷新表格(马上显示对应的旧数据)
    [self.tableView reloadData];
    
    if (index == kDetailHeaderBtnTypeRepost) { // 点击了转发
        [self loadNewRepost];
    } else if (index == kDetailHeaderBtnTypeComment) { // 点击了评论
        [self loadNewComment];
    }
}

#pragma mark - Mj刷新控件的刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉加载更多
        if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost) {
            [self loadMoreRepost]; // 加载更多的转发
        } else { // 加载更多的评论
            [self loadMoreComment];
        }
    } else {
        [self loadNewStatus];
    }
}

#pragma mark 解析模型数据为frame数据
- (NSMutableArray *)framesWithModels:(NSArray *)models class:(Class)class
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (BaseText *s in models) {
        BaseTextCellFrame *f = [[class alloc] init];
        f.baseText = s;
        [newFrames addObject:f];
    }
    return newFrames;
}

#pragma mark 加载最新的微博数据
- (void)loadNewStatus
{
    [StatusTool statusWithId:_status.ID success:^(Status *status) {
        _status = status;
        _detailFrame.status = status;
        
        // 刷新表格
        [self.tableView reloadData];
        
        [_header endRefreshing];
    } failure:^(NSError *r){
        [_header endRefreshing];
    }];
}

#pragma mark 加载最新的转发数据
- (void)loadNewRepost
{
    long long firstId = _repostFrames.count?[[_repostFrames[0] baseText] ID]:0;
    
    [StatusTool repostsWithSinceId:firstId maxId:0 statusId:_status.ID
                           success:^(NSArray *reposts, int totoalNumber, long long nextCursor) {
                                // 1.解析最新的转发frame数据
                                NSMutableArray *newFrames = [self framesWithModels:reposts class:[RepostCellFrame class]];
                                _status.reposts_count = totoalNumber;
                                
                                // 2.添加数据
                                [_repostFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
                                
                                _repostLastPage = nextCursor == 0;
                                
                                // 3.刷新表格
                                [self.tableView reloadData];
                           }
                           failure:nil
     ];
}

#pragma mark 加载最新的评论数据
- (void)loadNewComment
{
    long long firstId = _commentFrames.count?[[_commentFrames[0] baseText] ID]:0;
    
    [StatusTool commentsWithSinceId:firstId maxId:0 statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        // 1.解析最新的评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:comments class:[CommentCellFrame class]];
        //        for (BaseText *c in comments) {
        //            BaseTextCellFrame *f = [[CommentCellFrame alloc] init];
        //            f.baseText = c;
        //            [newFrames addObject:f];
        //        }
        
        _status.comments_count = totalNumber;
        
        // 2.添加数据到旧数据的前面
        [_commentFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        _commentLastPage = nextCursor == 0;
        
        // 3.刷新表格
        [self.tableView reloadData];
    } failure:nil];
}

#pragma mark 加载更多的转发数据
- (void)loadMoreRepost
{
    long long lastId = [[[_repostFrames lastObject] baseText] ID] - 1;
    
    [StatusTool repostsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *reposts, int totalNumber, long long nextCursor) {
        // 1.解析最新的评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:reposts class:[RepostCellFrame class]];
        //        for (BaseText *s in reposts) {
        //            BaseTextCellFrame *f = [[RepostCellFrame alloc] init];
        //            f.baseText = s;
        //            [newFrames addObject:f];
        //        }
        
        _status.reposts_count = totalNumber;
        
        // 2.添加数据到旧数据的后面
        [_repostFrames addObjectsFromArray:newFrames];
        
        _repostLastPage = nextCursor == 0;
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        [_footer endRefreshing];
    } failure:^(NSError *error) {
        [_footer endRefreshing];
    }];
}

#pragma mark 加载更多的评论数据
- (void)loadMoreComment
{
    long long lastId = [[[_commentFrames lastObject] baseText] ID] - 1;
    
    [StatusTool commentsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        // 1.解析最新的评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:comments class:[CommentCellFrame class]];
        //        for (BaseText *c in comments) {
        //            BaseTextCellFrame *f = [[CommentCellFrame alloc] init];
        //            f.baseText = c;
        //            [newFrames addObject:f];
        //        }
        
        _status.comments_count = totalNumber;
        
        // 2.添加数据到旧数据的后面
        [_commentFrames addObjectsFromArray:newFrames];
        _commentLastPage = nextCursor == 0;
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        [_footer endRefreshing];
    } failure:^(NSError *error) {
        [_footer endRefreshing];
    }];
}
@end
