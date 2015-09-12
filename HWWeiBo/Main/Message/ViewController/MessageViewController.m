//
//  MessageViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "MessageViewController.h"
#import "DataService.h"
@interface MessageViewController ()

@end

@implementation MessageViewController



-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self=[super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"Message initWithCoder");
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self loadData];

    
    
    

    
}

-(void)loadData
{
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    
    [DataService requestAFUrl:userWeibo httpMethod:@"GET" params:params datas:nil block:^(id result) {
        
        
    }];
    
}
@end
