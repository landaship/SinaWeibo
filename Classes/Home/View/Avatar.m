//
//  Avatar.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-4.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "Avatar.h"
#import "HttpTools.h"

@interface Avatar()
{
    UIImageView *_avatarView;
    UIImageView *_vertifyView;
    
    User *_user;
    AvatarType _avatarType;
    UIImage *_placeHolder;
}
@end

@implementation Avatar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 添加头像view
        UIImageView *avatarView = [[UIImageView alloc]init];
        [self addSubview:avatarView];
        _avatarView = avatarView;
        
        // 2. 添加认证view
        UIImageView *vertifyIconView = [[UIImageView alloc]init];
        [self addSubview:vertifyIconView];
        _vertifyView = vertifyIconView;
    }
    return self;
}

#pragma mark 设置用户头像Frame和图片
-(void)setUser:(User *)user
{
    _user = user;
    
    // 1.设置头像图片
    [HttpTools setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:_placeHolder addToView:_avatarView];
    
    // 2.设置认证图标
     _vertifyView.hidden = YES;
    if (user.verified) {
        switch (user.verifiedType) {
            case kVerifiedTypeNone:
                break;
            case kVerifiedTypePersonal:
                _vertifyView.hidden = NO;
                _vertifyView.image = [UIImage imageNamed:@"avatar_vip.png"];
                break;
            case kVerifiedTypeOrgEnterprice:
            case kVerifiedTypeOrgMedia:
            case kVerifiedTypeOrgWebsite:
                _vertifyView.hidden = NO;
               _vertifyView.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
            case kVerifiedTypeDaren:
                _vertifyView.hidden = NO;
                _vertifyView.image = [UIImage imageNamed:@"avatar_grassroot.png"];
                break;
                
            default:
                break;
        }
    }
}

- (void)setAvatarType:(AvatarType)avatarType
{
    _avatarType = avatarType;
    CGSize avatarSize = CGSizeZero;
    
    // 1.设置头像占位图
    switch (avatarType) {
        case kAvatarTypeSmall:
            avatarSize = CGSizeMake(kAvatarIconSmallW, kAvatarIconSamllY);
            _placeHolder = [UIImage imageNamed:@"avatar_default_small.png"];
            break;
        case kAvatarTypeDefault:
             avatarSize = CGSizeMake(kAvatarIconDefaultW, kAvatarIconDefaultY);
            _placeHolder = [UIImage imageNamed:@"avatar_default.png"];
            break;
        case kAvatarTypeBig:
             avatarSize = CGSizeMake(kAvatarIconBigW, kAvatarIconBigY);
            _placeHolder = [UIImage imageNamed:@"avatar_default_big.png"];
            break;
            
        default:
            break;
    }
    
    // 2.调整frame
    _avatarView.frame = (CGRect){CGPointZero, avatarSize};
    _vertifyView.bounds = CGRectMake(0, 0, kVertifyIconW, kVertifyIconY);
    _vertifyView.center = CGPointMake(avatarSize.width, avatarSize.height);

    // 3.自己的宽高
    CGFloat width = avatarSize.width + kVertifyIconW * 0.5;
    CGFloat height = avatarSize.height + kVertifyIconY * 0.5;
    self.bounds = CGRectMake(0, 0, width, height);
}

#pragma mark 同时设置头像的用户和类型
- (void)setUser:(User *)user type:(AvatarType) type
{
    self.avatarType = type;
    self.user = user;
}

+(CGSize) avatarSizeWithType:(AvatarType)type
{
    CGSize  avatarSize = CGSizeZero;
    
    switch (type) {
        case kAvatarTypeSmall:
            avatarSize = CGSizeMake(kAvatarIconSmallW, kAvatarIconSamllY);
            break;
        case kAvatarTypeDefault:
            avatarSize = CGSizeMake(kAvatarIconDefaultW, kAvatarIconDefaultY);
            break;
        case kAvatarTypeBig:
            avatarSize = CGSizeMake(kAvatarIconBigW, kAvatarIconBigY);
            break;
    }
    CGFloat width = avatarSize.width + kVertifyIconW * 0.5;
    CGFloat height = avatarSize.height + kVertifyIconY * 0.5;

    return  CGSizeMake(width, height);
}
@end
