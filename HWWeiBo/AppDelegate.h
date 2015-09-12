//
//  AppDelegate.h
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"


#define kAppKey             @"3874545647"
#define kAppSecret          @"bb520a493d8571ec15b287e44d1cd6b7"
#define kAppRedirectURI     @"http://www.baidu.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif


@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;


@property(nonatomic,strong)SinaWeibo *sinaweibo;


@end

