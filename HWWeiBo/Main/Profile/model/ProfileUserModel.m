//
//  ProfileUserModel.m
//  HWWeiBo
//
//  Created by Mac on 15/9/9.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ProfileUserModel.h"

@implementation ProfileUserModel



//覆写
-(void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
    
    
    
    //  discription 解读
    
    self.descripe=[dataDic objectForKey:@"description"];
    
    
    
    
    
    //  weibiModel 解读
    NSDictionary *weiboDic=[dataDic objectForKey:@"status"];
    if (weiboDic !=nil)
    {
        WeiboModel *weiboModel=[[WeiboModel alloc]initWithDataDic:weiboDic];
        self.weiboModel=weiboModel;
        
    }

}


-(void)setGender:(NSString *)gender
{
    if ([gender isEqualToString:@"m"]) {
        _gender=@"男";
    }
    else
    {
        _gender=@"女";
    }
    
}




@end
