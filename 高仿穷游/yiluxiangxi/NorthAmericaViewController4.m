//
//  NorthAmericaViewController4.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "NorthAmericaViewController4.h"
#import "SleeveImageCell.h"
#import "Path.h"
#import "RequestModel.h"
#import "UIImageView+WebCache.h"
#import "SleeveDisCountViewController.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface NorthAmericaViewController4 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,sendRequestInfo>
{
    NSMutableArray* dataSource;
    UICollectionView* _collectionView;
}
@end

@implementation NorthAmericaViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource=[[NSMutableArray alloc]init];
    //创建一个网格布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-140) collectionViewLayout:layout];
    //指定代理
    _collectionView.delegate = self;
    //指定数据源代理
    _collectionView.dataSource = self;
    //添加到当前视图上显示
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[SleeveImageCell class] forCellWithReuseIdentifier:@"SleeveImageCell"];
    [self reloadDataSource];
}

-(void)reloadDataSource{
    RequestModel* request=[[RequestModel alloc]init];
    request.path=NORTHAMERICA;
    request.delegate=self;
    [request startRequestInfo];
}

-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray* array=message[@"data"][0][@"guides"];
    //NSLog(@"%@",array);
    [dataSource addObjectsFromArray:array];
    [_collectionView reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//返回collectionView某一组总共显示的Item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count;
}
//创建或刷新cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* sleeveId=@"SleeveImageCell";
    SleeveImageCell* sleeveCell=[collectionView dequeueReusableCellWithReuseIdentifier:sleeveId forIndexPath:indexPath];
    NSString* string=dataSource[indexPath.row][@"cover"];
    NSString* imageStr=[NSString stringWithFormat:@"%@/260_390.jpg?cover_updatetime=%@",string,dataSource[indexPath.row][@"cover_updatetime"]];
    [sleeveCell.recImageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
    return sleeveCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SleeveDisCountViewController* sleDis=[[SleeveDisCountViewController alloc]init];
    sleDis.sleeveID=dataSource[indexPath.row][@"guide_id"];
    [self.navigationController pushViewController:sleDis animated:YES];
}
//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120*(WIDTH/375.0), 180*(HEIGHT/667.0));
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(WIDTH/375.0), 0, 2.5*(WIDTH/375.0));
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(HEIGHT/667.0);
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(WIDTH/375.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
