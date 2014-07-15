//
//  BaseWordCell.h
//  新浪微博
//
//  Created by apple on 13-11-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseCell.h"
@class Avatar;
@interface BaseWordCell : BaseCell
{
    Avatar *_icon; // 头像
    UILabel *_screenName; // 昵称
    UIImageView *_mbIcon; // 会员图标
    UILabel *_text; // 内容
    UILabel *_time; // 时间
}
@end
