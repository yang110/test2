//
//  MoreTableViewCell.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "UIViewExt.h"
#import "ThemeManager.h"
@implementation MoreTableViewCell

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
    
    [self create];
    [self themeChangeAction];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
        
        [self create];
        [self themeChangeAction];

    }
    return self;
    
}

-(void)create
{
    _imgView=[[ThemeImageView alloc]initWithFrame:CGRectMake(7, 7, 30, 30)];
    [self.contentView addSubview:_imgView];
    
    
    
    _mainLabel=[[ThemeLabel alloc]initWithFrame:CGRectMake(_imgView.right+5, 11, 200, 20)];
    _mainLabel.font=[UIFont boldSystemFontOfSize:16];
    _mainLabel.backgroundColor=[UIColor clearColor];
    _mainLabel.colorName=@"More_Item_Text_color";
    [self.contentView addSubview:_mainLabel];
    
    
    _subLabel=[[ThemeLabel alloc]initWithFrame:CGRectMake(self.right-100, 11, 95, 20)];
    _subLabel.backgroundColor=[UIColor clearColor];
    _subLabel.colorName=@"More_Item_Text_color";
    _subLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_subLabel];
    
    
    
}


-(void)themeChangeAction
{
    self.backgroundColor=[[ThemeManager shareInstance]getThemeColor:@"More_Item_color"];
    
}


@end
