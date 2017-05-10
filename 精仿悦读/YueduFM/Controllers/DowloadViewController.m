//
//  DowloadViewController.m
//  YueduFM
//
//  Created by StarNet on 9/26/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "DowloadViewController.h"
#import "DownloadTableViewCell.h"

static int const kCountPerTime = 20;

typedef NS_ENUM(int, DownloadType) {
    DownloadTypeDone = 0,
    DownloadTypeDoing,
};

static NSString* const kDownloadCellIdentifier = @"kDownloadCellIdentifier";

@interface DowloadViewController () {
    UISegmentedControl* _segmentedControl;
}

@end

@implementation DowloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    self.emptyString = LOC(@"download_empty_prompt");
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_nav_delete.png"] action:^{
        
        if ([weakSelf isDownloadTypeDone]) {
            UIAlertView* alert = [UIAlertView bk_alertViewWithTitle:nil message:LOC(@"download_clear_prompt")];
            [alert bk_addButtonWithTitle:LOC(@"clear") handler:^{
                [SRV(ArticleService) deleteAllDownloaded:^{
                    [weakSelf load];
                    [weakSelf showWithSuccessedMessage:LOC(@"clear_successed")];
                }];
            }];
            
            [alert bk_addButtonWithTitle:LOC(@"cancel") handler:nil];
            [alert show];
        } else {
            UIAlertView* alert = [UIAlertView bk_alertViewWithTitle:nil message:LOC(@"download_clear_prompt")];
            [alert bk_addButtonWithTitle:LOC(@"clear") handler:^{
                [SRV(DownloadService) deleteAllTask:^{
                    [weakSelf load];
                    [weakSelf showWithSuccessedMessage:LOC(@"clear_successed")];
                }];
            }];
            
            [alert bk_addButtonWithTitle:LOC(@"cancel") handler:nil];
            [alert show];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSeriviceDidChangedNotification:) name:DownloadSeriviceDidChangedNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:kDownloadCellIdentifier];
    
    [SRV(DownloadService) state:^(BOOL downloading) {
        _segmentedControl.selectedSegmentIndex = downloading?DownloadTypeDoing:DownloadTypeDone;
        [self load];
    }];
}

- (void)downloadSeriviceDidChangedNotification:(NSNotification* )notification {
    [self load];
}

- (BOOL)isDownloadTypeDone {
    return _segmentedControl.selectedSegmentIndex == DownloadTypeDone;
}

- (void)load {
    if ([self isDownloadTypeDone]) {
        [SRV(ArticleService) listDownloaded:kCountPerTime completion:^(NSArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData:array];
                [self.tableView.header endRefreshing];
                if ([array count] >= kCountPerTime) {
                    [self addFooter];
                }
            });
        }];
    } else {
        [SRV(DownloadService) list:^(NSArray *tasks) {
            [self reloadData:tasks];
        }];
    }
}

- (void)addFooter {
    __weak typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf isDownloadTypeDone]) {
            [SRV(ArticleService) listDownloaded:(int)[weakSelf.tableData count]+kCountPerTime completion:^(NSArray *array) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf reloadData:array];
                    [weakSelf.tableView.footer endRefreshing];
                    
                    if ([weakSelf.tableData count] == [array count]) {
                        weakSelf.tableView.footer = nil;
                    }
                });
            }];
        }
    }];
}

- (void)setupNavigationBar {
    __weak typeof(self) weakSelf = self;
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[LOC(@"download_done"), LOC(@"download_doing")]];
    [_segmentedControl bk_addEventHandler:^(id sender) {
        [weakSelf load];
    } forControlEvents:UIControlEventValueChanged];
    _segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segmentedControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UINib* )nibForExpandCell {
    return [UINib nibWithNibName:@"DownloadActionTableViewCell" bundle:nil];
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isDownloadTypeDone] && [[self.tableData firstObject] isKindOfClass:[YDSDKArticleModel class]]) {
        return [super cellForRowAtIndexPath:indexPath];
    } else {
        NSURLSessionTask* task = self.tableData[indexPath.row];
        DownloadTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:kDownloadCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.task = task;        
        return cell;
    }
}

@end
