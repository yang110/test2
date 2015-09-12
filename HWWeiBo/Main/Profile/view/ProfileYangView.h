//
//  ProfileYangView.h
//  HWWeiBo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"
@interface ProfileYangView : UIView




@property (strong, nonatomic) IBOutlet UIImageView *headImageView;


@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *sex;


@property (strong, nonatomic) IBOutlet UILabel *address;

@property (strong, nonatomic) IBOutlet UILabel *describe;

@property (strong, nonatomic) IBOutlet UILabel *weiboNum;



@property (strong, nonatomic) IBOutlet UIButton *prosperity;
@property (strong, nonatomic) IBOutlet UIButton *fans;
@property (strong, nonatomic) IBOutlet UIButton *material;
@property (strong, nonatomic) IBOutlet UIButton *more;










@property(nonatomic,strong)ProfileUserModel *usermodel;




@end
