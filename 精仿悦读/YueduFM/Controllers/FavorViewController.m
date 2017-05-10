//
//  FavorViewController.m
//  YueduFM
//
//  Created by StarNet on 9/26/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "FavorViewController.h"

@interface FavorViewController ()

@end

static int const kCountPerTime = 20;

@implementation FavorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"menu_favor");
    self.emptyString = LOC(@"favor_empty_prompt");
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_nav_delete.png"] action:^{
            UIAlertView* alert = [UIAlertView bk_alertViewWithTitle:nil message:LOC(@"favor_clear_prompt")];
            [alert bk_addButtonWithTitle:LOC(@"clear") handler:^{
                [SRV(ArticleService) deleteAllFavored:^{
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

- (void)load {
    [SRV(ArticleService) listFavored:kCountPerTime completion:^(NSArray *array) {
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
        [SRV(ArticleService) listFavored:(int)[weakSelf.tableData count]+kCountPerTime completion:^(NSArray *array) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UINib* )nibForExpandCell {
    if (SRV(ConfigService).config.allowDownload) {
        return [UINib nibWithNibName:@"FavorActionTableViewCell" bundle:nil];
    } else {
        return [UINib nibWithNibName:@"FavorActionTableViewCell-WithoutDownload" bundle:nil];
    }
}

@end
