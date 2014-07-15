//
//  HttpTools.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "HttpTools.h"
#import "AFNetworking.h"
#import "WeiboCfg.h"
#import "UIImageView+WebCache.h"
#import "AccountTool.h"

@implementation HttpTools
+(void)requestWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    // 拼接传进来的参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (param) {
        [allParams setDictionary:param];
    }
    
    // 拼接token参数
    NSString *token = [AccountTool sharedAccountTool].account.accessToken;
    if (token) {
        [allParams setObject:token forKey:@"access_token"];
    }

    NSURLRequest *post = [client requestWithMethod:method path:path parameters:allParams];
    
#pragma mark - 打印发出的请求消息
//    NSLog(@"postString:%@", post);
    
    NSOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post
                success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                       {
                           success(JSON);
                       }
                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                       {
                           failure(error);
                       }];
    
    [op start];
}

+(void)postWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path param:param success:success  failure:failure  method:@"POST"] ;
}

+(void)getWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path param:param success:success  failure:failure  method:@"GET"] ;
}

+(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image addToView:(UIImageView *)imageView
{
    [imageView setImageWithURL:url placeholderImage:image options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

@end
