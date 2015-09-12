//
//  Utils.m
//  HWWeiBo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "Utils.h"
#import "RegexKitLite.h"
@implementation Utils

/*
dataString：     要转化的日期 string格式
formatterString 期望转化的date格式
return:         返回 date
*/
+(NSDate *)dateFromString:(NSString *)dataString withFormatterString:(NSString *)formatterString
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    //转化成date
    [formatter setDateFormat:formatterString];
    return  [formatter dateFromString:dataString];
    
}


/*
date            要转化的日期
formatterString 期望转化的string格式
return          返回string
*/
+(NSString *)stringFromDate:(NSDate *)date withFormatterString:(NSString *)formatterString
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:formatterString];
    
    return  [formatter stringFromDate:date];
    
    
}



/*
dataString :  要转化的日期 string格式
return : 期望转化成的 string格式
*/
+(NSString *)weiboDateString:(NSString *)dataString
{
    
    
    
//    //年 月 日 时 分
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
////    //转化成date
//    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss yyyy"];
//    NSDate *date=[formatter dateFromString:dataString];
//    
//    NSLog(@"%@",date);
    
//    //转化成nsstring
//    [formatter setDateFormat:@"MMM dd HH:mm:ss"];
//    
//  return   [formatter stringFromDate:date];
    
    
// 时间需要改

    NSDate *date= [self dateFromString:dataString withFormatterString:@"EEE MMM dd H:mm:ss Z yyyy"];
    
    return   [self stringFromDate:date withFormatterString:@"M月dd日 HH:mm:ss"];

    

    
}




//处理文本中显示的图片
+ (NSString *)parseTextImage:(NSString *)text {
    //[哈哈]--->图片名 ----> 替换成： <image url = '图片名'>
    NSString *faceRegex = @"\\[\\w+\\]";
    NSArray *faceItem = [text componentsMatchedByRegex:faceRegex];
    
    //1>.读取emoticons.plist 表情配置文件
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfig = [NSArray arrayWithContentsOfFile:configPath];
    
    //2>.循环、遍历所有的查找出来的表情名：[哈哈]、[赞]、....
    for (NSString *faceName in faceItem) {
        //faceName = [哈哈]
        
        //3.定义谓词条件，到emoticons.plist中查找表情名对应的表情item
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfig filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            //4.取得过滤出来的表情item
            NSDictionary *faceDic = items[0];
            
            //5.取得图片名
            NSString *imgName = faceDic[@"png"];
            
            //6.构造表情表情 <image url = '图片名'>
            NSString *replace = [NSString stringWithFormat:@"<image url = '%@'>",imgName];
            
            //7.替换：将[哈哈] 替换成 <image url = '90.png'>
            text = [text stringByReplacingOccurrencesOfString:faceName withString:replace];
            
        }
        
    }
    
    return text;
}


@end
