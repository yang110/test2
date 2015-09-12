//
//  WeiboViewLayoutFrame.h
//  HWWeiBo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
@interface WeiboViewLayoutFrame : NSObject


@property(nonatomic,assign)CGRect textFrame;//微博内容的frame
@property(nonatomic,assign)CGRect sourceTextFrame;//原微博内容的frame
@property(nonatomic,assign)CGRect imgFrame;//微博图片的frame
@property(nonatomic,assign)CGRect bgImageFrame;//原微博图片的frame
@property(nonatomic,assign)CGRect frame;


@property(nonatomic,strong)WeiboModel *weiboModel;

//是否是微博详情
@property(nonatomic,assign)BOOL isDetail;



@end
