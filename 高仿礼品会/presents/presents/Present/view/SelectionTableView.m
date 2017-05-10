//
//  SelectionTableView.m
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SelectionTableView.h"

@interface SelectionTableView()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SelectionTableView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.scrollImage = [[UIImageView alloc] init];

        self.scrollImageArr = [[NSMutableArray alloc] initWithCapacity:0];
        [SAPNetWorkTool getWithUrl:scrollButton parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
            NSArray *array = [result[@"data"] objectForKey:@"secondary_banners"];
            for (NSDictionary *dic in array) {
                self.presentModel = [[PresentMdoel alloc] initWithDictionary:dic];
                [self.scrollImageArr addObject:self.presentModel];
            }
            
            
            [self createCollectionView];
        } fail:^(NSError *error) {
            NSLog(@"%@", error);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        [self createCollectionView];
    }return self;
}
- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = CGFLOAT_MIN;
    layout.minimumInteritemSpacing = CGFLOAT_MIN;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.height - 10, self.height);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SixPictureCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.scrollImageArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SixPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    PresentMdoel *presentModel = self.scrollImageArr[indexPath.item];
        cell.presentModel = presentModel;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
            NSString *url = @"https://event.liwushuo.com/topics/daily-lucky?campain=in_app_share&channel=ios&source=qq";
        [self.selecDelegate selectionUrl:url];

    }else if (indexPath.item == 1) {
            NSString *url = @"http://www.liwushuo.com/posts/1031070?campain=in_app_share&channel=ios&source=qq";
        [self.selecDelegate selectionUrl:url];
    
    }
    else  if (indexPath.item > 1) {
        NSString *str = [[self.scrollImageArr[indexPath.item] valueForKey:@"target_url"] substringFromIndex:37];
        [self.selecDelegate selectionId:str];
        
    }
    

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
