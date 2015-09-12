//
//  DataService.h
//  04微博
//
//  Created by Mac on 15/8/12.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Header.h"



typedef void(^BlcokType) (id result);

@interface DataService : NSObject





+(AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
                             httpMethod:(NSString *)method
                                 params:(NSMutableDictionary *)params
                                  datas:(NSMutableDictionary *)dicData
                                  block:(BlcokType)block;



+(void)requestUrl:(NSString *)urlString
       httpMethod:(NSString *)method
           params:(NSMutableDictionary *)params
            block:(BlcokType)block;


+(void)getHomeList:(NSMutableDictionary*)params
             block:(BlcokType)block;


+(void)sendWeibo:(NSMutableDictionary*)params
           block:(BlcokType)block;


+(AFHTTPRequestOperation*)sendWeibo:(NSString *)text
                              image:(UIImage *)image
                              block:(BlcokType)block;

@end
