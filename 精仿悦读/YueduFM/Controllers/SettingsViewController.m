//
//  SettingsViewController.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray* _tableData;
}

@end

static NSString* kCellIdentifier = @"kCellIdentifier";

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RightAlignedTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData[section][@"rows"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSDictionary* info = self.tableData[indexPath.section][@"rows"][indexPath.row];
    cell.textLabel.text = info[@"title"];
    cell.detailTextLabel.text = info[@"detail"];
    cell.accessoryView = info[@"accessoryView"];
    
    NSNumber* typeNumber = info[@"accessoryType"];
    if (typeNumber) {
        cell.accessoryType = [typeNumber intValue];
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    void(^config)(UITableViewCell* cell) = info[@"config"];
    if (config) config(cell);
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.tableData[section][@"header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.tableData[section][@"footer"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* info = self.tableData[indexPath.section][@"rows"][indexPath.row];
    void(^action)(UITableViewCell* cell) = info[@"action"];
    if (action) {
        action([tableView cellForRowAtIndexPath:indexPath]);
    }
}

@end
