//
//  WRRecommendViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRRecommendViewController.h"
#import "RcmdImageCell.h"
#import "RcmSmallCell.h"
#import "RcmLabelCell.h"
#import "RcmLikeTabCell.h"
#import "Path.h"
#import "RequestModel.h"
#import "UIImageView+WebCache.h"
#import "WRRecHeaderView.h"
#import "WRRecFooterView.h"
#import "ADheadView.h"
#import "WRRecWebViewController.h"
#import "SleeveViewController.h"
#import "WRAllSpecialViewController.h"
#import "WRDiscountViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
//推荐模块
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)

@interface WRRecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,sendRequestInfo,ADheadViewDelegate,WRRecFooterViewDelegate>
{
    NSMutableArray* dataSource;
    UICollectionView *_collectionView;
    NSMutableArray* slideArray;
    NSMutableArray* slideUrlArr;
    int currentPage;
    //下拉刷新
    BOOL isRefreshing;
    //上拉加载
    BOOL isLoading;
}
@end

@implementation WRRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2015-11-06 下午2.31.17.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"说走就走";
    currentPage=1;
    isRefreshing=NO;
    isLoading=NO;
    dataSource=[[NSMutableArray alloc]initWithCapacity:3];
    slideArray=[[NSMutableArray alloc]init];
    slideUrlArr=[[NSMutableArray alloc]init];
    [dataSource addObject:@[]];
    [dataSource addObject:@[]];
    [dataSource addObject:@[]];
    [self createCollectionView];
    [self reloadDataSource];
    [self LoadingAndRefreshing];
}

-(void)reloadDataSource{
    //NSLog(@"%lu",(unsigned long)dataSource.count);
    RequestModel* request1=[[RequestModel alloc]init];
    request1.path=OTHER;
    request1.delegate=self;
    [request1 startRequestInfo];
    
    RequestModel* request2=[[RequestModel alloc]init];
    NSString* travelnote=[NSString stringWithFormat:TRAVELNOTE1,currentPage,TRAVELONTE2];
    
    request2.path=travelnote;
    request2.delegate=self;
    [request2 startRequestInfo];
}

-(void)sendMessage:(id)message andPath:(NSString *)path{
    //[dataSource addObjectsFromArray:@[@"1",@"2",@"3"]];
    if ([path isEqualToString:OTHER]) {
        NSArray* array1=message[@"data"][@"subject"];
        NSArray* arrTow1=message[@"data"][@"discount_subject"];
        NSMutableArray* array2=[[NSMutableArray alloc]init];
        [array2 addObject:arrTow1[0]];
        NSArray* arrTow2=message[@"data"][@"discount"];
        for (NSDictionary* dic in arrTow2) {
            [array2 addObject:dic];
        }
        [dataSource replaceObjectAtIndex:0 withObject:array1];
        [dataSource replaceObjectAtIndex:1 withObject:array2];
        
        if (slideArray.count!=0) {
            [slideArray removeAllObjects];
        }
        
        NSArray* sliArr=message[@"data"][@"slide"];
        for (NSDictionary* dic in sliArr) {
            [slideArray addObject:dic[@"photo"]];
            [slideUrlArr addObject:dic[@"url"]];
        }
    }else{
        NSArray* array3=message[@"data"];
        //NSLog(@"%@",array3);
        NSMutableArray* mutArr=[[NSMutableArray alloc]init];
        //NSLog(@"%lu",(unsigned long)[dataSource[2] count]);
        for (NSDictionary* dic in dataSource[2]) {
            [mutArr addObject:dic];
        }
        for (NSDictionary* dic in array3) {
            [mutArr addObject:dic];
        }
        [dataSource replaceObjectAtIndex:2 withObject:mutArr];
        //[dataSource[2] addObject:array3];
    }
    if ([dataSource[0] count]!=0) {
        [_collectionView reloadData];
    }
}

-(void)createCollectionView{
    
    
    //创建一个网格布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    //指定代理
    _collectionView.delegate = self;
    //指定数据源代理
    _collectionView.dataSource = self;
    //添加到当前视图上显示
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    
    [_collectionView registerClass:[RcmdImageCell class] forCellWithReuseIdentifier:@"RcmdImageCell"];
    [_collectionView registerClass:[RcmSmallCell class] forCellWithReuseIdentifier:@"RcmSmallCell"];
    [_collectionView registerClass:[RcmLabelCell class] forCellWithReuseIdentifier:@"RcmLabelCell"];
    [_collectionView registerClass:[RcmLikeTabCell class] forCellWithReuseIdentifier:@"RcmLikeTabCell"];
    
    [_collectionView registerClass:[ADheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ADheadView"];
    [_collectionView registerClass:[WRRecHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WRRecHeaderView"];
    [_collectionView registerClass:[WRRecFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WRRecFooterView"];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([dataSource[0] count]==0) {
        return 0;
    }else{
        return dataSource.count;
    }
    
}

//返回collectionView某一组总共显示的Item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"section%ld",(long)section);
//    NSLog(@"%lu",(unsigned long)[dataSource[section] count]);
    NSMutableArray *sectionArray = dataSource[section];
    return [sectionArray count];
}
//创建或刷新cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //subject*****************array1
            static NSString* cellIDImage=@"RcmdImageCell";
            RcmdImageCell* rcmdImageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDImage forIndexPath:indexPath];
            if ([dataSource[0] count]!=0) {
                NSString* imagePath=dataSource[indexPath.section][indexPath.row][@"photo"];
                [rcmdImageCell.recImageView setImageWithURL:[NSURL URLWithString:imagePath]];
            }
            return rcmdImageCell;
        }else{
            static NSString* cellIDSmall=@"RcmSmallCell";
            RcmSmallCell* rcmSmallCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDSmall forIndexPath:indexPath];
            if ([dataSource[0] count]!=0) {
                NSString* imagePath=dataSource[indexPath.section][indexPath.row][@"photo"];
                [rcmSmallCell.recImageView setImageWithURL:[NSURL URLWithString:imagePath]];
            }
            return rcmSmallCell;
        }
    }else if (indexPath.section==1){
        //discount_subject   discount**********array2
        if (indexPath.row==0) {
            static NSString* cellIDImage=@"RcmdImageCell";
            RcmdImageCell* rcmdImageCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDImage forIndexPath:indexPath];
            //discount_subject
            if ([dataSource[0] count]!=0) {
                NSString* imagePath=dataSource[indexPath.section][indexPath.row][@"photo"];
                [rcmdImageCell.recImageView setImageWithURL:[NSURL URLWithString:imagePath]];
            }
            return rcmdImageCell;
        }else{
            static NSString* cellIDLabel=@"RcmLabelCell";
            RcmLabelCell* rcmLabelCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDLabel forIndexPath:indexPath];
            //discount
            if ([dataSource[0] count]!=0) {
                NSString* imagePath=dataSource[indexPath.section][indexPath.row][@"photo"];
                [rcmLabelCell.recImageView setImageWithURL:[NSURL URLWithString:imagePath]];
                rcmLabelCell.recTitlelabel.text=dataSource[indexPath.section][indexPath.row][@"title"];
                rcmLabelCell.recDiscountLabel.text=dataSource[indexPath.section][indexPath.row][@"priceoff"];
                
                NSString* strPrice=dataSource[indexPath.section][indexPath.row][@"price"];
                //<em>7499</em>元起
                
                //NSLog(@"%@",strPrice);
                NSString* search = @"(>)(\\w+)(<)";
                NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
                //NSLog(@"%lu",(unsigned long)range.length);
                if (range.location != NSNotFound) {
                    
                    rcmLabelCell.recPriceLabel.text = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
                    
                }

            }
            return rcmLabelCell;
        }
    }else{
        //array3
        static NSString* cellIDTab=@"RcmLikeTabCell";
        RcmLikeTabCell* rcmdTabCell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIDTab forIndexPath:indexPath];
        if ([dataSource[0] count]!=0) {
            NSString* imagePath=dataSource[indexPath.section][indexPath.row][@"photo"];
            [rcmdTabCell.recImageView setImageWithURL:[NSURL URLWithString:imagePath]];
            rcmdTabCell.recDetailLabel.text=dataSource[indexPath.section][indexPath.row][@"title"];
            rcmdTabCell.recUserNameLabel.text=dataSource[indexPath.section][indexPath.row][@"username"];
            NSNumber* numLift=dataSource[indexPath.section][indexPath.row][@"views"];
            NSString* liftStr=[NSString stringWithFormat:@"浏览量 %@",numLift];
            rcmdTabCell.recLiftLabel.text=liftStr;
            NSString* rightStr=dataSource[indexPath.section][indexPath.row][@"replys"];
            rcmdTabCell.recRightLabel.text=[NSString stringWithFormat:@"回复量 %@",rightStr];
        }
        return rcmdTabCell;
    }
    
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&(indexPath.row>=1&&indexPath.row<=4)) {
        NSNumber* discountID=dataSource[indexPath.section][indexPath.row][@"id"];
        WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
        webView.discountID=discountID;
        [self.navigationController pushViewController:webView animated:YES];
    
    }else if (indexPath.section==2){
        NSString* urlStr=dataSource[indexPath.section][indexPath.row][@"view_url"];
        //NSLog(@"%@",urlStr);
        WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
        webView.pathStr=urlStr;
        [self.navigationController pushViewController:webView animated:YES];
    }else{
        NSString* urlStr=dataSource[indexPath.section][indexPath.row][@"url"];
        WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
        webView.pathStr=urlStr;
        [self.navigationController pushViewController:webView animated:YES];
    }
    
}


//设置某一个网格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return CGSizeMake(357*(WIDTH/375.0), 120*(HEIGHT/667.0));
        }else{
            return CGSizeMake(182*(WIDTH/375.0), 100*(HEIGHT/667.0));
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            return CGSizeMake(357*(WIDTH/375.0), 120*(HEIGHT/667.0));
        }else{
            return CGSizeMake(182*(WIDTH/375.0), 160*(HEIGHT/667.0));
        }
    }else{
        return CGSizeMake(357*(WIDTH/375.0), 80*(HEIGHT/667.0));
    }
}
//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(WIDTH/375.0), 0, 2.5*(WIDTH/375.0));
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 7*(HEIGHT/667.0);
    }else if(section==1){
        return 7*(HEIGHT/667.0);
    }else{
        return 3*(HEIGHT/667.0);
    }
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else if(section==1){
        return 5*(WIDTH/375.0);
    }else{
        return 0;
    }
}

//设置组头视图或组脚视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //头视图
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"ADheadView";
            ADheadView* headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            headerView.tag=100;
            //[headerView reloadDataWithArray:slideArray];
            [self reloadDataWithArray];
            headerView.delegate=self;
            return headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            [footerView.footBtn setTitle:@"查看更多精彩专题" forState:UIControlStateNormal];
            footerView.delegate=self;
            return footerView;
        }
        
    }else if (indexPath.section==1){
        //头视图
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"WRRecHeaderView";
            WRRecHeaderView* headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            headerView.titleLabel.text=@"抢特价折扣";
            return headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            [footerView.footBtn setTitle:@"查看全部特价折扣" forState:UIControlStateNormal];
            footerView.delegate=self;
            return footerView;
        }
        
    }else{
        //头视图d
        if([kind isEqualToString:UICollectionElementKindSectionHeader]){
            static NSString* header=@"WRRecHeaderView";
            WRRecHeaderView* headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
            headerView.titleLabel.text=@"看热门游记";
            return headerView;
        }else{
            static NSString* footer=@"WRRecFooterView";
            WRRecFooterView* footerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
            
            return footerView;
        }
    }
}

-(void)sendBtnTitle:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"查看更多精彩专题"]) {
        WRAllSpecialViewController* allSpecial=[[WRAllSpecialViewController alloc]init];
        [self.navigationController pushViewController:allSpecial animated:YES];
    }else{
        WRDiscountViewController* discount=[[WRDiscountViewController alloc]init];
        [self.navigationController pushViewController:discount animated:YES];
    }
}

-(void)sendADheaderViewBtn:(UIButton *)btn{
    //NSLog(@"%ld",(long)btn.tag);
    if (btn.tag==10) {
        SleeveViewController* sleeve=[[SleeveViewController alloc]init];
        [self.navigationController pushViewController:sleeve animated:YES];
    }else if (btn.tag==11){
        WRDiscountViewController* discount=[[WRDiscountViewController alloc]init];
        [self.navigationController pushViewController:discount animated:YES];
    }
}

-(void)reloadDataWithArray{
    UIApplication* application=[UIApplication sharedApplication];
    AppDelegate* delegate=application.delegate;
    ADheadView* headerView=(ADheadView* )[self.view viewWithTag:100];
    //sh设置  根据数据多少
    headerView.scrollView.contentSize=CGSizeMake(headerView.scrollView.frame.size.width * slideArray.count, headerView.scrollView.frame.size.height);
    for (UIView* subView in headerView.scrollView.subviews) {
        //移除所有的子视图
        [subView removeFromSuperview];
    }
    //添加新的显示图片
    int i=0;
    for (NSString* imagePath in slideArray) {
        UIImageView* imageView=[[UIImageView alloc]init];
        imageView.userInteractionEnabled=YES;
        //
        imageView.frame=CGRectMake(i*headerView.scrollView.frame.size.width , 0, headerView.scrollView.frame.size.width, headerView.scrollView.frame.size.height);
        //imageView.frame=[delegate createFrimeWithX:i*headerView.scrollView.frame.size.width andY:0 andWidth:headerView.scrollView.frame.size.width andHeight:headerView.scrollView.frame.size.height];
        [imageView setImageWithURL:[NSURL URLWithString:imagePath]];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressImage:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        imageView.tag=i;
        [imageView addGestureRecognizer:tap];
        [headerView.scrollView addSubview:imageView];
        i++;
    }
    //设置_pageControl
    headerView.pageControl.currentPage=0;
    headerView.pageControl.numberOfPages=[slideArray count]-1;
}

-(void)pressImage:(UITapGestureRecognizer* )tap{
    int index=(int)[(UIImageView* )tap.view tag];
    //NSLog(@"%d",index);
    WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
    webView.pathStr=slideUrlArr[index];
    [self.navigationController pushViewController:webView animated:YES];
    
}

//返回组头视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(self.view.frame.size.width, 300*(HEIGHT/667.0));
    }else if(section==1){
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }else{
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }
}

//返回组脚视图的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(self.view.frame.size.width, 40*(HEIGHT/667.0));
    }else if(section==1){
        return CGSizeMake(0, 40*(HEIGHT/667.0));
    }else{
        return CGSizeMake(0, 0);
    }
}

//实现加载刷新
-(void)LoadingAndRefreshing{
    //刷新
    [_collectionView addHeaderWithCallback:^{
        [dataSource replaceObjectAtIndex:0 withObject:@[]];
        [dataSource replaceObjectAtIndex:1 withObject:@[]];
        [dataSource replaceObjectAtIndex:2 withObject:@[]];
        if (isRefreshing) {
            return ;
        }
        isRefreshing=YES;
        currentPage=1;
        [self reloadDataSource];
        
        isRefreshing=NO;
        [_collectionView headerEndRefreshing];
    }];
    //加载
    [_collectionView addFooterWithCallback:^{
        if (isLoading) {
            return ;
        }
        isLoading=YES;
        currentPage++;
        [self reloadDataSource];
        isLoading=NO;
        [_collectionView footerEndRefreshing];
    }];
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
