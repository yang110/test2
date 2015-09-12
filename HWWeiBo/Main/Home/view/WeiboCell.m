//
//  WeiboCell.m
//  HWWeiBo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
#import "WeiboView.h"
@implementation WeiboCell

- (void)awakeFromNib {
    
    self.backgroundColor=[UIColor clearColor];
    
   
    
    
    _weiboView=[[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    

    
    
    //主题颜色
    _userName.colorName=@"Timeline_Name_color";
    _commentCount.colorName=@"Timeline_Name_color";
    _repostCount.colorName=@"Timeline_Name_color";
    
    
    _source.colorName=@"Timeline_Time_color";
    _createTime.colorName =@"Timeline_Time_color";
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame
{
    
    
    
    if (_layoutFrame!=layoutFrame) {
        _layoutFrame=layoutFrame;

        [self setNeedsLayout];
    }

}


-(void)layoutSubviews
{
    
    
    

    
    WeiboModel *_model=_layoutFrame.weiboModel;
    

    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];
    self.userName.text = _model.userModel.screen_name;
    self.commentCount.text=[NSString stringWithFormat:@"评论数:%@",_model.commentsCount];
    self.source.text=_model.source;
    self.repostCount.text=[NSString stringWithFormat:@"转发数:%@",_model.repostsCount];;
   

    //年 月 日 时 分
    self.createTime.text=[Utils weiboDateString:_model.createDate];
    
    self.weiboView.layouFrame=_layoutFrame;
    self.weiboView.frame=_layoutFrame.frame;
 
    
    
    

}

@end
