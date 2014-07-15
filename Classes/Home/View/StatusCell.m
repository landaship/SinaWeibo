//
//  StatusCell.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "StatusDock.h"

@interface StatusCell()
{
    StatusDock *_dock; // 底部的操作条
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 操作条
        CGFloat y = self.frame.size.height - kStatusDockHeight;
        _dock = [[StatusDock alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
        [self.contentView addSubview:_dock];
    }
    return self;
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    _dock.status = cellFrame.status;
}
@end
