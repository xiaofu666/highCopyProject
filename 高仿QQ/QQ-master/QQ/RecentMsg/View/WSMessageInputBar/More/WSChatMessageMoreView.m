//
//  WSChatMessageMoreView.m
//  QQ
//
//  Created by weida on 15/9/24.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatMessageMoreView.h"
#import "PureLayout.h"
#import "WSChatMessageMoreCollectionCell.h"
#import "UIResponder+Router.h"

//自己的高度
#define kHeightMoreView      (170)

//可重用ID
#define kReuseID             (@"unique")

#define kBottomCollectionView (24)

#define kUnSelectedColorPageControl   ([UIColor colorWithRed:0.604 green:0.608 blue:0.616 alpha:1])
#define kSelectedColorPageControl     ([UIColor colorWithRed:0.380 green:0.416 blue:0.463 alpha:1])

@interface WSChatMessageMoreView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mCollectionView;
    
    UIPageControl    *mPageControl;
}

/**
 *  @brief  数据源
 */
@property(nonatomic,strong)NSArray *DataSource;
@end

@implementation WSChatMessageMoreView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        [layout setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/4-10, (kHeightMoreView-kBottomCollectionView)/2-14)];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.sectionInset = UIEdgeInsetsMake(4, 5,4, 5);
        
        mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        mCollectionView.pagingEnabled = YES;
        mCollectionView.showsHorizontalScrollIndicator = NO;
        mCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        mCollectionView.backgroundColor = [UIColor clearColor];
        mCollectionView.dataSource = self;
        mCollectionView.delegate   = self;
        [mCollectionView registerClass:[WSChatMessageMoreCollectionCell class] forCellWithReuseIdentifier:kReuseID];
        
        [self addSubview:mCollectionView];
        UIEdgeInsets inset = UIEdgeInsetsMake(0, 0,kBottomCollectionView, 0);
        
        [mCollectionView autoPinEdgesToSuperviewEdgesWithInsets:inset];
        
        
        mPageControl = [[UIPageControl alloc]initForAutoLayout];
        mPageControl.numberOfPages = 2;
        mPageControl.userInteractionEnabled = NO;
        mPageControl.backgroundColor = [UIColor clearColor];
        mPageControl.currentPage  = 0;
        mPageControl.currentPageIndicatorTintColor = kSelectedColorPageControl;
        mPageControl.pageIndicatorTintColor  = kUnSelectedColorPageControl;
        
        [self addSubview:mPageControl];
        
        [mPageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [mPageControl  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-2];
        
    }
    return self;
}


#pragma mark - Collection Delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatMessageMoreCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseID forIndexPath:indexPath];
    cell.model = self.DataSource[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0://选择图片
            [self routerEventWithType:EventChatMoreViewPickerImage userInfo:nil];
            break;
            
        default:
            break;
    }
   
    NSLog(@"选中了：%ld",(long)indexPath.row);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    mPageControl.currentPage = (scrollView.contentOffset.x)/scrollView.bounds.size.width;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kHeightMoreView);
}

-(NSArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WSMoreImageTitles" ofType:@"plist"];;
    
    _DataSource = [NSArray arrayWithContentsOfFile:filePath];
    
    return _DataSource;
}

@end
