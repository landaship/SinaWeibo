//
//  Dock.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-20.
//  Copyright (c) 2014年 Louis. All rights reserved.
//
#import <UIKit/UIKit.h>
@class Dock;

@protocol DockDelegate <NSObject>

@optional
- ( void )itemSelected:(Dock * )dock fromItemNum:(int)from toItemNum:(int)to;

@end

@interface Dock : UIView

- (void )addItemWithIcon:(NSString *)iconName SelectedIcon:(NSString *)selectedIconName lableTitle:(NSString *)lableTitle;

// 代理
@property (weak, nonatomic) id <DockDelegate>  delegate;

- (void) setFocusItem:(NSInteger) itemNum;

@end
