//
//  MainViewController.m
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "MainViewController.h"
#import "REMenu.h"
#import "SearchViewController.h"

@interface MainViewController () {
    NSInteger       _selectMenuIndex;
}

@property (nonatomic, strong) REMenu* menu;

@end

static int const kCountPerTime = 20;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LOC(@"main");
    self.emptyString = LOC(@"main_empty_prompt");
    
    [self setupNavigationBar];
//    [self setupMenu];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [SRV(ArticleService) latestLocalArticle:^(YDSDKArticleModelEx *model) {
            YDSDKArticleModelEx* lastModel = model;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [SRV(ArticleService) fetchLatest:^(NSError *error) {
                    [self loadCurrentChannelData:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            YDSDKArticleModelEx* nowModel = [weakSelf.tableData firstObject];
                            if (error) {
                                [weakSelf showWithFailedMessage:LOC(@"main_update_failed_prompt")];
                            } else {
                                if (lastModel.aid != nowModel.aid) {
                                    [weakSelf showWithSuccessedMessage:LOC(@"main_update_newer_prompt")];
                                } else {
                                    [weakSelf showWithSuccessedMessage:LOC(@"main_update_none_prompt")];
                                }
                            }
                        });
                    }];
                }];            
            });
        }];
    }];
    
    [self.tableView.header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_menu close];
}

- (void)setupNavigationBar {
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_nav_menu.png"] action:^{
        [weakSelf presentLeftMenuViewController:nil];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_nav_search.png"] action:^{
        SearchViewController* vc = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)addFooter {
    __weak typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [SRV(ArticleService) list:(int)[weakSelf.tableData count]+kCountPerTime channel:[self currentChannel] completion:^(NSArray *array) {
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

- (void)loadCurrentChannelData:(void(^)())completion {
    [SRV(ArticleService) list:kCountPerTime channel:[self currentChannel] completion:^(NSArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData:array];
            [self.tableView.header endRefreshing];
            if ([array count] >= kCountPerTime) {
                [self addFooter];
            }
            if (completion) completion();
        });
    }];
}

- (int)currentChannel {
    return 0;// 不支持多频道
    NSArray* array = [SRV(ChannelService) channels];
    if ([array count] <= _selectMenuIndex) {
        return 1;
    } else {
        return ((YDSDKChannelModel* )array[_selectMenuIndex]).aid;
    }
}

- (void)reloadMenu {
    NSMutableArray* array = [NSMutableArray array];
    [SRV(ChannelService).channels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        YDSDKChannelModel* channel = obj;
        REMenuItem* item = [[REMenuItem alloc] initWithTitle:channel.name image:nil highlightedImage:nil action:^(REMenuItem *item) {
            UIButton* button = (UIButton*)self.navigationItem.titleView;
            [button setTitle:item.title forState:UIControlStateNormal];
            _selectMenuIndex = [_menu.items indexOfObject:item];
            [self loadCurrentChannelData:nil];
        }];
        [array addObject:item];
    }];
    
    _menu.items = array;
}

- (void)setupMenu {
    _menu = [[REMenu alloc] init];
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 3);
    _menu.shadowOpacity = 0.2f;
    _menu.shadowRadius = 10.0f;
    _menu.backgroundColor = [UIColor whiteColor];
    _menu.textColor = kThemeColor;
    _menu.textShadowColor = [UIColor clearColor];
    _menu.textOffset = CGSizeZero;
    _menu.textShadowOffset = CGSizeZero;
    _menu.highlightedTextColor = [UIColor whiteColor];
    _menu.highlightedTextShadowColor = [UIColor clearColor];
    _menu.highlightedBackgroundColor = RGBHex(@"E0E0E0");
    _menu.highlightedSeparatorColor = RGBHex(@"E0E0E0");
    _menu.font = [UIFont systemFontOfSize:14.0f];
    _menu.separatorColor = RGBHex(@"E0E0E0");
    _menu.separatorHeight = 0.5f;
    _menu.separatorOffset = CGSizeMake(15, 0);
    _menu.borderWidth = 0;
    _menu.itemHeight = 40.f;
    
    __weak typeof(self) weakSelf = self;

    [_menu bk_addObserverForKeyPath:@"isOpen" task:^(id target) {
        UIButton* button = (UIButton*)weakSelf.navigationItem.titleView;
        
        if (weakSelf.menu.isOpen) {
            [button setImage:[UIImage imageNamed:@"icon_up_arrow"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"icon_up_arrow_h"] forState:UIControlStateHighlighted];
        } else {
            [button setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"icon_down_arrow_h"] forState:UIControlStateHighlighted];
        }
    }];

    [self reloadMenu];
    [SRV(ChannelService) bk_addObserverForKeyPath:@"channels" task:^(id target) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadMenu];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
