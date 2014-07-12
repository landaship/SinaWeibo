//
//  StatusCell.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-3.
//  Copyright (c) 2014年 Louis. All rights reserved.
//


#import "StatusCell.h"
#import "Status.h"
#import "Avatar.h"
#import "UIImage+YE.h"
#import "UIPictureCell.h"
#import "StatusDock.h"

@interface StatusCell()
{
//    1.头像
    Avatar *_icon;
//    2.昵称
    UILabel *_screenName;
//    2.1 会员图标
    UIImageView *_mbIcon;
//    3.更新时间
    UILabel *_time;
//    4.消息来源
    UILabel *_source;
//    5.内容
    UILabel *_text;
//    6.配图
    UIPictureCell *_image;
    
    //    1.转发微博父控件
    UIImageView *_reweeted;
    
    //    2..昵称
    UILabel *_reweetedScreeName;
    
    //    3.内容
    UILabel *_reweetedText;
    
    //    4.配图
    UIPictureCell *_reweetedImage;
    
    StatusDock *_dock;
}
@end

@implementation StatusCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // 这个方法会调用setframe的方法，每一个cell从新生成的时候会调用一次这个
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加主微博所有控件
        [self addStatusMainView];
        //2.添加转发微博所有控件
        [self addReweetedMainView];
        
        // 3.设置背景图片
        [self setBackgroundImage];
        
        // 4. 添加底部Dock
        [self setDock];
    }
    return self;
}

#pragma mark 设置Dock
- (void) setDock
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2*kCellBorderWidth;
    CGFloat y = self.bounds.size.height - kStatusDockHeight;
    StatusDock *dock = [[StatusDock alloc]initWithFrame:CGRectMake(0, y, width, kStatusDockHeight)];
    _dock = dock;
    [self.contentView addSubview:dock];
}

#pragma mark 设置背景圆角图片
- (void) setBackgroundImage
{
    // 0. 设置背景颜色透明
    self.backgroundColor = [UIColor clearColor];
    //1.默认背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage stretchImage:@"common_card_background.png"]];
    //2.长按选中时背景图片
    self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage stretchImage:@"common_card_background_highlighted.png"]];
}

// 微博主视图
- (void)addStatusMainView
{
    //    1.头像
    _icon = [[Avatar alloc]init];
    [self.contentView addSubview:_icon];
 
    //    2.昵称
    _screenName = [[UILabel alloc]init];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    
    // 2.1 会员图标
    _mbIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self addSubview:_mbIcon];
    
    //    3.更新时间
    _time = [[UILabel alloc]init];
    _text.font = kTimeFrameFont;
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    //    4.消息来源
    _source = [[UILabel alloc]init];
   _source.font = kTimeFrameFont;
    [self.contentView addSubview:_source];
    
    //    5.内容
    _text = [[UILabel alloc]init];
    _text.font = kTextFrameFont;
    [self.contentView addSubview:_text];
    
    //    6.配图
    _image = [[UIPictureCell alloc]init];
    [self.contentView addSubview:_image];
}

// 转发微博的主视图
- (void)addReweetedMainView
{
    //    1.转发微博的父控件
    _reweeted  = [[UIImageView alloc]init];
    [self.contentView addSubview:_reweeted];
    
    //    2.昵称
    _reweetedScreeName = [[UILabel alloc]init];
    _reweetedScreeName.font = kScreenNameFont;
    _reweetedScreeName.textColor = kReweetedScreeNameColor;
    [_reweeted addSubview:_reweetedScreeName];

    //    3.内容
    _reweetedText = [[UILabel alloc]init];
    _reweetedText.font = kRetweetedFont;
    [_reweeted addSubview:_reweetedText];
    
    //    4.配图
    _reweetedImage = [[UIPictureCell alloc]init];
    [_reweeted addSubview:_reweetedImage];
}

-(void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Status  *s = statusFrame.Status;
    
    // 0. Dock
    _dock.status = s;
    
    //    1.头像
    _icon.frame = statusFrame.iconFrame;
    [_icon setUser:s.user type:kAvatarTypeDefault];
 
    //    2.昵称
    _screenName.frame = statusFrame.screenNameFrame;
    _screenName.text = s.user.screen_name;
    
    if (s.user.mbtype != kMBTypeNone) {
        _screenName.textColor = kMBScreenNameColor;
    }else{
        _screenName.textColor = kScreenNameColor;
    }
    
    // 2.1 会员图标
    if (s.user.mbtype != kMBTypeNone) {
       _mbIcon.frame = statusFrame.mbIconFrame;
        _mbIcon.hidden = NO;
    }  else
    {
        _mbIcon.hidden = YES;
    }
     
    //    3.更新时间
    _time.frame = statusFrame.timeFrame;
    _time.text = s.created_at;
    
    //    4.消息来源
    _source.text = s.source;
    _source.frame = statusFrame.sourceFrame;

    //    5.内容
    _text.frame = statusFrame.textFrame;
    _text.numberOfLines = 0;
    _text.text = s.text;
    
    //    6.配图
    if (s.pic_urls.count) {
        _image.hidden = NO;// 有图
        _image.frame = statusFrame.imageFrame;
        _image.pictures = s.pic_urls;
    }else{
        _image.hidden = YES;
    }

    if (s.retweeted_status) {
        _reweeted.hidden = NO;
        //    1.转发微博父控件
        _reweeted.frame = statusFrame.reweetedFrame;
        _reweeted.image = [UIImage stretchImage:@"timeline_retweet_background.png" xRatio:0.9 yRatio:0.9];

        //    2..昵称
        _reweetedScreeName.frame = statusFrame.reweetedScreeNameFrame;        
        _reweetedScreeName.text = [NSString stringWithFormat:@"@%@",  s.retweeted_status.user.screen_name];
        
        //    3.内容
        _reweetedText.frame = statusFrame.reweetedTextFrame;
        _reweetedText.numberOfLines = 0;
        _reweetedText.text =  [NSString stringWithFormat:@"转:%@" ,   s.retweeted_status.text ];
        
        //    4.配图
        if (s.retweeted_status.pic_urls.count) {
            _reweetedImage.hidden = NO;
            _reweetedImage.frame = statusFrame.reweetedImageFrame;
            _reweetedImage.pictures = s.retweeted_status.pic_urls;
        }
        else
        {
            _reweetedImage.hidden = YES;
        }
    }
    else{
        _reweeted.hidden = YES;
    }
}

// 还是不是很理解为什么会调用frame ，他说设置完cell 以后会再调用setframe来设置cell的高度 ,记住就可以，重加入cell的时候会从新调用这个方法
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x + kCellBorderWidth;
    frame.size.width = frame.size.width - 2*kCellBorderWidth;
    frame.origin.y = frame.origin.y + kCellMargin;
    frame.size.height = frame.size.height - kCellMargin;

    [super setFrame:frame];
}

@end
