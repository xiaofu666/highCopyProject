//
//  XyGiftCollectionViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyGiftCollectionViewCell.h"

@implementation XyGiftCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linkageView = [[XyLinkageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 113)];
        self.tableViewArray = [NSMutableArray arrayWithCapacity:0];
        self.CollectionViewArray = [NSMutableArray arrayWithCapacity:0];
        [self getdataSource];
        [self addSubview:self.linkageView];
    }
    return self;
}

#pragma mark - dataSource
- (void)getdataSource {
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:kGiftURL parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        NSArray *array = result[@"data"][@"categories"];
        for (NSDictionary *dic in array) {
            XyGiftModel *model = [[XyGiftModel alloc] initWithDictionary:dic];
            [self.tableViewArray addObject:model];
        }
        _HUD.hidden = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getDataSource:self.tableViewArray];
         });
    } fail:^(NSError *error) {
    }];
}

- (void)getDataSource:(NSArray *)dataSource {
    NSMutableArray *tableName = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *collectiondata = [NSMutableArray arrayWithCapacity:0];
    for (XyGiftModel *model in self.tableViewArray) {
        [tableName addObject:model.name];
        [collectiondata addObject:model.sub];
    }
    [self.linkageView collectionViewDataSource:collectiondata];
    [self.linkageView tableViewDataSource:tableName];
    [self.linkageView initWithView];
}


@end
