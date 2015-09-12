//
//  MainTabBarController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSubVc];
    
   
    
}


-(void)createSubVc
{
    NSArray *names=@[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    NSMutableArray *navArray=[[NSMutableArray alloc]init];
    for ( NSString *name in names)
    {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:name bundle:nil];
        UINavigationController *nav=[storyBoard instantiateInitialViewController];
        [navArray  addObject:nav];
    
    
    
    }
    self.viewControllers=navArray;
}


@end
