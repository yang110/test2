//
//  ThemeManager.h
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <Foundation/Foundation.h>






#define kThemeDidChangeNotification @"kThemeDidChangeNotification"
#define kThemeName @"kThemeName"

@interface ThemeManager : NSObject

@property(nonatomic,copy)NSString *themeName;


@property(nonatomic,strong) NSDictionary *themeconfig;
@property(nonatomic,strong) NSDictionary *colorconfig;


+ (ThemeManager *)shareInstance;



- (UIImage *)getThemeImage:(NSString *)imageName;


-(UIColor *)getThemeColor:(NSString *)colorName;





@end
