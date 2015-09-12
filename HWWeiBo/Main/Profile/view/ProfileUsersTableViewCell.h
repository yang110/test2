//
//  ProfileUsersTableViewCell.h
//  HWWeiBo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileUserModel.h"
@interface ProfileUsersTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *location;



@property(nonatomic,strong)ProfileUserModel *userModel;

@end
