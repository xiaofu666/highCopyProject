//
//  ArticleViewController.m
//  YueduFM
//
//  Created by StarNet on 9/26/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleTableViewCell.h"

static NSString* const kCellIdentifier = @"kCellIdentifier";

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self closeExpand];
}

- (void)reloadData:(NSArray *)data {
    [super reloadData:data];
    
    self.isEmpty = ([data count] == 0);
}

- (UIView* )emptyContainer {
    return self.tableView;
}

#pragma mark - TableViewControllerProtocol
- (UINib* )nibForExpandCell {
    if (SRV(ConfigService).config.allowDownload) {
        return [UINib nibWithNibName:@"ActionTableViewCell" bundle:nil];
    } else {
        return [UINib nibWithNibName:@"ActionTableViewCell-WithoutDownload" bundle:nil];
    }
}

- (CGFloat)heightForExpandCell {
    return 60;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDSDKArticleModelEx* model = self.tableData[indexPath.row];
    ArticleTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    [cell.moreButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [cell.moreButton bk_addEventHandler:^(id sender) {
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

@end
