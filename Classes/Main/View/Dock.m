//
//  Dock.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-20.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock()
{
    DockItem *_selectedItem;
}
@end

@implementation Dock

- ( void )addItemWithIcon:(NSString *)iconName SelectedIcon:(NSString *)selectedIconName lableTitle:(NSString *)lableTitle
{
    DockItem *item =  [[DockItem alloc]init];
    
    [item setTitle:lableTitle forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selectedIconName]  forState:UIControlStateSelected];
 
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:item];
    
#pragma mark - 自动适应调整items的大小
    int subViewCount = 0;
    subViewCount = self.subviews.count;
    
    CGFloat height = self.frame.size.height; // 高度
    CGFloat width = self.frame.size.width / subViewCount; // 宽度
    for (int i = 0; i<subViewCount; i++) {
       DockItem *dockItem = self.subviews[i];
        dockItem.tag = i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }

}

// 设置默认选中的按钮
- (void) setFocusItem:(NSInteger) itemNum
{
     DockItem *dockItem = self.subviews[itemNum];
     [self itemClick:dockItem];
}

#pragma mark - 通知其他的viewcontroller
- (void) itemClick:(DockItem *)dockItem
{
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(itemSelected:fromItemNum:toItemNum:)]){
        [_delegate itemSelected:self fromItemNum: _selectedItem.tag  toItemNum:dockItem.tag];
    }
    
    // 1.取消选中当前选中的item
    _selectedItem.selected = NO;
    
    // 2.选中点击的item
    dockItem.selected = YES;
    
    // 3.赋值
    _selectedItem = dockItem;
}

@end
