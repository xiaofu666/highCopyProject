//
//  ClearSettingsViewController.m
//  YueduFM
//
//  Created by StarNet on 10/12/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "ClearSettingsViewController.h"

@interface ClearSettingsViewController ()

@end

@implementation ClearSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"settings_clean_space");
    
    NSDictionary* section1 = @{
                               @"footer":LOC(@"settings_clean_picture_space"),
                               @"rows":@[
                                       @{
                                           @"title":LOC(@"settings_clean_picture_space"),
                                           @"detail":[NSString stringWithFileSize:[[SDImageCache sharedImageCache] getSize]],
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(UITableViewCell* cell){
                                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                   [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           cell.detailTextLabel.text = [NSString stringWithFileSize:[[SDImageCache sharedImageCache] getSize]];
                                                           [SVProgressHUD showSuccessWithStatus:LOC(@"settings_clean_successed")];
                                                       });
                                                   }];
                                               });
                                           }
                                           },
                                       ]
                               };
    NSDictionary* section2 = @{
                               @"footer":LOC(@"settings_clean_downloaded_space_prompt"),
                               @"rows":@[
                                       @{
                                           @"title":LOC(@"settings_clean_downloaded_space"),
                                           @"detail":[NSString stringWithFileSize:[SRV(DownloadService) cacheSize]],
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(UITableViewCell* cell){
                                               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                   [SRV(ArticleService) deleteAllDownloaded:^{
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           cell.detailTextLabel.text = [NSString stringWithFileSize:[SRV(DownloadService) cacheSize]];
                                                           [SVProgressHUD showSuccessWithStatus:LOC(@"settings_clean_successed")];
                                                       });                                                       
                                                   }];
                                               });
                                           }
                                           },
                                       ]
                               };
    
    self.tableData = @[section1, section2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
