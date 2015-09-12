//
//  NearByViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/9/1.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "NearByViewController.h"
#import "AFNetworking.h"
#import "DataService.h"
#import "NearByModel.h"
#import "NearByCell.h"
#import "ThemeButton.h"
#import "ThemeLabel.h"


#import "UIImageView+WebCache.h"
@interface NearByViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *_modelArray;
     UITableView *_tableView;
    
    NSString *latitude;
    NSString *longitude;
    
}
@end

@implementation NearByViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _createTableView];
    
    [self _setNavButton];
    
    [self _location];
    

    
  

}

#pragma mark - 导航栏左右按钮执行
//返回
-(void)letfAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//刷新
-(void)rightAction
{
  
    [self _location];
    
    
    
}


#pragma mark - viewDidLoad里面运行的
-(void)_createTableView
{
    
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    
    UINib *nib=[UINib nibWithNibName:@"NearByCell" bundle:nil];;
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    
}

-(void)_setNavButton
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
    label.text=@"返回";
    [button addSubview:label];
    
    
    
    //右边按钮
    ThemeButton *button2=[[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
   
    
    
    [button2 setNormalBgImageName:@"button_m.png"];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem=rightItem;
    [button2 addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//     button2.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 64);
    
    ThemeLabel *label1=[[ThemeLabel alloc]initWithFrame:CGRectMake(13, 0, 44, 44)];
    label1.colorName=@"Mask_Title_color";
    label1.text=@"刷新";
    [button2 addSubview:label1];

    
    
    
}

#pragma 地理位置
-(void)_location
{
    if (_locationManager==nil)
    {
        _locationManager=[[CLLocationManager alloc]init];
        
        
        if (kVersion>8.0)
        {
            
            //获取授权使用地理位置服务
            [_locationManager requestWhenInUseAuthorization];
            
            
            
            
            
        }
        
    }
    
    //定位精确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _locationManager.delegate=self;
    
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location=[locations lastObject];

    CLLocationCoordinate2D coordinate=location.coordinate;
    
    NSLog(@"%lf  %lf",coordinate.latitude,coordinate.longitude);
    
    latitude=[NSString stringWithFormat:@"%f",coordinate.latitude ];
    longitude=[NSString stringWithFormat:@"%f",coordinate.longitude ];
    
    
    [self _loadData];
    
    
    
    
}


-(void)_loadData
{
    
    
    _modelArray=[[NSMutableArray alloc]init];
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:latitude forKey:@"lat"];
    [params setValue:longitude forKey:@"long"];
    
    [DataService requestAFUrl:nearBy httpMethod:@"GET" params:params datas:nil block:^(id result) {
        
        //        NSLog(@"%@",result);
        
        if ([result count]>0)
        {
            NSArray *array=   result[@"pois"];
            for (NSDictionary *dic in array )
            {
                NearByModel *model=[[NearByModel alloc]initWithDataDic:dic];
                [_modelArray addObject:model];
                
            }
        }
        
        [_tableView reloadData];
        
        
        
        
        
    }];
    
    
    
    
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NearByCell     *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model=_modelArray[indexPath.row];

    return cell;
    

    
}

@end
