//
//  BaseWordCell.m
//  新浪微博
//
//  Created by apple on 13-11-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseWordCell.h"
#import "Avatar.h"

@implementation BaseWordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMySubViews];
    }
    return self;
}

- (void)addMySubViews
{
    // 1.头像
    _icon = [[Avatar alloc] init];
    _icon.type = kAvatarTypeSmall;
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 皇冠图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFrameFont;
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 4.内容
    _text = [[UILabel alloc] init];
    _text.numberOfLines = 0;
    _text.font = kTextFrameFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
}
@end
