//
//  ProfileUsersTableViewCell.m
//  HWWeiBo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ProfileUsersTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ProfileUsersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







-(void)setUserModel:(ProfileUserModel *)userModel
{
    _userModel=userModel;
    [self setNeedsLayout];
    
}

-(void)layoutSubviews
{
    
    
    
    
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.profile_image_url ]];
    _location.text=_userModel.location;
    _name.text=_userModel.name;
    
    
    
    
    
    
}

@end
