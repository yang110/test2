//
//  ProfileYangView.m
//  HWWeiBo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ProfileYangView.h"
#import "UIImageView+WebCache.h"
#import "ProfileViewController.h"
#import "UIView+UIViewController.h"

#import "ProfileTableViewController.h"
#import "ProfileFansTableViewController.h"
@implementation ProfileYangView



//还未创建 各个按钮
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        
        
    }
    return self;
    
}

- (IBAction)button1:(id)sender
{
    NSLog(@"1");
    
    ProfileViewController *vc=  (ProfileViewController*) [self viewController];
    
    
    
    
    if (vc!=nil)
    {
        
        ProfileTableViewController *vcc=[[ProfileTableViewController alloc]init];
      
        
        [vc.navigationController pushViewController:vcc animated:YES];
        

    }
    
    
    
    
    
}

- (IBAction)button2:(id)sender
{
    
    NSLog(@"2");
    
    ProfileViewController *vc=  (ProfileViewController*) [self viewController];
    
    
    
    if (vc!=nil)
    {
        
        ProfileFansTableViewController *vcc=[[ProfileFansTableViewController alloc]init];
        [vc.navigationController pushViewController:vcc animated:YES];
    }
    

}

-(void)setUsermodel:(ProfileUserModel *)usermodel
{
    _usermodel=usermodel;
    [self setNeedsLayout];
}



-(void)layoutSubviews
{
    
    [_headImageView  sd_setImageWithURL:[NSURL URLWithString:_usermodel.profile_image_url]];
    
    
    _name.text=_usermodel.name;
    _sex.text=_usermodel.gender;
    _address.text=_usermodel.location;
    
    
    
    _describe.text=_usermodel.descripe;
    
    

    
    
    _weiboNum.text=[NSString stringWithFormat:@"微博数 :%@",_usermodel.statuses_count];
    
    
    [_prosperity setTitle:[NSString stringWithFormat:@"关注数 :%@",_usermodel.friends_count] forState:UIControlStateNormal];
    
    [_fans setTitle:[NSString stringWithFormat:@"粉丝数 :%@",_usermodel.followers_count] forState:UIControlStateNormal];
    
    
    
    
}
//
//@property (strong, nonatomic) IBOutlet UIButton *prosperity;
//@property (strong, nonatomic) IBOutlet UIButton *fans;
//@property (strong, nonatomic) IBOutlet UIButton *material;
//@property (strong, nonatomic) IBOutlet UIButton *more;
//
//




//@property(nonatomic,retain)NSNumber * followers_count;    //粉丝数
//@property(nonatomic,retain)NSNumber * friends_count;   //关注数
//@property(nonatomic,retain)NSNumber * statuses_count;   //微博数
//@property(nonatomic,retain)NSNumber * favourites_count;   //收藏数
//

//@property (strong, nonatomic) IBOutlet UILabel *name;
//@property (strong, nonatomic) IBOutlet UILabel *sex;
//
//
//@property (strong, nonatomic) IBOutlet UILabel *address;
//
//@property (strong, nonatomic) IBOutlet UILabel *describe;
//
//@property (strong, nonatomic) IBOutlet UILabel *weiboNum;
//

@end
