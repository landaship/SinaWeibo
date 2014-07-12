//
//  UIPictureCell.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-7-7.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "UIPictureCell.h"
#import "UISubImageView.h"

#define  kOnePicW 100 // 仅有一张图片时的宽度
#define  kOnePicH  100 // 仅有一张图片时的高度

#define kMultiPicW  60  // 多张图片时一张图片的宽度
#define kMultiPicH  60  //  多张图片时一张图片的高度

#define kMargin 10 // 行列间的间隔
#define kPicTotalNum  9 // 可容纳图片总数

@implementation UIPictureCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<kPicTotalNum; i++) {
            UISubImageView *imageview = [[UISubImageView alloc]init];
            [self addSubview:imageview];
        }
    }
    return self;
}

- (void)setPictures:(NSArray *)pictures
{
    // 1.设置图片
    _pictures = pictures;
    int picCount = pictures.count;
    
    for (int i = 0 ; i<kPicTotalNum; i++) {
        UISubImageView *imageView = self.subviews[i];
        
        // 没有图片的view不显示
        if (i >= picCount) {
            imageView.hidden = YES;
            continue;
        }
       
        imageView.hidden = NO;
        imageView.url = pictures[i][@"thumbnail_pic"];
        
        // 4.设置frame
        if (picCount == 1) { // 1张
            // 设置图片不拉伸，居中按比例缩放，这个图片会被放大
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.frame = CGRectMake(0, 0, kOnePicW, kOnePicH);
            continue;
        }
        
        int separateNum = (picCount == 4) ? 2:3;// 每行的列数，如果只有4张图，则两列一行
        int row = i  / separateNum; // 当前行数
        int column = i % separateNum; // 当前列数
        
        // 裁掉多余的边界
        imageView.clipsToBounds = YES;
        // 设置图片居中，自动按原图比例缩放
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        imageView.frame = CGRectMake((kMultiPicW + kMargin) * column, (kMultiPicH + kMargin) * row, kMultiPicW, kMultiPicH);
        
    }
}

// 根据图片数量（count）返回当前图片大小
+ (CGSize) UIPictureCellSizeWithCount:(int) count
{
    if (count == 1)
    {
        return CGSizeMake(kOnePicW, kOnePicH);
    }
    
    int separateNum = (count == 4) ? 2:3;// 每行的列数，如果只有4张图，则两列一行

    int rowCount = (count + separateNum - 1) / 3 ;// 总共的行数
    int columnCount = (count >= 3) ? 3:2;
    
    return CGSizeMake(rowCount * kMultiPicW + (rowCount  - 1) * kMargin, columnCount * kMultiPicH + (columnCount - 1) * kMargin);
            
}

@end
