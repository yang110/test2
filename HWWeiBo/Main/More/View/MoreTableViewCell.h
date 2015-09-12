//
//  MoreTableViewCell.h
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface MoreTableViewCell : UITableViewCell


@property(nonatomic,strong) ThemeImageView *imgView;
@property(nonatomic,strong) ThemeLabel *mainLabel;
@property(nonatomic,strong) ThemeLabel *subLabel;


@end
