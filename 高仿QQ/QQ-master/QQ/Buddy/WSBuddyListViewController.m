//
//  TelphoneViewController.m
//  QQ
//
//  Created by weida on 15/8/13.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSBuddyListViewController.h"
#import "WSBuddyListViewController+CoreData.h"
#import "WSBuddyGroupModel.h"
#import "WSBuddylistTableViewCell.h"
#import "WSBuddyListTableHeaderView.h"
#import "WSChatTableViewController.h"

#define kReusedCellID         (@"unique")
#define kRowHeight            (44)
#define kSectionHeaderHeight  (40)

@interface WSBuddyListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation WSBuddyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - TableView Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    return [sectionInfo numberOfObjects];
//    NSInteger count = [sectionInfo numberOfObjects];
//    if (count)
//    {
//        WSBuddyModel* buddy = [sectionInfo objects][0];
//        if (buddy.group.hide.boolValue)
//        {
//            count = 0;//需要隐藏
//        }
//    }
//    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSBuddyModel *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    WSBuddyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedCellID forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSBuddyListTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kReusedCellID];
    headerView.tag = section+1;
    NSLog(@"headeView:%@",headerView);
    id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    if ([[self.fetchedResultsController sections] count] > 0)
    {
        sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    }
    headerView.sectionInfo = sectionInfo;
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatTableViewController *chat = [[WSChatTableViewController alloc]init];
     chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadView
{
    self.view = self.tableView;
}

#pragma mark - Getter Method

-(UITableView *)tableView
{
    if (_tableView)
    {
        return _tableView;
    }
    
    _tableView                      =   [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   [UIColor whiteColor];
    _tableView.delegate             =   self;
    _tableView.dataSource           =   self;
    _tableView.rowHeight            =   kRowHeight;
    _tableView.sectionHeaderHeight  =   kSectionHeaderHeight;
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[WSBuddyListTableViewCell class] forCellReuseIdentifier:kReusedCellID];
    [_tableView registerClass:[WSBuddyListTableHeaderView class] forHeaderFooterViewReuseIdentifier:kReusedCellID];
    
    _refreshControl                 =  [[ODRefreshControl alloc]initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(refreshBuddyList) forControlEvents:UIControlEventValueChanged];
    
    return _tableView;
}

@end
