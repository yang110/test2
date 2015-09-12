//
//  MyTabBarController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "MyTabBarController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"

#import "ThemeLabel.h"

@interface MyTabBarController ()
{
    
    ThemeImageView *_tabbarView;
    ThemeImageView *_selectImageView;
    
    
    ThemeImageView *_badgeView;
    ThemeLabel *_badgeLabel;
    
    
}
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    
    
    [self addNavControllers];
    
    
    
    [self resetTabBarButton];
    
    
 
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
      
}




-(void)resetTabBarButton
{
    

    //移除原来的
    for (UIView *view in self.tabBar.subviews) {
        Class cls=NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
      //添加bar
    
    _tabbarView=[[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0,kwidth, 49)];
    
    _tabbarView.imgName=@"mask_navbar.png";
    _tabbarView.userInteractionEnabled=YES;
    
    [self.tabBar addSubview:_tabbarView];
    
    
    
    _selectImageView=[[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, kwidth/4.0, 49)];
    _selectImageView.imgName=@"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectImageView];
    
// 5页改4页
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
//                          @"home_tab_icon_2.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_5.png",
                          ];
    
    CGFloat width=kwidth/4.0;
    for (int i=0; i<imgNames.count; i++)
    {
    

        
        ThemeButton *button=[[ThemeButton alloc]initWithFrame:CGRectMake(width*i, 0  , width, 49)];
        button.normalImageName=imgNames[i];
        button.tag=i;
        [button addTarget:self action:@selector(selectTab:) forControlEvents:    UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }
    
}





-(void)addNavControllers
{
    
// 5页改4页
    
    NSArray *names=@[@"Home",@"Profile",@"Discover",@"More"];

    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<names.count; i++) {
        
        
        
        NSString *name=names[i];
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController   *nav=[storyBoard instantiateInitialViewController];
     
        [array addObject:nav];
    }
    
   
    self.viewControllers=array;
    

}
-(void)selectTab:(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        _selectImageView.center=button.center;
        
    }];
    
    self.selectedIndex=button.tag;
    
}




-(void)timerAction
{
    
    
    
    
    AppDelegate *appdelegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo=appdelegate.sinaweibo;
    
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
    
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    
    
    
    
    
    
    
    CGFloat tabbarButtonWidth=kScreenWidth/5;
    
    
    if (_badgeView==nil) {
        _badgeView=[[ThemeImageView alloc]initWithFrame:CGRectMake(tabbarButtonWidth-32, 0, 32, 32)];
        _badgeView.imgName=@"number_notify_9.png";
        [_tabbarView addSubview:_badgeView];
        
        
        
        _badgeLabel=[[ThemeLabel alloc]initWithFrame:_badgeView.bounds];
        _badgeLabel.backgroundColor=[UIColor clearColor];
        _badgeLabel.font=[UIFont systemFontOfSize:13];
        _badgeLabel.textAlignment=NSTextAlignmentCenter;
        _badgeLabel.colorName =@"Timeline_Notice_color";
        
        
        [_badgeView addSubview:_badgeLabel];
        
        
    }
    
    
    NSNumber *status=[result objectForKey:@"status"];
    NSInteger count=[status integerValue];
    
    if (count>0) {
        
        
        
        _badgeView.hidden=NO;
        
        if (count>=100) {
            count=99;
        }
        
        
        _badgeLabel.text=[NSString stringWithFormat:@"%li",count];
        
        
    }
    else
    {
        _badgeView.hidden=YES;
    }
    
    
    
    
}
@end
