//
//  RightViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "DataService.h"

#import "BaseNavController.h"

#import "UIViewController+MMDrawerController.h"

#import "SendViewController.h"

#import "NearByViewController.h"

@interface RightViewController ()


@end

@implementation RightViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //右边本身没有nav 只是个viewcontroller 所以在baseViewController里设置了背景的通知，在这里调用
    [self setBgImage];
    
    // 图片的数组
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    
    // 创建主题按钮
    for (int i = 0; i < imageNames.count; i++) {
       
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(20, 64 + i * (40 + 10), 40, 40)];
        button.normalImageName = imageNames[i];
        
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
}


- (void)buttonAction:(UIButton *)button{
    if (button.tag == 0) {
        // 发送微博
        
        //push之后 右边回复原样
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            // 弹出发送微博控制器
            
            SendViewController *senderVc = [[SendViewController alloc] init];
            senderVc.title = @"发送微博";
            
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:senderVc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }

    else if (button.tag==4)
    {
        
        //push之后 右边回复原样
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            // 弹出发送微博控制器
            
            NearByViewController *nearByViewController = [[NearByViewController alloc] init];
            nearByViewController.title = @"附近";
            
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:nearByViewController];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];

        
        
        
        
        
        
        
        
    }
    
    
    
}


@end
