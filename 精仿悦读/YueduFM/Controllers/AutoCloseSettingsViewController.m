//
//  AutoCloseSettingsViewController.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "AutoCloseSettingsViewController.h"

@interface AutoCloseSettingsViewController ()

@end

@implementation AutoCloseSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = LOC(@"settings_auto_close");
    
    __weak typeof(self) weakSelf = self;
    void(^action)(UITableViewCell* cell) = ^(UITableViewCell* cell) {
        [[weakSelf.tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(UITableViewCell* )obj setAccessoryView:nil];
        }];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cell_check.png"]];
        SRV(SettingsService).autoCloseLevel = [weakSelf.tableView indexPathForCell:cell].row;
    };
    
    NSMutableArray* rows = [NSMutableArray array];
    NSInteger level = SRV(SettingsService).autoCloseLevel;
    [SRV(SettingsService).autoCloseTimes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* row = [NSMutableDictionary dictionary];
        row[@"title"] = [self formatTime:[obj intValue]];
        row[@"action"] = action;
        if (idx == level) {
            row[@"accessoryView"] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cell_check.png"]];
        }
        [rows addObject:row];
    }];
    
    
    NSDictionary* section1 = @{@"header":LOC(@"time"),
                               @"rows":rows
                               };
    
    self.tableData = @[section1];
}

- (NSString* )formatTime:(int)minius {
    int h = minius/60;
    int m = minius%60;
    
    NSMutableString* timeString = [NSMutableString string];
    if (!h && !m) {
        [timeString appendString:LOC(@"none")];
    } else {
        if (h) {
            [timeString appendFormat:@"%d%@", h, LOC(@"hour")];
        }
        
        if (m) {
            [timeString appendFormat:@"%d%@", m, LOC(@"minute")];
        }
    }
    return timeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
