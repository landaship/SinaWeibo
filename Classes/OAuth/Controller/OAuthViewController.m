//
//  OAuthViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-27.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "OAuthViewController.h"
#import "WeiboCfg.h"
#import "AccountTool.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"
#import "HttpTools.h"

@interface OAuthViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation OAuthViewController

-(void)loadView
{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 加载未授权的Request Token
    //    https://api.weibo.com/oauth2/authorize?display=mobile?display=mobile&client_id=959738761&redirect_uri=http://www.baidu.com
    NSString *urlString = [kAuthorizeURL stringByAppendingFormat:@"?display=mobile&client_id=%@&redirect_uri=%@", kAppKey,kRedirectURI];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:URLRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 开始加载webview，显示HUD
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载，请稍后...";
    hud.dimBackground = YES;
}

// 加载完毕webview，关闭HUD，从内存移除
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1. 获取请求的全路径
    NSString *requestURL = request.URL.absoluteString;
        NSLog(@"file:%s code:%@", __FILE__, requestURL);
    
    //2. 获取code
    NSRange codeRange = [requestURL rangeOfString:@"code="];
    //    有这个code意味着什么？
    if (codeRange.length != 0)
    {
        NSInteger index = codeRange.location + codeRange.length;
        NSString *requestToken = [requestURL substringFromIndex:index];
        NSLog(@"file:%s requestToken:%@", __FILE__, requestToken);
        
        [HttpTools postWithPath:@"/oauth2/access_token" param:@{
            @"client_id":kAppKey,
            @"client_secret":kAppSecret,
            @"grant_type":@"authorization_code",
            @"code":requestToken,
            @"redirect_uri":kRedirectURI }
         
        success:^(id JSON) {
                NSLog(@"请求成功:%@", JSON);
            
                // 保存账号信息
                Account *account = [[Account alloc]init];
                account.accessToken = JSON[@"access_token"];
                account.uid = JSON[@"uid"];
                [[AccountTool sharedAccountTool] saveAccount:account];
                
                // 回到主页面
                self.view.window.rootViewController = [[MainViewController alloc]init];
        } failure:^(NSError *error) {
                //            清除指示器
               NSLog(@"请求失败:%@", error);
        }];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        // code 过期？为什么会过期？
        return NO;// 为什么返回no？
    }
    return YES;
}

@end
