//
//  BaseViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"

#import "ThemeButton.h"
#import "ThemeLabel.h"
#import "ThemeManager.h"



@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
}


#pragma mark - 状态栏提示

- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation{
    
    
    if (_tipWindow == nil) {
        //创建window
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //创建Label
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor clearColor];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.font = [UIFont systemFontOfSize:13.0f];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 100;
        [_tipWindow addSubview:tpLabel];
        
        
        //进度条
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 20-3, kScreenWidth, 5);
        progress.tag = 101;
        progress.progress = 0.0;
        [_tipWindow addSubview:progress];
        
        
    }
    
    UILabel *tpLabel = (UILabel *)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    
    if (show) {
        _tipWindow.hidden = NO;
        if (operation != nil) {
            progressView.hidden = NO;
            //AF 对 UIProgressView的扩展
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else{
            progressView.hidden = YES;
        }
        
        
    }else{
        
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
}


- (void)removeTipWindow{
    
    _tipWindow.hidden = YES;
    _tipWindow = nil;
}





-(void)letfAction
{
    MMDrawerController *mmDraw=self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
    
}

-(void)rightAction
{
    MMDrawerController *mmDraw=self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}

-(void)setNavButton
{

    
    //左边按钮
    ThemeButton *button=[[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    [button setNormalImageName:@"group_btn_all_on_title.png"];
    [button setNormalBgImageName:@"button_title.png"];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=leftItem;
    [button addTarget:self action:@selector(letfAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 34);
    
    
    
    ThemeLabel *label=[[ThemeLabel alloc]initWithFrame:CGRectMake(40, 0, 44, 44)];
    label.colorName=@"Mask_Title_color";
    label.text=@"设置";
    [button addSubview:label];


    
    //右边按钮
    ThemeButton *button2=[[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button2 setNormalImageName:@"button_icon_plus.png"];
    [button2 setNormalBgImageName:@"button_m.png"];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem=rightItem;
    [button2 addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
   
}


#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotification object:nil];
    
    [self _loadImage];
}

- (void)_loadImage{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *img = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}




#pragma mark 使用三方库实现加载提示
//显示hud提示
- (void)showHUD:(NSString *)title {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view
                                    animated:YES];
    }
    
    [_hud show:YES];
    _hud.labelText = title;
    //_hud.detailsLabelText  //子标题
    
    //灰色的背景盖住其他视图
    _hud.dimBackground = YES;
}

- (void)hideHUD {
    
    //延迟隐藏
    //[_hud hide:YES afterDelay:(NSTimeInterval)]
    
    [_hud hide:YES];
}

//完成的提示
- (void)completeHUD:(NSString *)title {
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    
    //延迟隐藏
    [_hud hide:YES afterDelay:1.5];
}


@end
