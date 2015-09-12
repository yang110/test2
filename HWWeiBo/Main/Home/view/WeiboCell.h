//
//  WeiboCell.h
//  HWWeiBo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboViewLayoutFrame.h"
#import "ThemeLabel.h"
@interface WeiboCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet ThemeLabel *userName;
@property (strong, nonatomic) IBOutlet ThemeLabel *commentCount;
@property (strong, nonatomic) IBOutlet ThemeLabel *repostCount;
@property (weak, nonatomic) IBOutlet ThemeLabel *createTime;
@property (strong, nonatomic) IBOutlet ThemeLabel *source;



@property(nonatomic,strong)WeiboView *weiboView;



@property(nonatomic,strong)WeiboViewLayoutFrame *layoutFrame;


@end
