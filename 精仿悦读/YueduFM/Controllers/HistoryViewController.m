//
//  HistoryViewController.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

static int const kCountPerTime = 20;


@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"history");
    self.emptyString = LOC(@"history_empty_prompt");
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_nav_delete.png"] action:^{
        UIAlertView* alert = [UIAlertView bk_alertViewWithTitle:nil message:LOC(@"history_clear_prompt")];
        [alert bk_addButtonWithTitle:LOC(@"clear") handler:^{
            [SRV(ArticleService) deleteAllPlayed:^{
                [weakSelf load];
                [weakSelf showWithSuccessedMessage:LOC(@"clear_successed")];
            }];
        }];
        
        [alert bk_addButtonWithTitle:LOC(@"cancel") handler:nil];
        [alert show];
    }];
        
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf load];
    }];
    
    [self load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)load {
    [SRV(ArticleService) listPlayed:kCountPerTime completion:^(NSArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData:array];
            [self.tableView.header endRefreshing];
            if ([array count] >= kCountPerTime) {
                [self addFooter];
            }
        });
    }];
}

- (void)addFooter {
    __weak typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [SRV(ArticleService) listPlayed:(int)[weakSelf.tableData count]+kCountPerTime completion:^(NSArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf reloadData:array];
                [weakSelf.tableView.footer endRefreshing];
                
                if ([weakSelf.tableData count] == [array count]) {
                    weakSelf.tableView.footer = nil;
                }
            });
        }];
    }];
}

@end
