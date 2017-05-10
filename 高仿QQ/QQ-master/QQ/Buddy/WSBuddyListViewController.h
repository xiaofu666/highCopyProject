//
//  TelphoneViewController.h
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import "NSObject+CoreDataHelper.h"
#import "ODRefreshControl.h"

/**
 *  @brief  我的好友列表
 */
@interface WSBuddyListViewController : UIViewController
{
    NSFetchedResultsController *_fetchedResultsController;
    ODRefreshControl*           _refreshControl;
    UITableView  *              _tableView;
}

@property(nonatomic,strong,readonly)UITableView *tableView;

@end
