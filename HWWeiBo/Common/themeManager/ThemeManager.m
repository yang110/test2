//
//  ThemeManager.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager




#define kDeafaultThemeNmae @"cat"


+(ThemeManager *)shareInstance
{
    
    static ThemeManager *instance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        instance=[[[self class] alloc]init];
    });
    
    
    return instance;
    
    
}

-(instancetype)init
{
    
    self=[super init];
    if (self) {
        //01 默认主题名字
        _themeName=kDeafaultThemeNmae;
        
        
        
        //读档
        NSString *saveThemeName=[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
        if (saveThemeName.length>0)
        {
            _themeName=saveThemeName;
            
        }
        
        
        
        
        //02 读取配置信息
        NSString *configPath=[[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        _themeconfig=[NSDictionary dictionaryWithContentsOfFile:configPath];

        
        //03
        NSString *themePath=[self themePath];
        NSString *filePath=[themePath stringByAppendingPathComponent:@"config.plist"];
        
        self.colorconfig=[NSDictionary  dictionaryWithContentsOfFile:filePath];
        
        
        
        
        
    }
    return self;
    
}


-(UIColor *)getThemeColor:(NSString *)colorName
{
    if (colorName.length==0)
    {
        return nil;
        
    }
    
    NSDictionary *rgbDic=[self.colorconfig objectForKey:colorName];
    CGFloat r=[rgbDic[@"R"] floatValue];
    CGFloat g=[rgbDic[@"G"] floatValue];
    CGFloat b=[rgbDic[@"B"] floatValue];
    CGFloat alpha=[rgbDic[@"alpha"] floatValue];
    
    if(rgbDic[@"alpha"] ==nil)
    {
        alpha=1;
        
        
    }

    UIColor *color=[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
    
    
}

//由 name 获取 image
-(UIImage *)getThemeImage:(NSString *)imageName
{
    
    
    if (imageName.length==0) {
        return nil;
    }
    //01 获取主题包路径  ****/Skins/cat
    NSString *themePath=[self themePath];
    //2 拼接图片 路径 ****/Skins/cat/home_tab_icon_1.png
    NSString *filePath=[themePath stringByAppendingPathComponent:imageName];
    //3 读取图片
    return  [UIImage imageWithContentsOfFile:filePath];
    
}

//拼接路径 ****/Skins/cat
-(NSString *)themePath
{

    //01 程序包根路径  /Users/mac/Library/Developer/CoreSimulator/Devices/A047DB0E-CE95-4DC3-9D5E-C14B0DA20999/data/Containers/Bundle/Application/83FC0062-3F5C-49BF-AADC-F7C2C204CAC3/HWWeiBo.app
//    /Users/mac/Library/Developer/CoreSimulator/Devices/A047DB0E-CE95-4DC3-9D5E-C14B0DA20999/data/Containers/Bundle/Application/2E859D79-7E6C-46B7-BD43-C434E45F8236/HWWeiBo.app
//    /Users/mac/Library/Developer/CoreSimulator/Devices/A047DB0E-CE95-4DC3-9D5E-C14B0DA20999/data/Containers/Bundle/Application/1E210F61-2058-42DF-9081-3B489D1B510A/HWWeiBo.app
//    2015-08-21 13:29:58.656 HWWeiBo[2626:94369] /Users/mac/Library/Developer/CoreSimulator/Devices/A047DB0E-CE95-4DC3-9D5E-C14B0DA20999/data/Containers/Bundle/Application/8E2340E8-3242-43EE-8633-6AD324AA74E3/HWWeiBo.app

    NSString *bundlePath= [[NSBundle mainBundle] resourcePath];

//    NSLog(@"%@",bundlePath);
    
    
    //02 名字 Skins/cat
    NSString *themePath=[self.themeconfig objectForKey:_themeName];
    
    
    //03 拼接
    NSString *path=[bundlePath stringByAppendingPathComponent:themePath];
    
    
    return path;
    
    


    
}




//切换主题
-(void)setThemeName:(NSString *)themeName
{
    
    
    if (![_themeName isEqualToString:themeName])
    {
        
        
        _themeName=[themeName copy];
        
        //00配置名字 存储到本地 userDefalts
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        
        
        
        //重新获取
        NSString *themePath=[self themePath];
        NSString *filePath=[themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorconfig=[NSDictionary  dictionaryWithContentsOfFile:filePath];
        
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification  object:nil];

    }
    
    
}



@end
