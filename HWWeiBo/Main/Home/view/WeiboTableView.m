//
//  WeiboTableView.m
//  HWWeiBo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboViewLayoutFrame.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "UIView+UIViewController.h"
@implementation WeiboTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    
    self=[super initWithFrame:frame style:style];
    if (self) {
        
        
        
        [self _createView];
    }
    return self;
    
}


- (void)awakeFromNib{
    
    [self _createView];
}

- (void)_createView{
    
    //不允许选中
//   self.allowsSelection=NO;
    
    
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = [UIColor clearColor];
    
    
    //去线条
    self.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"HomeWeiBoCell"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.layoutFrameArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [self dequeueReusableCellWithIdentifier:@"HomeWeiBoCell" forIndexPath:indexPath];
    
    
    //设置数据

    cell.layoutFrame=_layoutFrameArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WeiboViewLayoutFrame *layoutFrame=_layoutFrameArray[indexPath.row];
    
    CGRect  rect=layoutFrame.frame;
    CGFloat height=  rect.size.height;
    
    //计算cell高度
//    NSLog(@"%ld  %f",indexPath.row,height);
    
    return height+80;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] init];
    
    
    
    WeiboViewLayoutFrame *layoutFrame = self.layoutFrameArray[indexPath.row];
    
    // 只需要 数据 不需要frame
    vc.weiboModel = layoutFrame.weiboModel;
    
    
    [self.viewController.navigationController pushViewController:vc
                                                        animated:YES];
    

        
    
}




@end
