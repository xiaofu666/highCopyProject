//
//  XHQFoundCarSubViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZhaoSubViewController.h"
#import "XHQFoundCarSubModel.h"
#import "XHQZhaoSubCollectionViewCell.h"

#define itemWidth 100
#define itemHeight 100

@interface XHQZhaoSubViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation XHQZhaoSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self  GetData];
        
    
    
}
- (UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    
    UINib *nib = [UINib nibWithNibName:@"XHQZhaoSubCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"NIBCELL"];
    
  
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
        
      
    self.collectionView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  
    return self.dataSource.count - 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    XHQFoundCarSubModel *model  =  self.dataSource[section];
     NSArray *array = model.cris;
    
     return array.count ;
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHQZhaoSubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NIBCELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    XHQFoundCarSubModel *model  = [self.dataSource objectAtIndex:indexPath.section];
  
    NSArray *array = model.cris;
    NSDictionary *dict = array[indexPath.row];
    cell.label.text = dict[@"name"];
   
    return cell;
}
#pragma mark 设置头尾视图的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(XHQ_SCRWIDTH, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHQFoundCarSubModel *model  = [self.dataSource objectAtIndex:indexPath.section];
    
    NSArray *array = model.cris;
    NSDictionary *dict = array[indexPath.row];
    NSString *str = dict[@"name"];
    [XHQAuxiliary alertWithTitle:@"您的选择如下" message:str button:0 done:nil];
    
}
#pragma mark 返回头尾视图

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
    
  for(UIView *subview in reusableView.subviews)
  {
      [subview removeFromSuperview];
  }
    
 
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XHQ_SCRWIDTH, 50)];
    
    XHQFoundCarSubModel *model = self.dataSource[indexPath.section];
    
    label.text = model.name;
    
    [reusableView addSubview:label];
  
   
    return reusableView;
    
}


- (void)GetData
{
    
    [self request:@"POST" url:WEBCARS_GETALLBRANDLIST_SUB para:nil];
    
}
- (void)parserData:(id)data
{
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSArray *array = dict[@"criterion"];
    for (NSDictionary *dict in array)
    {
        XHQFoundCarSubModel *model = [[XHQFoundCarSubModel alloc]initWithDictionary:dict error:nil];
        [self.dataSource addObject:model];
    }
   
    [self.collectionView reloadData];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com