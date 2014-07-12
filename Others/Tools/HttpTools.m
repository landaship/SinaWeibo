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

@implementation HttpTools
+(void)requestWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    NSURLRequest *post = [client requestWithMethod:method path:path parameters:param];
    
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
