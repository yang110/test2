//
//  NearByCell.m
//  HWWeiBo
//
//  Created by Mac on 15/9/1.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "NearByCell.h"
#import "UIImageView+WebCache.h"

@implementation NearByCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(NearByModel *)model
{
    _model=model;
    [self setNeedsLayout];
    
}
-(void)layoutSubviews
{
    
    
    
    
    _titileLabel.text=_model.title;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    
    
    
}

@end
