//
//  newViewController.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-23.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newViewController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate>
{
    UIScrollView *_myScrollView;
    UIPageControl *_myPageControl;
}
@end
