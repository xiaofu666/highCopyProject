//
//  RecommendTableCell.m
//  DouYU
//
//  Created by admin on 15/11/1.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "RecommendTableCell.h"
#import "FourCollectionCell.h"
#import "ZWCollectionViewFlowLayout.h"
#import "ChanelData.h"
#import "PlayerController.h"
#import "Public.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface RecommendTableCell () <ZWwaterFlowDelegate>
{
     UICollectionView *_CollectionView;
    
     ZWCollectionViewFlowLayout *_flowLayout;//自定义layout
    
    int a;
}

@end

@implementation RecommendTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initContentView];
        
        
    }
    
    return self;
}


-(void)initContentView
{

    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMagrin = 5;
    _flowLayout.rowMagrin = 5;
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.colCount = 2;
    _flowLayout.degelate = self;
    
    _CollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 280*KWidth_Scale) collectionViewLayout:_flowLayout];
    
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"FourCollectionCell" bundle:nil];
    [_CollectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _CollectionView.delegate=self;
    _CollectionView.dataSource=self;
    
    _CollectionView.bounces=NO;
    _CollectionView.scrollEnabled=NO;
    _CollectionView.showsVerticalScrollIndicator=NO; //指示条
    _CollectionView.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:_CollectionView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 280*KWidth_Scale-1, screen_width, 1)];
    lineView.backgroundColor=RGBA(220, 220, 220, 1.0);
    [self addSubview:lineView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    //重用cell
    FourCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.chaneldata=self.modelArray[indexPath.item];
   
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChanelData *chanelD=self.modelArray[indexPath.item];
    
    [self.delegate TapRecommendTableCellDelegate:chanelD];
    
    NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item,chanelD.room_id);
}


#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    return (280*KWidth_Scale-3*5)/2;
}
@end
