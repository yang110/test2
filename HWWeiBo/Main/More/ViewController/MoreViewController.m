//
//  MoreViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeManager.h"
#import "ThemeTableViewController.h"
#import "AppDelegate.h"
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    
}

@end

@implementation MoreViewController


- (void)viewDidLoad {

    
    [super viewDidLoad];
    [self createTableView];
    [self setNavButton];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [_tableView reloadData];
}


-(void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    
    _tableView.backgroundColor=[UIColor clearColor];
    
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;

    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            cell.imgView.imgName=@"more_icon_theme.png";
            cell.mainLabel.text=@"主题选择";
            cell.subLabel.text=[ThemeManager shareInstance].themeName;
        }
        else if(indexPath.row==1)
        {
            cell.imgView.imgName=@"more_icon_account.png";
            cell.mainLabel.text=@"账户管理";
        }
    }
    else if(indexPath.section==1)
    {
        cell.imgView.imgName=@"more_icon_feedback.png";
        cell.mainLabel.text=@"意见反馈";
    }
    else if(indexPath.section==2)
    {
        cell.mainLabel.text=@"退出当前登入";
        cell.mainLabel.textAlignment=NSTextAlignmentCenter;
        cell.mainLabel.center = cell.contentView.center;
    }
    
    
    //设置箭头
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0 && indexPath.section == 0)
    {
        ThemeTableViewController *vc = [[ThemeTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        [alert show];
        
        
        
    }

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate.sinaweibo logOut];
    }
    
}


@end
