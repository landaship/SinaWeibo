//
//  StatusDetailCell.m
//  新浪微博
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "StatusDetailCell.h"
#import "RetweetedDock.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "DetailViewController.h"
#import "MainViewController.h"

@interface StatusDetailCell()
{
    RetweetedDock *_dock;
}
@end

@implementation StatusDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 1.操作条
        RetweetedDock *dock = [[RetweetedDock alloc] init];
        dock.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        CGFloat x = _retweeted.frame.size.width - dock.frame.size.width;
        CGFloat y = _retweeted.frame.size.height - dock.frame.size.height;
        dock.frame = CGRectMake(x, y, 0, 0);
        [_retweeted addSubview:dock];
        _dock = dock;
        
        self.userInteractionEnabled  = YES;
        // 2.监听被转发微博的点击
        [_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
    }
    return self;
}

- (void)showRetweeted
{
    // 展示被转发的微博
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.status = _dock.status;
    
    MainViewController *main = (MainViewController *)self.window.rootViewController;
    UINavigationController *nav =  (UINavigationController *)main.selectedController;
    
    [nav pushViewController:detail animated:YES];
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    // 设置子控件的数据
    _dock.status = cellFrame.status.retweeted_status;
}

@end
