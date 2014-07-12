//
//  HttpTools.h
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-1.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTools : NSObject

typedef  void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock) (NSError * error);

+(void) postWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+(void) getWithPath:(NSString *)path param:(NSDictionary *)param success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image addToView:(UIImageView *) imageView;

@end
