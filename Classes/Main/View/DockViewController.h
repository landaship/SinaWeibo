//
//  DockViewController.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-21.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"

@interface DockViewController : UIViewController
{
    Dock *_dock;
}

@property (nonatomic, readonly) UIViewController *selectedController;
@end
