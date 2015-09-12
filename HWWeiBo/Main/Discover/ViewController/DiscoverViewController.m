//
//  DiscoverViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "DiscoverViewController.h"

#import "DiscoverNearByViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
 
}


- (IBAction)nearByWeibo:(id)sender
{
    
    
    
    DiscoverNearByViewController *vc=[[DiscoverNearByViewController alloc]init];
    

    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}



@end
