//
//  LeftViewController.h
//  HWWeiBo
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LeftViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_sectionTitles;
    NSArray *_rowTitles;
}
@end
