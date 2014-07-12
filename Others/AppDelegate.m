//
//  AppDelegate.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-18.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "newViewController.h"
#import "OAuthViewController.h"
#import  "AccountTool.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#pragma mark - 关于Bundle
#pragma mark 读取plist的方法
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *path = [bundle pathForResource:@"provinces_cities" ofType:@"plist"];
//    NSDictionary *dictData = [[NSDictionary  alloc] initWithContentsOfFile:path];
#pragma mark 从沙盒中读取程序版本号
    NSBundle *mainBundle = [NSBundle mainBundle];
//    关键字key都是以k开头，这个key是bundle框架提供的key，通过这个key可以找到这个程序当前的版本
    NSString *key = (NSString *)kCFBundleVersionKey;
//    NSDictionary *dictData = [mainBundle infoDictionary];  
//    NSString *appVersion = [dictData objectForKey:key];
    NSString *appVersion = [mainBundle infoDictionary][key];
    
#pragma mark 取出自己存储的version值
    NSString *versionDefaults = [[NSUserDefaults standardUserDefaults]objectForKey:key];

    if ([appVersion isEqual:versionDefaults])
    {
        // 如果版本号一致则直接打开maincontrolle
        if ([AccountTool sharedAccountTool].account)
        {
            self.window.rootViewController = [[MainViewController alloc]init];
        }
        else
        {
            self.window.rootViewController = [[OAuthViewController alloc]init];
        }
    }
    else
    {
        //更新版本号
        [[NSUserDefaults standardUserDefaults]setObject:appVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        //        打开newFeature 新特性介绍页面
        newViewController *newFeatureVC = [[newViewController alloc]init];
    
        self.window.rootViewController = newFeatureVC;
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
