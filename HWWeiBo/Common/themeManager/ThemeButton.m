//
//  ThemeButton.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChangeNotification object:nil];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame ];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNotification object:nil];
    }
    
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNotification object:nil];
    

    
}


-(void)themeDidChangeAction:(NSNotification *)notification
{
    [self loadImage];
}


#pragma mark - 默认设置
-(void)setNormalImageName:(NSString *)imageName
{
    
    if (![_normalImageName isEqualToString:imageName]) {
        _normalImageName=[imageName copy];
        [self loadImage];
        
    }
    
}



-(void)setHighLightImageName:(NSString *)highLightImageName
{
    
    if (![_highLightImageName   isEqualToString:highLightImageName]) {
        _highLightImageName=[highLightImageName copy];
        [self loadImage];
        
    }
    
}

-(void)setNormalBgImageName:(NSString *)normalBgImageName
{
    
    if (![_normalBgImageName   isEqualToString:normalBgImageName]) {
        _normalBgImageName=[normalBgImageName copy];
        [self loadImage];
        
    }
    
}


-(void)setHighLightBgImageName:(NSString *)highLightBgImageName
{
    
    if (![_highLightBgImageName   isEqualToString:highLightBgImageName]) {
        _highLightBgImageName=[highLightBgImageName copy];
        [self loadImage];
        
    }
    
}





-(void)loadImage
{
    
    ThemeManager *themeManager=[ThemeManager shareInstance];
    
    
    UIImage *normalImage=[themeManager getThemeImage:_normalImageName];
    [self setImage:normalImage forState:UIControlStateNormal];
    
    
    UIImage *highLightImage=[themeManager getThemeImage:_highLightImageName];
    [self setImage:highLightImage forState:    UIControlStateHighlighted ];
    
    
    UIImage *normalBgImage=[themeManager getThemeImage:_normalBgImageName];
    [self setBackgroundImage:normalBgImage forState:UIControlStateNormal];
    
    
    
    
    UIImage *highLightBgImage=[themeManager getThemeImage:_highLightBgImageName];
    [self setBackgroundImage:highLightBgImage forState:UIControlStateHighlighted];
    
    
    
    
}




@end
