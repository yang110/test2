//
//  ThemeLabel.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChangeNotification object:nil];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadColor) name:kThemeDidChangeNotification object:nil];

    }
    
    return self;
    
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadColor) name:kThemeDidChangeNotification object:nil];
    
    
    
}







-(void)setColorName:(NSString *)colorName
{
    if (![_colorName isEqualToString:colorName])
    {
        _colorName=[colorName copy];
        [self loadColor];
        
    }
    
    
}
-(void)loadColor
{
    
    UIColor *fontColor=[[ThemeManager shareInstance] getThemeColor:_colorName];
    
    
    self.textColor=fontColor;
}


@end
