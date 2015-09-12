//
//  BaseNavController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChangeNotification object:nil];
    
}


//storyBoard加载
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self)
    {
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoadImage) name:kThemeDidChangeNotification object:nil];

    }
    return self;
    
}


-(void)LoadImage
{
    
    
    
  
    ThemeManager *manager=[ThemeManager  shareInstance];
  //01 设置导航栏背景
    NSString *imageName=@"mask_titlebar64.png";
    UIImage *image=[manager getThemeImage:imageName];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];


    
    
    //02 设置导航栏 title颜色
    UIColor *titleColor=[manager getThemeColor:@"Mask_Title_color"];
    
    NSDictionary *attributes=@{
                               NSForegroundColorAttributeName : titleColor
                               };
    
    self.navigationBar.titleTextAttributes=attributes;
    

    //03 修改返回按钮的颜色
    self.navigationBar.tintColor = titleColor;
    
    //04 背景
    UIImage *img=[manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:img];

}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self LoadImage];
 
}



@end
