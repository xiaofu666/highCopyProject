//
//  SearchPresentCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SearchPresentCollectionViewCell.h"

@interface SearchPresentCollectionViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@end

@implementation SearchPresentCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self createCollectionView];
        [self addFooter];

    }return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((self.width - 20) / 2, self.height / 2.5);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.849 alpha:1.000];
    [self.collectionView registerClass:[NZCHotCollectionViewCell class] forCellWithReuseIdentifier:@"NZCHotCollectionViewCell"];
    [self addSubview:self.collectionView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.presentArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NZCHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NZCHotCollectionViewCell" forIndexPath:indexPath];
    HotModel *hotModel = self.presentArr[indexPath.item];
    cell.hotModel = hotModel;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)setPresentArr:(NSMutableArray *)presentArr {
    if (_presentArr != presentArr) {
        _presentArr = presentArr;
    }
    [self addFooter];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HotModel *hotModel = self.presentArr[indexPath.item];
    NSString *str = [NSString stringWithFormat:@"http://www.liwushuo.com/items/%@", hotModel.id];
    NSArray *arr = [NSArray arrayWithObject:hotModel.cover_image_url];
    [self.searchPDelegate passArray:arr withModel:hotModel withString:str];

}


- (void)addFooter {
    __weak typeof(self) block = self;
    
        [self.collectionView addFooterWithCallback:^{
            
            
            [SAPNetWorkTool getWithUrl:block.next_url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
                NSArray *array = result[@"data"][@"items"];
                block.next_url = result[@"data"][@"paging"][@"next_url"];
                for (NSDictionary *dic in array) {
                    HotModel *hotModel = [[HotModel alloc] initWithDictionary:dic];
                    [block.presentArr addObject:hotModel];
                    [block.imageArr addObject:dic[@"cover_image_url"]];
                }
                [block.collectionView reloadData];
                [block.collectionView footerEndRefreshing];
            } fail:^(NSError *error) {
                NSLog(@"%@", error);
            }];
            
        }];
    
}

@end
