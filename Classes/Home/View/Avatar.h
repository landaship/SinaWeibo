//
//  Avatar.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-4.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#define kAvatarIconSmallW 34
#define kAvatarIconSamllY  34

#define kAvatarIconDefaultW 50
#define kAvatarIconDefaultY  50

#define kAvatarIconBigW 85
#define kAvatarIconBigY  85

#define kVertifyIconW 18
#define kVertifyIconY   18

typedef enum {
    kAvatarTypeSmall,   // 18*18 小图标
    kAvatarTypeDefault, // 50*50 中等图标
    kAvatarTypeBig // 80*80大图标
} AvatarType;

@class User;
@interface Avatar : UIView

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) AvatarType type;

- (void)setUser:(User *)user type:(AvatarType) type;
+(CGSize) avatarSizeWithType:(AvatarType)type;

@end
