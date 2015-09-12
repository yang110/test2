//
//  NearByCell.h
//  HWWeiBo
//
//  Created by Mac on 15/9/1.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByModel.h"
@interface NearByCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titileLabel;

@property(nonatomic,strong) NearByModel *model;


@end
