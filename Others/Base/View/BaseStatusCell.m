//
//  BaseStatusCell.m
//  新浪微博
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseStatusCell.h"
#import "Avatar.h"
#import "UIImage+YE.h"
#import "UIPictureCell.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"

@interface BaseStatusCell()
{
    UILabel *_source; // 来源
    UIPictureCell *_image; // 配图
    
    UILabel *_retweetedScreenName; // 被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    UIPictureCell *_retweetedImage; // 被转发微博的配图
}
@end

@implementation BaseStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加微博本身的子控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReweetedAllSubviews];
        
        // 3.设置背景
        [self setBg];
    }
    return self;
}

#pragma mark 设置背景
- (void)setBg
{
    // 1.默认背景
    _bg.image = [UIImage stretchImage:@"common_card_background.png"];
    
    // 2.长按背景
    _selectedBg.image = [UIImage stretchImage:@"common_card_background_highlighted.png"];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    frame.size.height -= kCellMargin;
    
    [super setFrame:frame];
}

#pragma mark 添加微博本身的子控件
- (void)addAllSubviews
{
    // 1.来源
    _source = [[UILabel alloc] init];
    _source.font = kTextFrameFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    // 2.配图
    _image = [[UIPictureCell alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark 被转发微博的子控件
- (void)addReweetedAllSubviews
{
    // 1.被转发微博的父控件
    _retweeted = [[UIImageView alloc] init];
    _retweeted.image = [UIImage stretchImage:@"timeline_retweet_background.png"  xRatio:0.9 yRatio:0.5];

    _retweeted.userInteractionEnabled = YES;
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    _retweetedScreenName.textColor = kRetweetedScreenNameColor;
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[UIPictureCell alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    Status *s = cellFrame.status;
    
    // 1.头像
    _icon.frame = cellFrame.iconFrame;
    [_icon setUser:s.user type:kAvatarTypeSmall];
    
    // 2.昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = s.user.screen_name;
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.text = s.created_at;
    CGFloat timeX = cellFrame.screenNameFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(cellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [_time.text sizeWithFont:kTimeFrameFont];
    _time.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    _source.text = s.source;
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_source.text sizeWithFont:kTextFrameFont];
    _source.frame = (CGRect) {{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    _text.frame = cellFrame.textFrame;
    _text.text = s.text;
    
    // 6.配图
    if (s.pic_urls.count) {
        _image.hidden = NO;
        _image.frame = cellFrame.imageFrame;
        _image.pictures = s.pic_urls;
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweeted_status) {
        _retweeted.hidden = NO;
        
        _retweeted.frame = cellFrame.retweetedFrame;
        
        // 8.昵称
        _retweetedScreenName.frame = cellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@", s.retweeted_status.user.screen_name];
        
        // 9.内容
        _retweetedText.frame = cellFrame.retweetedTextFrame;
        _retweetedText.text = s.retweeted_status.text;
        
        // 10.配图
        if (s.retweeted_status.pic_urls.count) {
            _retweetedImage.hidden = NO;
            
            _retweetedImage.frame = cellFrame.retweetedImageFrame;
            
            _retweetedImage.pictures = s.retweeted_status.pic_urls;
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }
}
@end
