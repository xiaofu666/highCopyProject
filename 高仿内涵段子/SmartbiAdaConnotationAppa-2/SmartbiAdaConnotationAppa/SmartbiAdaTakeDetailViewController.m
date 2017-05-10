//
//  SmartbiAdaTakeDetailViewController.m
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/21.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import "SmartbiAdaTakeDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "UIImage+DPTransparent.h"
#import "SmartbiAdaHomeTableViewCell.h"

#import "SmartbiAdaTakeDetail.h"
#import "SmartbiAdaTakeDetailTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "config__api.h"
#import "SmartbiAdaTakeDetailSub.h"

#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)
#define CELLID  @"takeDetailCell"


@interface SmartbiAdaTakeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *subScribe_count;
@property (strong, nonatomic) UILabel *total_updates;
@property (strong, nonatomic) UILabel *intro;

@property (weak, nonatomic) IBOutlet UIImageView *iconBackImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;


@end

@implementation SmartbiAdaTakeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.frame=kScreenBounds;
//    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self createHead];
    [self createUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmartbiAdaTakeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:CELLID];
   
    [self fetchDataFromServer];
    [self.tableView addSubview:self.iconBackImageView];
}
-(void)createUI{
    
//    UIColor *titleColor = [UIColor whiteColor];
    //    [UIColor colorWithRed:87.0/255.0f green:67.0/255.0f blue:55.0/255.0f alpha:1.0];

//    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftBackButtonFGNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    left.tintColor=titleColor;
//    self.navigationItem.leftBarButtonItem=left;

    
//    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    right.tintColor=titleColor;
//    self.navigationItem.rightBarButtonItem=right;
   
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.find.icon] placeholderImage:[UIImage imageNamed:@"photo"]];
//    self.icon.layer.borderWidth=2.0f;
    self.iconBackImageView.image=[self croppIngimageByImageName:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.find.icon]]] toRect: CGRectMake(0, 0, kScreenWidth, 200)];
////         self.iconBackImageView.frame ];
//    [self.iconBackImageView sd_setImageWithURL:[NSURL URLWithString:self.find.icon] placeholderImage:[UIImage imageNamed:@"photo"]];

    self.name.text=self.find.name;
//    NSLog(@"self.find.subscribe_count==%@",self.find.subscribe_count);
    self.subScribe_count.text=[NSString stringWithFormat:@"%@",self.find.subscribe_count];
    self.total_updates.text=[NSString stringWithFormat:@"%@",self.find.total_updates];
    self.intro.text=self.find.intro;

    
}
-(void)createHead
{
    UIColor *whiteCol=[UIColor whiteColor];
    self.name=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 20)];
    self.name.textColor=whiteCol;
    UIFont *font = [UIFont systemFontOfSize:14];
    self.name.font = font;
    self.name.textAlignment = NSTextAlignmentCenter;//居中
    [self.iconBackImageView addSubview:self.name];
    self.icon=[[UIImageView alloc]initWithFrame:CGRectMake(22, 60, 40, 40)];
    self.icon.layer.borderWidth=2.0;
    self.icon.layer.cornerRadius=10.0;
    self.icon.layer.borderColor=(__bridge CGColorRef)(whiteCol);
    [self.iconBackImageView addSubview:self.icon];
    
    //uilabel的设置
    UIFont *font11 = [UIFont systemFontOfSize:11];
//    self.name.font = font11;
    self.subScribe_count=[[UILabel alloc]initWithFrame:CGRectMake(80, 80, 60, 20)];
     [self.subScribe_count setTextColor:[UIColor yellowColor]];
    self.subScribe_count.font=font11;
    self.subScribe_count.textAlignment=NSTextAlignmentRight;
    [self.iconBackImageView addSubview:self.subScribe_count];
    UILabel *fir=[[UILabel alloc]initWithFrame:CGRectMake(140, 80, 40, 20)];
    fir.text=@"人参与|";
    fir.font=font11;
    fir.textColor=whiteCol;
    [self.iconBackImageView addSubview:fir];
    self.total_updates=[[UILabel alloc]initWithFrame:CGRectMake(180, 79, 50, 20)];
    [self.total_updates setTextColor:[UIColor yellowColor]];
    self.total_updates.font=font11;
    self.total_updates.textAlignment=NSTextAlignmentRight;
    [self.iconBackImageView addSubview:self.total_updates];
    UILabel *second=[[UILabel alloc]initWithFrame:CGRectMake(230, 80, 25, 20)];
    second.text=@"帖子";
    second.font=font11;
    second.textColor=whiteCol;
    [self.iconBackImageView addSubview:second];
    self.intro=[[UILabel alloc]initWithFrame:CGRectMake(22, 108, 260, 45)];
    self.intro.numberOfLines=0;
    self.intro.font=font11;
    self.intro.textColor=whiteCol;
    [self.iconBackImageView addSubview:self.intro];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0]];
}
//模糊图片的处理方法
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
    
    
}

-(void)fetchDataFromServer{
    AFHTTPSessionManager *man=[AFHTTPSessionManager manager];
    man.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",[NSString stringWithFormat:@"%@%@&count=30&level=6&message_cursor=0&mpic=1",FIND__DETAIL__CELL,self.find.category_id]);
   [man GET:[NSString stringWithFormat:@"%@%@&count=30&level=6&message_cursor=0&mpic=1",FIND__DETAIL__CELL,self.find.category_id] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *jsonObj=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       for (NSDictionary *key in jsonObj[@"data"][@"data"]) {
           SmartbiAdaTakeDetail *takeDetail=[SmartbiAdaTakeDetail initWithDictionry:key];
           //                          NSLog(@"home:%@",key);
           if( takeDetail.name.length>0){
               [self.dataSource addObject:takeDetail];
           }

       }
       
       [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==%@",error);
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.dataSource.count %ld",self.dataSource.count);
    return self.dataSource.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SmartbiAdaTakeDetail *takeDetail=self.dataSource[indexPath.row];
    return takeDetail.contentSize.height+takeDetail.imageHeight+takeDetail.videoHeight+151.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SmartbiAdaTakeDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CELLID];
    SmartbiAdaTakeDetail *takeDetail=self.dataSource[indexPath.row];
    [cell refreshUI:takeDetail];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaTakeDetailTableViewCell *AVcell = (SmartbiAdaTakeDetailTableViewCell *)cell;
    [((AVPlayerLayer *)AVcell.videoView.layer).player pause];
}

// 点击Cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmartbiAdaTakeDetailSub *takeDetailSubVC=[[SmartbiAdaTakeDetailSub alloc]init];
    
    takeDetailSubVC.share_url=[self.dataSource[indexPath.row] share_url];
    [self.navigationController pushViewController:takeDetailSubVC animated:YES];
}



-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200.0f;
//}
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
#pragma mark 懒加载
-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

@end
