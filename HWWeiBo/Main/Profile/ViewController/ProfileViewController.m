//
//  ProfileViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataService.h"
#import "ProfileUserModel.h"
#import "WeiboTableView.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "WeiboViewLayoutFrame.h"
#import "ProfileYangView.h"
#import "MJRefresh.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ProfileViewController ()<SinaWeiboRequestDelegate>
{
    ProfileUserModel    *profileUserModel;
    WeiboTableView *_tableView;
        NSMutableArray *_data;
    ProfileYangView *yangView;
    
    
    ThemeImageView *_barimageView;
    ThemeLabel *_barLabel;

    
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavButton];
    [self createTableView];
    [self loadData];//头的数据
    [self loadData2];//自己发的微博的数据
    
}


-(void)loadData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo  = [defaults objectForKey:@"HWWeiboAuthData"];

    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[sinaweiboInfo objectForKey:@"UserIDKey"] forKey:@"uid"];
    
    
    
    [DataService requestAFUrl:userWeibo httpMethod:@"GET" params:params datas:nil block:^(id result) {
        
        NSLog(@"%@",result);
        
        
        NSDictionary *dic=result;
        
        profileUserModel=   [[ProfileUserModel alloc]initWithDataDic:dic ];//里面是个人信息

        //传数据
        yangView.usermodel=profileUserModel;

    }];
    
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
    
//    //上啦
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    
    //2.加载xib创建用户视图(高度为xib高度)
    yangView=[[[NSBundle mainBundle] loadNibNamed:@"ProfileYangView" owner:self options:nil] lastObject];
    _tableView.tableHeaderView=yangView;
    
    
    
}

- (SinaWeibo *)sinaweibo
{
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
    
    
}


-(void)loadData2
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    if ([sinaweibo isAuthValid])
    {
        
        
        
        NSLog(@"已经登录");
        NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
        
         [params setObject:@"5" forKey:@"count"];
        //获取微博
        SinaWeiboRequest *requset=[sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                                     params:[params mutableCopy]
                                                 httpMethod:@"GET"
                                                   delegate:self];
        requset.tag=100;
//  加载提示
        [self showHUD:@"正在加载"];
        _tableView.hidden = YES;

    }
    else
    {
        
        [sinaweibo logIn];
    }
    
}


-(void)loadMoreData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"5" forKey:@"count"];
    
    if (_data.count!=0) {
        WeiboViewLayoutFrame *layoutFrame=[_data lastObject];
        WeiboModel *model=layoutFrame.weiboModel;
        NSString *maxId=model.weiboId.stringValue;
        
        
//        2015-09-11 10:34:36.309 HWWeiBo[2136:85337] 3885231096887629
//        2015-09-11 10:34:41.346 HWWeiBo[2136:85337] 3882338783907326
//        2015-09-11 10:34:59.093 HWWeiBo[2136:85337] 3882338783907326
//        NSLog(@"%@",maxId);
//        此接口最多只返回最新的5条数据，官方移动SDK调用可返回10条；

        
        [params setValue:maxId forKey:@"max_id"];
    }
    
    
    
    //获取微博
    SinaWeiboRequest *requset=[sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                                 params:[params mutableCopy]
                                             httpMethod:@"GET"
                                               delegate:self];
    
    requset.tag=102;
    
    
}

- (void)loadNewData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:@"5" forKey:@"count"];
    
    if (_data.count!=0) {
        WeiboViewLayoutFrame *layoutFrame=_data[0];
        WeiboModel *model=layoutFrame.weiboModel;
        
        NSString * sinceId=model.weiboId.stringValue;
        [params setObject:sinceId forKey:@"since_id"];
        
    }
    
    SinaWeiboRequest *request=[sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                                 params: [params mutableCopy]
                                             httpMethod:@"GET"
                                               delegate:self];
    request.tag=101;
    
}


-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
//      NSLog(@"获得请求数据%@",result);
    
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
    
    
    
//    
    
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
