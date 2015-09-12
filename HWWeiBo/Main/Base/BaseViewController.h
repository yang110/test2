//
//  BaseViewController.h
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIProgressView+AFNetworking.h"
#import "AFNetworking.h"
@interface BaseViewController : UIViewController
{
       MBProgressHUD *_hud;
    
    UIWindow *_tipWindow;
    
}

- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;


-(void)setNavButton;


- (void)setBgImage;


//显示hud提示-开源代码
- (void)showHUD:(NSString *)title;
- (void)hideHUD;
//完成的提示
- (void)completeHUD:(NSString *)title;

@end
