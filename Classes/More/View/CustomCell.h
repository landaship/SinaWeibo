//
//  CustomCell.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-27.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    kAccessoryViewStyleNone,            // 无样式
    kAccessoryViewStyleArrows,          // 箭头
    kAccessoryViewStyleLable,             //  lable
    kAccessoryViewStyleSwith              // 开关
}AccessoryViewStyle;

@interface CustomCell : UITableViewCell

@property (nonatomic, readonly) UISwitch *accessoryViewSwitch;
@property (nonatomic, readonly) UILabel *accessoryViewLable;
@property (nonatomic, assign) AccessoryViewStyle accessoryViewStyle;
@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
