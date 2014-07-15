//
//  BaseStatueCellFrame.m
//  新浪微博
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "Avatar.h"
#import "UIPictureCell.h"

@implementation BaseStatusCellFrame
- (void)setStatus:(Status *)status
{
    _status = status;
    // 利用微博数据，计算所有子控件的frame
    
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - kTableBorderWidth * 2;
    
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = [Avatar avatarSizeWithType:kAvatarTypeSmall];
    _iconFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [status.user.screen_name sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    // 3.时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [status.created_at sizeWithFont:kTimeFrameFont];
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:kTimeFrameFont];
    _sourceFrame = (CGRect) {{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellBorderWidth;
    CGSize textSize = [status.text sizeWithFont:kTextFrameFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellBorderWidth, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.pic_urls.count) { // 6.有配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize imageSize = [UIPictureCell UIPictureCellSizeWithCount:status.pic_urls.count];
        _imageFrame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    } else if (status.retweeted_status) { // 7.有转发的微博
        // 被转发微博整体
        CGFloat retweetX = textX;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        // 8.被转发微博的昵称
        CGFloat retweetedScreenNameX = kCellBorderWidth;
        CGFloat retweetedScreenNameY = kCellBorderWidth;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.screen_name];
        CGSize retweetedScreenNameSize = [name sizeWithFont:kRetweetedScreenNameFont];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 9.被转发微博的内容
        CGFloat retweetedTextX = retweetedScreenNameX;
        CGFloat retweetedTextY = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderWidth;
        CGSize retweetedTextSize = [status.retweeted_status.text sizeWithFont:kRetweetedTextFont constrainedToSize:CGSizeMake(retweetWidth - 2 * kCellBorderWidth, MAXFLOAT)];
        _retweetedTextFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 10.被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            CGSize imageSize = [UIPictureCell UIPictureCellSizeWithCount:status.retweeted_status.pic_urls.count];
            _retweetedImageFrame = CGRectMake(retweetedImageX, retweetedImageY, imageSize.width, imageSize.height);
            
            retweetHeight += CGRectGetMaxY(_retweetedImageFrame);
        } else {
            retweetHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        _retweetedFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    
    // 11.整个cell的高度
    _cellHeight = kCellBorderWidth + kCellMargin;
    if (status.pic_urls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    } else if (status.retweeted_status) {
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
}
@end
