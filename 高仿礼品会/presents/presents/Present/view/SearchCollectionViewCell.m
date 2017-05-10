//
//  SearchCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@interface SearchCollectionViewCell()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation SearchCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.guidesArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self createTableView];
    }return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PresentTableViewCell class] forCellReuseIdentifier:@"PresentTableViewCell"];
    [self addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guidesArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height / 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PresentTableViewCell"];
    cell.presentModel = self.guidesArr[indexPath.row];
    NSLog(@"%@", self.guidesArr[indexPath.row]);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchDelegate toPDetailDelegate:[self.guidesArr[indexPath.row] id] withImageUrl:[self.guidesArr[indexPath.row] cover_image_url] withTitle:[self.guidesArr[indexPath.row] title]];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)setGuidesArr:(NSMutableArray *)guidesArr {
    if (_guidesArr != guidesArr) {
        _guidesArr = guidesArr;
    }
}

@end
