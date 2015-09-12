//
//  CommentTableView.h
//  HWWeibo
//
//  Created by gj on 15/8/28.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UserView.h"
#import "CommentCell.h"


@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    //用户视图
    UserView *_userView;
    //微博视图
    WeiboView *_weiboView;
    //头视图
    UIView *_tableHeaderView;
}

//上一层 传过来的
@property(nonatomic,strong)NSArray *commentDataArray;//评论数据

//上一层 传过来的
@property(nonatomic,strong)WeiboModel *weiboModel;//头视图的数据


//评论数量要用到
@property(nonatomic,strong)NSDictionary *commentDic;



@end

