//
//  ProfileTableViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "DataService.h"
#import "ProfileUserModel.h"
#import "ProfileUsersTableViewCell.h"
@interface ProfileTableViewController ()
{
    NSMutableArray *_modelArray;
    
}
@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINib *nib=[UINib nibWithNibName:@"ProfileUsersTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    
    [self loadData];

    

}

-(void)loadData
{
    
    _modelArray=[[NSMutableArray alloc]init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo  = [defaults objectForKey:@"HWWeiboAuthData"];
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[sinaweiboInfo objectForKey:@"UserIDKey"] forKey:@"uid"];

    
    [DataService requestAFUrl:@"/2/friendships/friends.json" httpMethod:@"GET" params:params datas:nil block:^(id result) {
    
        
        NSDictionary *dic=(NSDictionary *)result;
        
       NSArray *array= dic[@"users"];
        
        for ( NSDictionary *dicUser in array )
        {
            ProfileUserModel *model=[[ProfileUserModel alloc]initWithDataDic:dicUser];
            [_modelArray addObject:model ];
        }
        
        
        [self.tableView reloadData];
        
    }];
    
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileUsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

    cell.userModel=_modelArray[indexPath.row];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
