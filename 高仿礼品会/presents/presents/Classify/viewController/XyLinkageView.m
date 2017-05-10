//
//  XyLinkageView.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 Xy. All rights reserved.
//

#import "XyLinkageView.h"
#import "XyLinkageTableViewCell.h"
#import "XyLinkageCollectionViewCell.h"

static BOOL isGetWhatWay = YES;

@interface XyLinkageView ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *titleName;
@property (strong, nonatomic) NSArray *collectionDataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSIndexPath *indexPath;


@end

@implementation XyLinkageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

/**
 *  创建刷新数据
 */
- (void)initWithView {
    [self addSubview:self.collectionView];
    [self addSubview:self.tableView];
}

- (void)tableViewDataSource:(NSArray *)dataSource {
    self.titleName = [NSArray arrayWithArray:dataSource];
}

- (void)collectionViewDataSource:(NSArray *)dataSource {
    self.collectionDataSource = [NSArray arrayWithArray:dataSource];
}



#pragma mark - createTableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width / 4, self.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPaths animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_tableView registerClass:[XyLinkageTableViewCell class] forCellReuseIdentifier:@"XyLinkageTableViewCellIdentifier"];
    }
    return _tableView;
}

#pragma mark - tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XyLinkageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XyLinkageTableViewCellIdentifier"];
    if (indexPath.row < self.titleName.count) {
        [cell setTitleName:self.titleName[indexPath.row]];
    }
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleName.count;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.width / 8;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    isGetWhatWay = NO;
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        isGetWhatWay = YES;
    }
}



#pragma mark - collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.width / 4, XHIGHT * 90);
        flowLayout.sectionInset = UIEdgeInsetsMake(10,0, 0, 0);
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = CGFLOAT_MIN;
        flowLayout.headerReferenceSize = CGSizeMake(self.width, 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.width / 4 , 0, self.width / 4 * 3, self.height) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[XyLinkageCollectionViewCell class] forCellWithReuseIdentifier:@"XyLinkageCollectionViewCellIdentifier"];
        //参数说明:1 .要注册的视图类型
        // 2.注册的视图类型(头/尾)
        // 3.从用标识
#warning 注册头视图
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterCollectionReusableView"];
    }
    return _collectionView;
}

#pragma mark - CollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.titleName.count) {
        return self.titleName.count;
    }
    return 0;
}


#pragma mark - collectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XyLinkageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XyLinkageCollectionViewCellIdentifier" forIndexPath:indexPath];
    
 
    if (indexPath.section < self.collectionDataSource.count) {
        XyGiftCollectionModel *model = self.collectionDataSource[indexPath.section][indexPath.item];
        [cell setGiftModel:model];
    }
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionDataSource[section] count];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        if (isGetWhatWay == YES) {
            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
            CGPoint pInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
            // 获取这一点的indexPath
            NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
            if (indexPathNow.section == 0) {
                //获取所有collectionView的头视图(也可用item)
                NSArray *array = [self.collectionView indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
                if ([[array firstObject] section] == 0 || [[array firstObject] section] == 1) {
                    NSIndexPath *tabIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView selectRowAtIndexPath:tabIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    [self.tableView scrollToRowAtIndexPath:tabIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                return;
            }
            NSIndexPath *tabIndexPath = [NSIndexPath indexPathForRow:indexPathNow.section inSection:0];
            [self.tableView selectRowAtIndexPath:tabIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.tableView scrollToRowAtIndexPath:tabIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XyGiftCollectionModel *model = self.collectionDataSource[indexPath.section][indexPath.item];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"vid" object:model];
}




#pragma mark 返回头视图 / 尾视图 通过kind判断

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
        [reusableView removeAllSubviews];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(reusableView.width / 2 - 40, 0, 80, reusableView.height)];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, reusableView.height / 2, reusableView.width - 10, 0.5)];
        view.backgroundColor = [UIColor lightGrayColor];
        [reusableView addSubview:view];
        label.text = self.titleName[indexPath.section];
        [reusableView addSubview:label];
        return reusableView;
    }else {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterCollectionReusableView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        return reusableView;
    }
    return nil;
}


#pragma mark 返回头视图的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(self.frame.size.width, 10);
}

#pragma mark 返回尾视图的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
