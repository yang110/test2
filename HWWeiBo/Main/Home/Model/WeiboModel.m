//
//  WeiboModel.m
//  HWWeiBo
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary
{
    
    
    
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                            @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}

//覆写
-(void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];

    //处理微博来源
    NSString *string=self.source;

    if (self.source!=nil) {
         NSString *regex=@">.+<";
         NSArray *items=  [string componentsMatchedByRegex:regex];
    
        if (items.count!=0) {
            NSString *temp=[items lastObject] ;
            temp=[temp substringWithRange:NSMakeRange(1, temp.length-2)];
        
            self.source=[NSString stringWithFormat:@"来源:%@",temp];
        }
    }
    
    
    
    //02处理图片
    

    NSString *regex=@"\\[\\w+\\]";
    NSArray *faceItems=[self.text componentsMatchedByRegex:regex];//[兔子] [微笑]
    
    NSString *configPath=[[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray=[NSArray arrayWithContentsOfFile:configPath];
    
    
    for (NSString *faceName in faceItems)
    {
        
        // 对 faceConfigArray 进行筛选（其实只有一个）
        NSString *t=[NSString stringWithFormat:@"chs='%@'",faceName];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:t];
        NSArray *items=[faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count>0) {
            
            //获取 @"1.png"
            NSDictionary *dicConfig=[items lastObject];
            
            
            NSString *imageName=[dicConfig objectForKey:@"png"];
            
            
            // <image url = '1.png'>
            NSString *replaceString=[NSString stringWithFormat:@"<image url = '%@'>",imageName];
            
            //[兔子]－－》<image url = '001.png'>
            self.text =   [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
            
            
        }
    
    
    }
    
    
    
    
    
    
    
    
    
    
    //  user 解读
    NSDictionary *userDic=[dataDic objectForKey:@"user"];
    if (userDic !=nil)
    {
        UserModel *userModel=[[UserModel alloc]initWithDataDic:userDic];
        self.userModel=userModel;
        
        
        
    }
    
    
    
    // ＋转发 用户名字
    NSDictionary *redic=[dataDic objectForKey:@"retweeted_status"];
    if (redic!=nil)
    {
        self.reWeiboModel=[[WeiboModel alloc ]initWithDataDic:redic];
        
        //拼接转发微博用户
        NSString *name  = self.reWeiboModel.userModel.name;
        self.reWeiboModel.text=[NSString stringWithFormat:@"@%@:%@",name ,self.reWeiboModel.text];
        
        
        
    }
    
    
    
    
    
    
}


@end
