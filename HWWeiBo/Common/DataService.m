//
//  DataService.m
//  04微博
//
//  Created by Mac on 15/8/12.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "DataService.h"
#import "JSONKit.h"
#import "AFNetworking.h"
@implementation DataService




+(AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
         httpMethod:(NSString *)method
             params:(NSMutableDictionary *)params
              datas:(NSMutableDictionary *)dicData 
              block:(BlcokType)block
{
    
    //读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo  = [defaults objectForKey:@"HWWeiboAuthData"];

    
    //添加token
    [params setValue:[sinaweiboInfo objectForKey:@"AccessTokenKey"] forKey:key1];
    
    
    
    NSString *fullUrlString=[BaseUrl stringByAppendingString:urlString];
    

    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    
     manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    
 
    manager.responseSerializer.acceptableContentTypes=
     [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
  
    
    if ([method isEqualToString:@"GET"])
    {
        
     AFHTTPRequestOperation *operation=   [manager GET:fullUrlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"上传成功");
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        
            NSLog(@"%@",error);
        }];
        
        
        return operation;
        
        
    }
    else if( [method isEqualToString:@"POST"])
    {
        if (dicData !=nil) {
            
            
            
            AFHTTPRequestOperation *operation=[manager POST:fullUrlString parameters:params     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                
                for (NSString *name in dicData)
                {
                    NSData *data=dicData[name];
                    [formData appendPartWithFileData:data name:name fileName:@"1.png" mimeType:@"image/jpeg"];
                    
                    
                }
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"上传成功");
                block(responseObject);
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"失败");

            }];
            
            //监控下载
            [operation setDownloadProgressBlock:^void(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead  ) {
                NSLog(@"下载 %li  %lld %lld",bytesRead,totalBytesRead,totalBytesExpectedToRead);
            }];
            
            //监控上传
            [operation setUploadProgressBlock:^void(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                NSLog(@"上传 %li %lld  %lld",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
                
            }];
            
            return operation;
            
            


            
        }
        else
        {
            AFHTTPRequestOperation *operation=[manager POST:fullUrlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"上传成功");
                block(responseObject);
                

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"失败");
            }];
            
            
            
          
            return operation;
            
            

            
        }
        
    }
    

    return nil;
    
    
    
    
}





+(void)requestUrl:(NSString *)urlString
       httpMethod:(NSString *)method
           params:(NSMutableDictionary *)params
            block:(BlcokType)block
{

    
    //01  url
    NSString *fullString=[BaseUrl stringByAppendingString:urlString];//1
    NSURL *url=[NSURL    URLWithString:fullString];
    
    
    //02 request
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];//注意 此时 url还没给request
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
   

    
    //把params  转换格式

    
    
    NSArray *array=[params allKeys];
    NSMutableString *string=[[NSMutableString alloc]init];//3
    
    for (int i=0; i<array.count; i++) {
        
        
        NSString *key=array[i];
        NSString *value=params[key];
        
        [string appendFormat:@"%@=%@",key,value];
        
        if (i<array.count-1) {
            [string appendString:@"&"];
        }
        
    }
//    NSLog(@"%@", [params JSONString]);
    
   
    

    
     //结合所有字符串
    if ([method isEqualToString:@"GET"]) {
        
        NSString *seperation=url.query?@"&":@"?";//2
        
        NSString *paraUrlString=[NSString stringWithFormat:@"%@%@%@",fullString,seperation,string];
        
        NSLog(@"%@",paraUrlString);
        
        
        request.URL=[NSURL URLWithString:paraUrlString];
        
    }
    else if([method isEqualToString:@"POST"])
    {
        
        
        NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        request.URL=url;
    }
    
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        
        if (connectionError!=nil) {
            NSLog(@"网络请求失败");
            
        }
        
        
      //  id result=[NSJSONSerialization JSONObjectWithData:data options:   NSJSONReadingMutableContainers  error:nil];
        
        id result=[data objectFromJSONData];
        
        
        if (block)
        {
            block(result);
        }

    }];
    
    
        
}



+(void)getHomeList:(NSMutableDictionary*)params
             block:(BlcokType)block
{
    [DataService requestUrl:HomeList httpMethod:@"GET" params:params block:block];
}


+(void)sendWeibo:(NSMutableDictionary*)params
           block:(BlcokType)block
{
// [DataService requestUrl:SendWeiBo  httpMethod:@"POST" params:params block:block];

    [DataService requestAFUrl:SendWeiBo httpMethod:@"POST" params:params datas:nil block:block];
    

}


+(AFHTTPRequestOperation*)sendWeibo:(NSString *)text
           image:(UIImage *)image
           block:(BlcokType)block
{
    
    if (text==nil) {
        return nil;
        
    }
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:text forKey:@"status"];
    
    
    if (image==nil)
    {
        
        
    
    return     [DataService requestAFUrl:SendWeiBo httpMethod:@"POST" params:params datas:nil block:block];
        
        
    }
    
    //压缩最优
    NSData *data=UIImageJPEGRepresentation(image, 1);
    
    if(data.length>1024*1024*2)
    {
        data=UIImageJPEGRepresentation(image, 0.5);
        
    }
    
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]init];
    [dataDic setObject:data forKey:@"pic"];
    
    return    [DataService requestAFUrl:sendImage httpMethod:@"POST" params:params datas:dataDic block:block];
    
    
    
}

@end
