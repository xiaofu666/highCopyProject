//
//  MenuViewController.h
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView* headerView;

@property (nonatomic, retain) IBOutlet UITableView* tableView;

@end
