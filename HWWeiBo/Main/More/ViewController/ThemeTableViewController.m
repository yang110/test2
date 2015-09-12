//
//  ThemeTableViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeManager.h"
@interface ThemeTableViewController ()
{
       NSArray *themeNameArray;
}
@end

@implementation ThemeTableViewController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.hidesBottomBarWhenPushed=YES;
        
    }
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme.plist" ofType:nil];
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    themeNameArray = [themeConfig allKeys];
    
    
    [self.tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"ThemeCell"];

    self.tableView.backgroundColor=[UIColor clearColor];

    
 
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return themeNameArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThemeCell" forIndexPath:indexPath];
  
    
  
    
    cell.mainLabel.text=themeNameArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *themeName = themeNameArray[indexPath.row];
    [[ThemeManager shareInstance] setThemeName:themeName];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
