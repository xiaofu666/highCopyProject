//
//  SearchViewController.m
//  YueduFM
//
//  Created by StarNet on 9/28/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar* searchBar;

@end

static int const kCountPerTime = 10;

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width-80, 25)];
    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _searchBar.delegate = self;
    _searchBar.tintColor = RGBHex(@"#A0A0A0");
    _searchBar.placeholder = LOC(@"search_prompt");
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 40, 25);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    [button bk_addEventHandler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:_searchBar], [[UIBarButtonItem alloc] initWithCustomView:button]];
    [_searchBar becomeFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self searchDidFinished];
}

- (void)searchDidFinished {
    if (_searchBar.isFirstResponder) {
        [_searchBar resignFirstResponder];
        
        if ([self.tableData count] >= kCountPerTime) {
            [self addFooter];            
        }
    }
}

- (void)addFooter {
    __weak typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [SRV(ArticleService) list:(int)[weakSelf.tableData count]+kCountPerTime filter:weakSelf.searchBar.text completion:^(NSArray *array) {
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

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [SRV(ArticleService) list:20 filter:searchText completion:^(NSArray *array) {
        [self reloadData:array];
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchDidFinished];
}

@end
