//
//  BaseText.h
//  新浪微博
//
//  Created by apple on 13-11-6.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "BaseModel.h"
@class User;
@interface BaseText : BaseModel
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;
@end
