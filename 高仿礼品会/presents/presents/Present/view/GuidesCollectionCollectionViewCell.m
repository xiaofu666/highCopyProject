//
//  GuidesCollectionCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "GuidesCollectionCollectionViewCell.h"

@interface GuidesCollectionCollectionViewCell()<UITableViewDelegate, UITableViewDataSource, PresentTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) UIImageView *collectImage;
@property (nonatomic, strong) NSMutableArray *allArr;

@end

@implementation GuidesCollectionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageArr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleArr = [[NSMutableArray alloc] initWithCapacity:0];
        self.collectImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 100)];
        [self createTableView];
        [self getGuidesCollectionData];
        [self createTableView];

    }return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)getGuidesCollectionData {
    self.allArr = [[NSMutableArray alloc] initWithCapacity:0];

    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    NSString *tableName = @"guides";
    [store createTableWithName:tableName];
    [store getAllItemsFromTable:tableName];
    for (SAKeyValueItem *item in [store getAllItemsFromTable:tableName]) {
        self.presentModel = [[PresentMdoel alloc] initWithDictionary:item.itemObject];
        [self.allArr addObject:self.presentModel];

    }

    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PresentTableViewCell class] forCellReuseIdentifier:@"PresentTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PresentTableViewCell"];
    cell.presentModel = self.allArr[indexPath.row];
    cell.presentTVCDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height / 4;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [self.guidesDelegate toPDetailVCDelegate:[self.allArr[indexPath.row] valueForKey:@"url"] withImageUrl:[self.allArr[indexPath.row] cover_image_url] withTitle:[self.allArr[indexPath.row] title]];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)deleteCollect {
    [self getGuidesCollectionData];
    [self.tableView reloadData];
}
@end
