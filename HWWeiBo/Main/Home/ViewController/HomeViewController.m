//
//  HomeViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "HomeViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "WeiboModel.h"

#import "WeiboTableView.h"
#import "WeiboViewLayoutFrame.h"
#import "MJRefresh.h"

#import "ThemeLabel.h"
#import "ThemeImageView.h"

#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController ()
{
    WeiboTableView *_tableView;
    NSMutableArray *_data;
    
    
    ThemeImageView *_barimageView;
    ThemeLabel *_barLabel;
    
    
}
@end

@implementation HomeViewController



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"Home initWithCoder");
    }
    return self;
}

- (SinaWeibo *)sinaweibo
{
    
    
  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;


}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   _data=[[NSMutableArray alloc]init];
    
    [self setNavButton];
    [self createTableView];
    [self loadData];
 
    
    
}

-(void)createTableView
{
    _tableView = [[WeiboTableView alloc] initWithFrame:self.view.bounds ];

    //设置上下边界距离
    //_tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    
    //下啦
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    //上啦
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}
- (void)loadNewData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:@"20" forKey:@"count"];
    
    if (_data.count!=0) {
        WeiboViewLayoutFrame *layoutFrame=_data[0];
        WeiboModel *model=layoutFrame.weiboModel;
        
        NSString * sinceId=model.weiboId.stringValue;
        [params setObject:sinceId forKey:@"since_id"];
        
    }
    
    SinaWeiboRequest *request=[sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                 params: [params mutableCopy]
                                             httpMethod:@"GET"
                                               delegate:self];
    request.tag=101;

}


-(void)loadMoreData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"10" forKey:@"count"];
    
    if (_data.count!=0) {
        WeiboViewLayoutFrame *layoutFrame=[_data lastObject];
        WeiboModel *model=layoutFrame.weiboModel;
        NSString *maxId=model.weiboId.stringValue;
        [params setValue:maxId forKey:@"max_id"];
    }
    
    //获取微博
    SinaWeiboRequest *requset=[sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                       params:[params mutableCopy]
                                                   httpMethod:@"GET"
                                                     delegate:self];
    
    requset.tag=102;
    
    
}




-(void)loadData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    if ([sinaweibo isAuthValid])
    {
        
        
        
        NSLog(@"已经登录");
        NSDictionary *params = @{@"count":@"10"};
        
        //获取微博
        SinaWeiboRequest *requset=[sinaweibo requestWithURL:@"statuses/home_timeline.json"
                           params:[params mutableCopy]
                       httpMethod:@"GET"
                         delegate:self];
        
        requset.tag=100;
        
        
// 加载提示
         [self showHUD:@"正在加载"];
        _tableView.hidden = YES;

    
        
    }
    else
    {
        
        [sinaweibo logIn];
    }

}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//     NSLog(@"获得请求数据%@",result);
    
    NSArray *statuses=[result objectForKey:@"statuses"];
    
   
    //暂时存储  待分配
    NSMutableArray *mArray=[[NSMutableArray alloc]init];
    
    
    for (int i=0;i<statuses.count;i++ )
    {
         NSDictionary *dataDic=statuses[i];

        WeiboModel *model=[[WeiboModel alloc]initWithDataDic:dataDic];
        WeiboViewLayoutFrame *layoutFrame=[[WeiboViewLayoutFrame alloc]init];
        layoutFrame.weiboModel=model;
        
        [mArray addObject:layoutFrame];
    
    }
    
    if (request.tag==100) {
        
        
        _data=mArray;
        
//加载提示
        [self completeHUD:@"加载完成"];
        _tableView.hidden = NO;
        
    }
    else if(request.tag==101)//最新数据
    {
        if (mArray.count>0)
        {
            
            [self showNewWeibo:mArray.count];
            
            
            NSRange range=NSMakeRange(0, mArray.count);
            NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
            
            [_data insertObjects:mArray atIndexes:indexSet];
            
            
        }
        
    }
    else if(request.tag==102)//更多数据
    {
        
        if (mArray.count>1)
        {
            [mArray removeObjectAtIndex:0];
            
            [_data addObjectsFromArray:mArray];
            
        
        }
        
    }
    
    
    
    
    
    
    if (mArray.count>0)
    {
  
        _tableView.layoutFrameArray=_data;
        [_tableView reloadData];

    }

 
    

    
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
    
    
}



-(void)showNewWeibo:(NSInteger )count
{
    
  

    if (_barimageView==nil) {
        
        
        _barimageView=[[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barimageView.imgName=@"timeline_notify.png";
        [self.view addSubview:_barimageView];
        
        
        
        
        
        
        _barLabel=[[ThemeLabel alloc]initWithFrame:_barimageView.bounds];
        _barLabel.backgroundColor=[UIColor clearColor];
        _barLabel.textAlignment=NSTextAlignmentCenter;
        _barLabel.colorName=@"Timeline_Notice_color";
        [_barimageView addSubview:_barLabel];

        
    }

    
    if (count > 0)
    {
        
        _barLabel.text=[NSString stringWithFormat:@"更新了%li条微博",count];
        
        [UIView animateWithDuration:1 animations:^{
            
            _barimageView.transform=CGAffineTransformMakeTranslation(0, 40+64+6);
        } completion:^(BOOL finished) {
            
            if (finished)
            {
                
                
                [UIView animateWithDuration:1 animations:^{
                    
                    [UIView setAnimationDelay:1];
                    _barimageView.transform=CGAffineTransformIdentity;
                    
                    
                } completion:^(BOOL finished) {
                
                }];
                
                
                
                
                
            }
            
        }];
        
        
        
    }

    
    
    //添加声音
    NSString *path=[[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url=[NSURL fileURLWithPath:path];
    
    //注册系统声音
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
    
    AudioServicesPlaySystemSound(soundId);
    
    


}

@end
