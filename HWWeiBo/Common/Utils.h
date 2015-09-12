//
//  Utils.h
//  HWWeiBo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSDate *)dateFromString:(NSString *)dataString withFormatterString:(NSString *)formatterString;
+(NSString *)stringFromDate:(NSDate *)date withFormatterString:(NSString *)formatterString;
+(NSString *)weiboDateString:(NSString *)dataString;


+ (NSString *)parseTextImage:(NSString *)text ;

@end
