//
//  ThemeImageView.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView


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



-(void)setImgName:(NSString *)imgName
{
    if (![_imgName isEqualToString:imgName])
    {
        _imgName=[imgName copy];
        [self loadImage];
    }
}

-(void)loadImage
{
    
    ThemeManager *themeManager=[ThemeManager shareInstance];
    
    UIImage *bgImage=[themeManager getThemeImage:self.imgName];
    
    
    bgImage=[bgImage stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    
 
    self.image=bgImage;
    
    
}

@end
