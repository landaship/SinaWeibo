//
//  CustomCell.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-27.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "CustomCell.h"
#import "UIImage+YE.h"

@interface CustomCell()
{
    UIImageView *_cellBackGround ;
    UIImageView *_cellSelectBackGround ;
    UIImageView *_arrow;
}

@end

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellBackGround = [[UIImageView alloc]init];
        _cellSelectBackGround  = [[UIImageView alloc]init];
        
        self.backgroundView = _cellBackGround;
        self.selectedBackgroundView = _cellSelectBackGround;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    int count = [self.myTableView numberOfRowsInSection:indexPath.section];
    
    if (count == 1)
    {
        _cellBackGround.image = [UIImage stretchImage:@"common_card_background.png"];
        _cellSelectBackGround.image =  [UIImage stretchImage:@"common_card_background_highlighted.png"];
    }
    else if (indexPath.row == 0 )
    {
        _cellBackGround.image = [UIImage stretchImage:@"common_card_top_background.png"];
        _cellSelectBackGround.image =  [UIImage stretchImage:@"common_card_top_background_highlighted.png"];
    }
    else if (indexPath.row == count - 1)
    {
        _cellBackGround.image = [UIImage stretchImage:@"common_card_bottom_background.png"];
        _cellSelectBackGround.image =  [UIImage stretchImage:@"common_card_bottom_background_highlighted.png"];
    }
    else
    {
        _cellBackGround.image = [UIImage stretchImage:@"common_card_middle_background.png"];
        _cellSelectBackGround.image =  [UIImage stretchImage:@"common_card_middle_background_highlighted.png"];
    }
}

// 设置cell的右端的标签样式
-(void)setAccessoryViewStyle:(AccessoryViewStyle)accessoryViewStyle
{
    if (accessoryViewStyle == kAccessoryViewStyleLable)
    {
        if (_accessoryViewLable == nil)
        {
            UILabel *lable = [[UILabel alloc]init];
            lable.font = [UIFont systemFontOfSize:12];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor grayColor];
            
            lable.frame = CGRectMake(0, 0, 60, 44);
             _accessoryViewLable = lable;
        }
       
        self.accessoryView = _accessoryViewLable;
    }
    else   if (accessoryViewStyle == kAccessoryViewStyleArrows)
    {
        if (_arrow == nil)
        {
            _arrow =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
        }
        self.accessoryView = _arrow;
    }
    else if (accessoryViewStyle == kAccessoryViewStyleSwith)
    {
        if (_accessoryViewSwitch == nil) {
            UISwitch *mySwtich = [[UISwitch alloc]init];
            _accessoryViewSwitch = mySwtich;
        }
   
        self.accessoryView = _accessoryViewSwitch;
    }
    else
    {
        // 为什么要清空？
        self.accessoryView = nil;
    }
}
@end
