//
//  Common.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-20.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#pragma mark  - 判断是否是iphne5
#define ISiPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif


#define kScreenNameFont    [UIFont systemFontOfSize:17.0]
#define kTimeFrameFont [UIFont systemFontOfSize:9.0]
#define kTextFrameFont [UIFont systemFontOfSize:15.0]
#define kRetweetedFont [UIFont systemFontOfSize:16.0]

#define kCellBorderWidth 10  // 边框宽度
#define kMBIconSizeW 14  // 会员标示图标宽
#define kMbIconSizeY 14 // 会员标示图标高
#define kCellMargin 10  // cell 和cell的间距

// 首页背景颜色
#define kHomeViewBackGroundColor   [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]

// 每个cell里面转发数目 点赞数目的Dock的高度
#define kStatusDockHeight  35


#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 会员昵称颜色
#define kMBScreenNameColor kColor(243, 101, 18)
// 普通成员昵称颜色
#define kScreenNameColor kColor(93, 93, 93)
// 转发微博昵称颜色
#define kReweetedScreeNameColor kColor(63, 104, 161)

// 全局的背景色
#define kGlobalBg kColor(230, 230, 230)

// 设置tableView的边框宽度
#define kTableBorderWidth 8

// 设置转发微博dock的高度
#define kRetweetedDockHeight 35

// 7.图片
// 会员皇冠图标
#define kMBIconW 14
#define kMBIconH 14

#define kRetweetedScreenNameFont [UIFont systemFontOfSize:13]

#define kRetweetedTextFont [UIFont systemFontOfSize:13]

// 转发微博用户昵称的颜色
#define kRetweetedScreenNameColor kColor(63, 104, 161)