//
//  StatusFrame.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "Avatar.h"
#import "UIPictureCell.h"

@implementation StatusFrame

- (void)setStatus:(Status *)status
{
    _Status = status;

    // 获取cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kCellBorderWidth;
    
    // 1. 设置👦
    CGSize avatarSize = [Avatar avatarSizeWithType:kAvatarTypeDefault];
    _iconFrame = CGRectMake(kCellBorderWidth, kCellBorderWidth, avatarSize.width , avatarSize.height);

    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = kCellBorderWidth;
    CGSize screeNameSize = [status.user.screen_name sizeWithAttributes:@{NSFontAttributeName:kScreenNameFont}];
    _screenNameFrame =  (CGRect )  {{screenNameX, screenNameY}, screeNameSize};
    
    // 2.1 会员标示
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbIconWidth = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        // 设置起点为screenName的居中位置
        CGFloat mbIconHight = screenNameY + (screeNameSize.height - kMbIconSizeY)*0.5;
        _mbIconFrame =  CGRectMake(mbIconWidth, mbIconHight, kMBIconSizeW, kMbIconSizeY);
    }
    
    // 4.时间
    CGFloat timeFrameX = screenNameX;
    CGFloat timeFrameY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGSize timeFrameSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName:kTimeFrameFont}];
    _timeFrame = (CGRect) { {timeFrameX,timeFrameY},timeFrameSize};
    
    //    5.来源
    CGFloat sourceFrameX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceFrameY = timeFrameY;
    CGSize sourceFrameSize = [status.source sizeWithAttributes:@{NSFontAttributeName:kTimeFrameFont}];
     _sourceFrame = (CGRect) { {sourceFrameX,sourceFrameY},sourceFrameSize};
    
    // 微博内容
    CGFloat textFrameX = kCellBorderWidth;
    CGFloat textFrameY = CGRectGetMaxY(_iconFrame) + kCellBorderWidth;
    
    CGSize textFrameSize = [status.text
                              boundingRectWithSize:CGSizeMake(cellWidth - 2 *kCellBorderWidth, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{NSFontAttributeName:kTextFrameFont}
                              context:nil].size;
    
    _textFrame = (CGRect ){{textFrameX, textFrameY}, textFrameSize};
    
    // 6. 配图
    if (status.pic_urls.count) {  // 有图
        CGFloat PicURLFrameX = kCellBorderWidth;
        CGFloat PICURLFrameY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize size = [UIPictureCell UIPictureCellSizeWithCount:status.pic_urls.count];
        
        _imageFrame = (CGRect ) {{PicURLFrameX, PICURLFrameY}, size.width , size.height};
    }
    else if (status.retweeted_status)  // 有转发的微博数据
    {
        CGFloat retweetedFrameX = kCellBorderWidth;
        CGFloat retweetedFrameY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        
        CGFloat retweetedWidth = cellWidth - 2 *kCellBorderWidth;
        CGFloat retweetedHight = kCellBorderWidth;
        
        // 昵称
        CGFloat retweetedScreenNameFrameX = kCellBorderWidth;
        CGFloat retweetedScreenNameFrameY = kCellBorderWidth;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.screen_name];
        CGSize retweetedScreenNameSize = [name sizeWithAttributes:@{NSFontAttributeName:kScreenNameFont}];
        
        _reweetedScreeNameFrame = (CGRect ){{retweetedScreenNameFrameX, retweetedScreenNameFrameY}, retweetedScreenNameSize};
        
        // 转发微博的内容
        CGFloat retweetedTextFrameX = kCellBorderWidth;
        CGFloat retweetedTextFrameY = CGRectGetMaxY(_reweetedScreeNameFrame) + kCellBorderWidth;
        
        CGSize retweetedTextFrameSize = [status.retweeted_status.text
                                         boundingRectWithSize:CGSizeMake(retweetedWidth - 2*kCellBorderWidth, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:kRetweetedFont}
                                         context:nil].size;
        
        _reweetedTextFrame = (CGRect ){{retweetedTextFrameX, retweetedTextFrameY}, retweetedTextFrameSize};
       
        // 图片
        if (status.retweeted_status.pic_urls.count) { // 有图片
            CGFloat retweetedPicX = kCellBorderWidth;
            CGFloat retweetedPicY = CGRectGetMaxY(_reweetedTextFrame) + kCellBorderWidth;
            
            CGSize size = [UIPictureCell UIPictureCellSizeWithCount:status.retweeted_status.pic_urls.count];
            _reweetedImageFrame = CGRectMake(retweetedPicX, retweetedPicY, size.width, size.height);
            retweetedHight += CGRectGetMaxY(_reweetedImageFrame);
        }
        else
        {
            retweetedHight += CGRectGetMaxY(_reweetedTextFrame);

        }

         _reweetedFrame = CGRectMake(retweetedFrameX, retweetedFrameY, retweetedWidth, retweetedHight);
    }
    
    // 计算整个cell高度
    _cellHeight = kCellBorderWidth + kStatusDockHeight + kCellMargin;
    if (status.pic_urls.count) { // 有图片
        _cellHeight += CGRectGetMaxY(_imageFrame);
    }
    else    if (status.retweeted_status) {
        _cellHeight += CGRectGetMaxY(_reweetedFrame);
    }
    else{
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
}

@end
