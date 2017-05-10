//
//  SettingsViewController.h
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray* tableData;

@end
