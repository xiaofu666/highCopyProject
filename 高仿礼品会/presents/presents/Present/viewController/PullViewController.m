//
//  PullViewController.m
//  presents
//
//  Created by dapeng on 16/1/11.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PullViewController.h"
#import <UIKit/UILongPressGestureRecognizer.h>

static NSString *cellIdentifier = @"CoclumnCollectionViewCell";
static NSString *headOne = @"ColumnReusableViewOne";
static NSString *headTwo = @"ColumnReusableViewTwo";
@interface PullViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DeleteDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SAKeyValueStore  *store;
@property (nonatomic, strong) SAKeyValueStore  *optionalStore;
@property (nonatomic, strong) NSMutableArray   *idArray;
@property (nonatomic, strong) NSMutableArray   *allArray;
@property (nonatomic, strong) NSMutableArray   *allOptional;
@property (nonatomic,assign ) NSIndexPath      *indext;
@property (nonatomic,strong ) NSIndexPath      *end;

@end

@implementation PullViewController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedArr = [[NSMutableArray alloc] initWithCapacity:0];
        self.idArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.allArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.optionalArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.allOptional = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
        [self.store createTableWithName:@"guide"];
        
        for (SAKeyValueItem *item in [self.store getAllItemsFromTable:@"guide"]) {
            [self.selectedArr addObject:[item.itemObject valueForKey:@"name"]];
            [self.idArray addObject:[item.itemObject valueForKey:@"id"]];
            [self.allArray addObject:item.itemObject];
        }
        
        self.optionalStore = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
        [self.optionalStore createTableWithName:@"optional"];
        for (SAKeyValueItem *item in [self.optionalStore getAllItemsFromTable:@"optional"]) {
            [self.optionalArray addObject:[item.itemObject valueForKey:@"name"]];
            [self.allOptional addObject:item.itemObject];
        }
        [self configCollection];
    }
    return self;
}



#pragma mark --------------------collectionView ---------------------
-(void)configCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self addSubview:self.collectionView];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
//    [self.collectionView addGestureRecognizer:pan];
    [self.collectionView registerClass:[PullCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[PullCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne];
    [self.collectionView registerClass:[PullCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo];
    
    [self.collectionView reloadData];
}
#pragma mark ----------------- 排序 ---------------------
- (void)handleLongGesture:(UILongPressGestureRecognizer *)gesture {
    
    
    //    NSLog(@"FHGjgjlkk");
    //    NSLog(@"%ld",gesture.state);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            
            self.indext = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            
            NSLog(@"***********%ld",self.indext.row);
            
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:self.indext];
            break;
        case UIGestureRecognizerStateChanged:
            
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            
            break;
        case UIGestureRecognizerStateEnded:

            [self.collectionView endInteractiveMovement];
            self.end = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            NSLog(@"***********%ld",self.end.row);
            
            [self.collectionView endInteractiveMovement];
            self.end = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
        
            if (self.indext.row > self.end.row) {
                [self.selectedArr insertObject:self.selectedArr[self.indext.row] atIndex:self.end.row];
                [self.selectedArr removeObjectAtIndex:self.indext.row + 1];
                
                [self.allArray insertObject:self.allArray[self.indext.row] atIndex:self.end.row];
                [self.allArray removeObjectAtIndex:self.indext.row + 1];
 
            }else if (self.indext.row < self.end.row){
                [self.selectedArr insertObject:self.selectedArr[self.indext.row] atIndex:self.end.row + 1];
                [self.selectedArr removeObjectAtIndex:self.indext.row];
                
                [self.allArray insertObject:self.allArray[self.indext.row] atIndex:self.end.row + 1];
                [self.allArray removeObjectAtIndex:self.indext.row];
            }else {
                [self.selectedArr insertObject:self.selectedArr[self.indext.row] atIndex:self.end.row + 1];
                [self.selectedArr removeObjectAtIndex:self.indext.row + 1];
                
                [self.allArray insertObject:self.allArray[self.indext.row] atIndex:self.end.row + 1];
                [self.allArray removeObjectAtIndex:self.indext.row + 1];
            }
            
            
            
            self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
            [self.store clearTable:@"guide"];
            for (NSDictionary *dic in self.allArray) {
            
                [self.store putObject:dic withId:dic[@"name"] intoTable:@"guide"];
        }
            
            [self.store createTableWithName:@"guide"];
            self.selectedArr = [[NSMutableArray alloc] initWithCapacity:0];
            self.idArray = [[NSMutableArray alloc] initWithCapacity:0];
            self.allArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (SAKeyValueItem *item in [self.store getAllItemsFromTable:@"guide"]) {
                [self.selectedArr addObject:[item.itemObject valueForKey:@"name"]];
                [self.idArray addObject:[item.itemObject valueForKey:@"id"]];
                [self.allArray addObject:item.itemObject];
            }
            
            [self.collectionView reloadData];
          
            break;
            
        default:
            [self.collectionView cancelInteractiveMovement];
            
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}
#pragma mark ----------------- 删除 ---------------------
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath{
    
    
    //数据整理
    [self.optionalArray insertObject:[self.selectedArr objectAtIndex:indexPath.row] atIndex:0];
    [self.allOptional insertObject:[self.allArray objectAtIndex:indexPath.row] atIndex:0];

    [self.selectedArr removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    [self.store deleteObjectById:[self.allArray[indexPath.row] valueForKey:@"name"] fromTable:@"guide"];
    [self.optionalStore putObject:self.allArray[indexPath.row] withId:[self.allArray[indexPath.row] valueForKey:@"name"] intoTable:@"optional"];
    
    [self.allArray removeObjectAtIndex:indexPath.row];
    
    
    //删除之后更新collectionView上对应cell的indexPath
    for (NSInteger i = 0; i < self.selectedArr.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        PullCollectionViewCell *cell = (PullCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
        [self.collectionView reloadData];

    }
}
#pragma mark ----------------- insert ---------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    NSString *channelTitle = self.selectedArr[indexPath.item];
    NSLog(@"%@", channelTitle);
    [self.pullDelegate switchChannels:channelTitle];
    }
    else if (indexPath.section == 1) {
        self.lastIsHidden = YES;

        PullCollectionViewCell *endCell = (PullCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        endCell.titles.hidden = YES;
        
        [self.selectedArr addObject:[self.optionalArray objectAtIndex:indexPath.row]];
        [self.store putObject:self.allOptional[indexPath.row] withId:[self.allOptional[indexPath.row] valueForKey:@"name"] intoTable:@"guide"];//添加到数据库
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];

        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArr.count-1 inSection:0];

        
        typeof(self) __weak weakSelf = self;
        [UIView animateWithDuration:0.7 animations:^{
        } completion:^(BOOL finished) {
            PullCollectionViewCell *endCell = (PullCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:toIndexPath];
            endCell.titles.hidden = NO;
            
            weakSelf.lastIsHidden = NO;
            [weakSelf.optionalArray removeObjectAtIndex:indexPath.row];
            [self.optionalStore deleteObjectById:[self.allOptional[indexPath.row] valueForKey:@"name"] fromTable:@"optional"];//从数据库中删除
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [weakSelf.allArray addObject:self.allOptional[indexPath.row]];
            [weakSelf.allOptional removeObjectAtIndex:indexPath.row];

        }];
        
    }
}

#pragma mark ----------------- item(样式) ---------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_SIZE.width - (5 * SPACE)) / 4.0, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_SIZE.width, 40.0);
    }
    else{
        return CGSizeMake(SCREEN_SIZE.width, 30.0);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_SIZE.width, 0.0);
}

#pragma mark ----------------- collectionView(datasouce) ---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.isSort) {
        return 1;
    }
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.selectedArr.count;
    }
    else{
        return self.optionalArray.count;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PullCollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne forIndexPath:indexPath];
            reusableView.buttonHidden = NO;
            reusableView.clickButton.selected = self.isSort;
            reusableView.backgroundColor = RGB(240, 240, 240, 1);
            typeof(self) __weak weakSelf = self;
            [reusableView clickWithBlock:^(ButtonState state) {
                //排序删除
                if (state == StateSortDelete) {
                    weakSelf.isSort = YES;
                }
                //完成
                else{
                    
                    for (UIPanGestureRecognizer *pan in self.collectionView.gestureRecognizers) {
                        [self.collectionView removeGestureRecognizer:pan];
                    }
                    weakSelf.isSort = NO;
                }
                [weakSelf.collectionView reloadData];
            }];
            reusableView.titleLabel.text = @"切换频道";
            
        }else{
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo forIndexPath:indexPath];
            reusableView.buttonHidden = YES;
            reusableView.backgroundColor = RGB(240, 240, 240, 1);
            reusableView.titleLabel.text = @"点击添加更多频道";
        }
    }
    return (UICollectionReusableView *)reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PullCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        [cell passCell:self.selectedArr withIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.deleteButton.hidden = YES;
        }else {
            cell.deleteDelegate = self;
            cell.deleteButton.hidden = !self.isSort;
            if (self.isSort) {

                
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
                [self.collectionView addGestureRecognizer:pan];
             
            }
        }
        
    }else{
        [cell passCell:self.optionalArray withIndexPath:indexPath];
        cell.deleteButton.hidden = YES;
    }
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {

    
}

- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
