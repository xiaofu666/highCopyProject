//
//  WRCommunityViewController.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityViewController.h"
#import "AppDelegate.h"
#import "RequestModel.h"
#import "Path.h"
#import "WRCommunityCell.h"
#import "WRCommunityHeaderCell.h"
#import "UIImageView+WebCache.h"
#import "WRCommunityHeaderView.h"
#import "WRCommunityDetailViewController.h"
#import "WRCommunitySheQuWenDaViewController.h"
#import "WRCommunityJieBanZuiXinJieBanViewController.h"
#import "zgSCNavTabBarController.h"
#define WIDTH (float)(self.view.frame.size.width)
#define HEIGHT (float)(self.view.frame.size.height)

@interface WRCommunityViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,sendRequestInfo>
{
    UICollectionView *collection;
    NSMutableArray *dataSource;
}


@end

@implementation WRCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"说走就走";
    self.view.backgroundColor=[UIColor whiteColor];
    dataSource=[[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];

}
-(void)createUI{
    UIApplication *application=[UIApplication sharedApplication];
    AppDelegate *delegate=application.delegate;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //layout.minimumInteritemSpacing=5;
    //layout.minimumLineSpacing=5;
    collection=[[UICollectionView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:657] collectionViewLayout:layout];
    collection.delegate=self;
    collection.dataSource=self;
    //table.separatorStyle=UITableViewCellSeparatorStyleNone;
    //UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x_order_succ_detailInfo_bg_highlighted@2x.png"]];
    //[collection setBackgroundView:imageView];
    collection.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:collection];
    
    [collection registerClass:[WRCommunityCell class] forCellWithReuseIdentifier:@"WRCommunityCell"];
    [collection registerClass:[WRCommunityHeaderCell class] forCellWithReuseIdentifier:@"WRCommunityHeaderCell"];
    [collection registerClass:[WRCommunityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

-(void)loadRequestInfo{
    RequestModel *request=[[RequestModel alloc]init];
    NSString *path=COMMUNITY;
    //NSLog(@"%@",path);
    request.path=path;
    request.delegate=self;
    [request startRequestInfo];
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSDictionary *dic=message[@"data"][@"counts"];
    //NSLog(@"%lu",(unsigned long)dic.count);
    [dataSource addObject:dic];
    NSArray *array=message[@"data"][@"forum_list"];
    for (NSDictionary *dic1 in array) {
        [dataSource addObject:dic1];
    }
    //NSLog(@"44%lu",[(unsigned long)dataSource[2][@"group"] count]);
    [collection reloadData];
    //NSLog(@"5555%@",dataSource[1][@"id"]);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return dataSource.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"1111");
    
    if (section==0) {
        return [dataSource[section] count];
    }
    else{
        return [dataSource[section][@"group"] count];
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"444%ld",(long)indexPath.section );
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            static NSString *string=@"WRCommunityHeaderCell";
            WRCommunityHeaderCell *headcell=[collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
            headcell.ImageView.image=[UIImage imageNamed:@"kaixin_light.png"];
            headcell.titleLabel.text=@"问答";
            headcell.detaillabel.text=[NSString stringWithFormat:@"%@个问题得到解决",dataSource[indexPath.section][@"ask"]];
            headcell.backgroundColor=[UIColor colorWithRed:0.6 green:0.8 blue:0.9 alpha:1];
            return headcell;
        }
        else{
            static NSString *string=@"WRCommunityHeaderCell";
            WRCommunityHeaderCell *headcell=[collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
            headcell.ImageView.image=[UIImage imageNamed:@"homePage_scroll_jprj@2x.png"];
            headcell.titleLabel.text=@"结伴";
            headcell.detaillabel.text=[NSString stringWithFormat:@"%@个网友在此结伴",dataSource[indexPath.section][@"company"]];
            headcell.backgroundColor=[UIColor colorWithRed:0.3 green:0.9 blue:0.8 alpha:1];
            return headcell;
        }
    }
    else{
        static NSString *string1=@"WRCommunityCell";
        WRCommunityCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:string1 forIndexPath:indexPath];
        NSString *imageName=dataSource[indexPath.section][@"group"][indexPath.row][@"photo"];
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageName]];
        cell.nameLabel.text=dataSource[indexPath.section][@"group"][indexPath.row][@"name"];
    
        cell.invitationLabel.text=[NSString stringWithFormat:@"%@个帖子",dataSource[indexPath.section][@"group"][indexPath.row][@"total_threads"]];
        
        return cell;
        
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(160*WIDTH/375, 60*HEIGHT/667);
    }
    else{
        return CGSizeMake(160*WIDTH/375, 60*HEIGHT/667);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 20*WIDTH/375, 0, 20*HEIGHT/667);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5*WIDTH/375;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"jhjj");
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        static NSString *header=@"header";
        WRCommunityHeaderView *headerView=[collection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        if (indexPath.section==0) {
            headerView.headerString=@"爱心帮助";
    
        }
        else {
            headerView.headerString=dataSource[indexPath.section][@"name"];
        
        }
        
        return headerView;
    }
    else{
        return 0;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(0, 40*HEIGHT/667) ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            WRCommunitySheQuWenDaViewController *wenda=[[WRCommunitySheQuWenDaViewController alloc]init];
            [self.navigationController pushViewController:wenda animated:YES];
        }
        else{
            WRCommunityJieBanZuiXinJieBanViewController *zuixinjieban=[[WRCommunityJieBanZuiXinJieBanViewController alloc]init];
            [self.navigationController pushViewController:zuixinjieban animated:YES];
        }

    }
    else{
        WRCommunityDetailViewController *detail=[[WRCommunityDetailViewController alloc]init];
        detail.ID=dataSource[indexPath.section][@"group"][indexPath.row][@"id"];
        detail.name=dataSource[indexPath.section][@"group"][indexPath.row][@"name"];
        detail.path=dataSource[indexPath.section][@"group"][indexPath.row][@"photo"];
        detail.num=dataSource[indexPath.section][@"group"][indexPath.row][@"total_threads"];
                [self.navigationController pushViewController:detail animated:YES];

    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=NO;
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
