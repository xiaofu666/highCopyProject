//
//  RootSettingsViewController.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "RootSettingsViewController.h"
#import "AutoCloseSettingsViewController.h"
#import "AboutViewController.h"
#import "ClearSettingsViewController.h"

@interface RootSettingsViewController ()

@end

@implementation RootSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"menu_settings");
    
    SettingsService* service = SRV(SettingsService);
    __weak typeof(self) weakSelf = self;
    NSDictionary* section1 = @{@"header":LOC(@"settings_flow"),
                               @"footer":LOC(@"settings_flow_protection_prompt"),
                               @"rows":@[
                                       @{
                                           @"title":LOC(@"settings_flow_protection"),
                                           @"accessoryView":[UISwitch switchWithOn:service.flowProtection action:^(BOOL isOn) {
                                               service.flowProtection = isOn;
                                           }],
                                           },
                                       ]
                               };
    NSDictionary* section2 = @{@"header":@"应用",
                               @"rows":@[
                                       @{
                                           @"title":LOC(@"settings_auto_close"),
                                           @"detail":SRV(SettingsService).autoCloseRestTime > 0?[NSString fullStringWithSeconds:SRV(SettingsService).autoCloseRestTime]:@"",
                                           @"config":^(UITableViewCell* cell){
                                               [SRV(SettingsService) bk_addObserverForKeyPath:@"autoCloseRestTime" task:^(id target) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       int seconds = SRV(SettingsService).autoCloseRestTime;
                                                       cell.detailTextLabel.text = seconds > 0?[NSString fullStringWithSeconds:seconds]:nil;
                                                   });
                                               }];
                                           },
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(UITableViewCell* cell){
                                               AutoCloseSettingsViewController* vc = [[AutoCloseSettingsViewController alloc] initWithNibName:@"AutoCloseSettingsViewController" bundle:nil];
                                               [weakSelf.navigationController pushViewController:vc animated:YES];
                                           }
                                           },
                                       @{
                                           @"title":LOC(@"settings_clean_space"),
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(UITableViewCell* cell){
                                               ClearSettingsViewController* vc = [[ClearSettingsViewController alloc] initWithNibName:@"ClearSettingsViewController" bundle:nil];
                                               [weakSelf.navigationController pushViewController:vc animated:YES];
                                           }
                                           },
                                       @{
                                           @"title":LOC(@"settings_star"),
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(UITableViewCell* cell){
                                                [[UIApplication sharedApplication] openURL:[weakSelf rateURL]];
                                           }
                                           },
                                       @{
                                           @"title":LOC(@"settings_about"),
                                           @"accessoryType":@(UITableViewCellAccessoryDisclosureIndicator),
                                           @"action":^(__weak UITableViewCell* cell){
                                               AboutViewController* vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                                               [weakSelf.navigationController pushViewController:vc animated:YES];
                                           }
                                           },
                                       @{
                                           @"title":LOC(@"settings_version"),
                                           @"detail":[NSString stringWithFormat:@"v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]],
                                           },
                                       ]
                               };
    
    self.tableData = @[section1, section2];
}

- (NSURL* )rateURL {
    NSString* URLString;
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString* appId = @"1048612734";
    if (ver >= 7.0 && ver < 7.1) {
        URLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
    } else if (ver >= 8.0) {
        URLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    } else {
        URLString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    }
    return URLString.url;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
