//
//  WeiboView.h
//  HWWeiBo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property(nonatomic,strong)WXLabel *textLabel;//微博文字
@property(nonatomic,strong) WXLabel *sourceLabel;//原微博文字
@property(nonatomic,strong)ZoomImageView *imageView;//微博图片
@property(nonatomic,strong)ThemeImageView *bgImageView;//原微博背景图片 

@property(nonatomic,strong) WeiboViewLayoutFrame *layouFrame;

@end
