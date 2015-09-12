//
//  DetailViewController.m
//  HWWeibo
//
//  Created by gj on 15/8/28.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "DetailViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建列表
    [self _createTableView];
    [self _loadData];
    
}


- (void)_createTableView{

    _tableView = [[CommentTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
 
    _tableView.weiboModel = _weiboModel;
    
    //上拉加载
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    
  
}

//加载数据
- (void)_loadData{
    
    NSString *weiboId = self.weiboModel.weiboIdStr ;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    SinaWeibo *sinaWeibo = [self sinaweibo];
    SinaWeiboRequest *request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    request.tag = 100;
    
}

//加载更多数据
- (void)_loadMoreData{
    NSString *weiboId = self.weiboModel.weiboIdStr ;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    
    //设置max_id 分页加载
    CommentModel *cm = [self.data lastObject];
    if (cm == nil) {
        return;
    }
    NSString *lastID = cm.idstr;
    [params setObject:lastID forKey:@"max_id"];
    

    SinaWeibo *sinaWeibo = [self sinaweibo];
    SinaWeiboRequest *request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    request.tag = 102;
    

}

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"网络接口 请求成功");
    
    NSArray *array = [result objectForKey:@"comments"];
   
    NSMutableArray *comentModelArray = [[NSMutableArray alloc] initWithCapacity:array.count];
   
    for (NSDictionary *dataDic in array) {
        CommentModel *commentModel = [[CommentModel alloc]initWithDataDic:dataDic];
        [comentModelArray addObject:commentModel];
    }
    
    
    if (request.tag == 100) {
        self.data = comentModelArray;
      
    }else if(request.tag ==102){//更多数据
        [_tableView.footer endRefreshing];
        if (comentModelArray.count > 1) {
            [comentModelArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:comentModelArray];
        }else{
            return;
        }
    }

    _tableView.commentDataArray = _data;
    
    
    
    _tableView.commentDic = result;
    
    [_tableView reloadData];

  
    
}


@end
