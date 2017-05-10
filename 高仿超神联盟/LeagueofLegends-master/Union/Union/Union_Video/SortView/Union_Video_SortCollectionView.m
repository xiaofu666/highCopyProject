//
//  Union_Video_SortCollectionView.m
//  Union
//
//  Created by lanou3g on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Union_Video_SortCollectionView.h"

#import "SortCollectionViewCell.h"

#import "Networking.h"

#import "PCH.h"

#import "SortModel.h"

#import "UIImageView+WebCache.h"

#import "SortCollectionReusableView.h"
@interface Union_Video_SortCollectionView ()

@property (nonatomic ,retain) NSMutableArray *tempArray;//数据原数组

@property (nonatomic ,retain) NSMutableArray *headerArray;//区头数据源

@property (nonatomic ,retain) GearPowered *gearPowered;//齿轮刷新

@end


@implementation Union_Video_SortCollectionView
-(void)dealloc{

    [_tempArray release];

    [_headerArray release];
    
    [_gearPowered release];
    
    [super dealloc];



}
//初始化

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
      
//        设置背景色
        
        self.backgroundColor = [UIColor whiteColor];
        
//        设置代理
        
        self.delegate = self;
        
        self.dataSource = self;
        
//        注册CELL
        
        [self registerClass:[SortCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        
//        注册区头
        
        [self registerClass:[SortCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
//     初始化设置齿轮刷新
        
        _gearPowered = [[GearPowered alloc]init];
        
        _gearPowered.scrollView = self;//传入要刷新的滑动视图 (tableView 和 collectionview 都继承自scrollView)
        
        _gearPowered.isAuxiliaryGear = YES;//是否显示辅助齿轮样式
        
        _gearPowered.delegate = self;//设置代理
        
        _gearPowered.url = [NSURL URLWithString:kUnion_Video_SortURL];//设置上拉刷新

//        加载数据
        
        [self loadData];
        
    
    }

    return self;

}

-(void)loadData{

//请求数据
    
    __block Union_Video_SortCollectionView *Self = self;
    
    [[Networking shareNetworking] networkingGetWithURL:kUnion_Video_SortURL Block:^(id object) {
        [Self NSJSONSerializationWithData:object];
        
    }];

}

#pragma mark ---LazyLoading

-(NSMutableArray *)tempArray{
    
    if (_tempArray == nil) {
        
        _tempArray = [[NSMutableArray alloc]init];
        
    }
    
    return _tempArray;
    
}

//懒加载

-(NSMutableArray *)headerArray{
    if (_headerArray == nil) {
        _headerArray = [[NSMutableArray alloc]init];
    }
    return _headerArray;

}

-(void)NSJSONSerializationWithData:(NSData *)data{

//    解析前清空数据原数组
    
    [self.tempArray removeAllObjects];
    
    [self.headerArray removeAllObjects];
    
           NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

//    遍历取出所有字典
    
    for (NSDictionary *dic in array) {
        
//      在字典中用key取出subCategory里的值
        NSMutableArray *subArray = [dic valueForKey:@"subCategory"];
        
        [self.headerArray addObject:[dic valueForKey:@"name"]];
        
        NSMutableArray *itemArray = [NSMutableArray array];
        
        for (NSDictionary *subDic in subArray) {
            
            SortModel *model = [[SortModel alloc]init];
            
            [model setValuesForKeysWithDictionary:subDic];
            
            [itemArray addObject:model];
        }
        
//        添加到数据原数组中
        
        [self.tempArray addObject:itemArray];
        
    }

//刷新数据
    
    [self reloadData];
}

#pragma mark ------UICollectionViewDataSource , UICollectionViewDelegate  方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.tempArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.tempArray[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.sortModel = self.tempArray[indexPath.section][indexPath.row];
    
    NSURL *picUrl = [NSURL URLWithString:[self.tempArray[indexPath.section][indexPath.row] icon]];
        
    [cell.imageView sd_setImageWithURL:picUrl];
        

    return cell;
}

//设置页眉的尺寸

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        
        CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 70);
        
        return size;
    }else{
    
      CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 20);
        
        return size;
    
    }
}

//为collection view添加一个补充视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SortCollectionReusableView *VRC = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    //判断
    
    if (indexPath.section == 0 ) {
        
        __block Union_Video_SortCollectionView *Self = self;
        
        VRC.videoSearchBlock = ^(NSString *videoName){
            
            Self.videoSearchBlock(videoName);
            
        };
        
        //隐藏
        
        VRC.textField.hidden = NO;
        
        VRC.button.hidden = NO;
    }
    else{
        
        VRC.textField.hidden = YES;
        
        VRC.button.hidden = YES;
    }
    
    VRC.myHeader.text = self.headerArray[indexPath.section];
    
    return VRC;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //调用齿轮刷新的滑动事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //调用齿轮刷新的拖动结束事件<必须调用 否则无法事件上下拉刷新>
    
    [self.gearPowered scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
}

#pragma mark ---GearPoweredDelegate

-(void)didLoadData:(NSData *)data{
    
    //下拉刷新请求返回数据代理方法 data为服务器返回的数据
    
    //调用数据解析方法
    
    [self NSJSONSerializationWithData:data];
    
}

//给一个点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SortModel *model = self.tempArray[indexPath.section][indexPath.row];
    
    self.block(model.tag , model.name);

}





















@end
