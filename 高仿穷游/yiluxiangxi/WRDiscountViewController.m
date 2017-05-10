//
//  WRDiscountViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRDiscountViewController.h"
#import "FSDropDownMenu.h"
#import "RequestModel.h"
#import "Path.h"
#import "DiscountLabelCell.h"
#import "UIImageView+WebCache.h"
#import "WRRecWebViewController.h"
#import "MJRefresh.h"
#define WIDTH (float)(self.view.window.frame.size.width)
#define HEIGHT (float)(self.view.window.frame.size.height)
@interface WRDiscountViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate,sendRequestInfo,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    NSMutableArray* dataSource;
    UICollectionView* _collection;
    int currentPage;
    //下拉刷新
    BOOL isRefreshing;
    //上拉加载
    BOOL isLoading;
    NSString* pathStrAll;
}

//全部类型
@property(nonatomic,strong) NSMutableArray* typeArr;
//出发地
@property(nonatomic,strong) NSMutableArray* departArr;
//目的地
@property(nonatomic,strong) NSMutableArray* areaArr;
@property(nonatomic,strong) NSMutableArray* contryArr;
@property(nonatomic,strong) NSMutableArray* currentContryArr;
//时间
@property(nonatomic,strong) NSMutableArray* timeArr;

@end

@implementation WRDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    isRefreshing=NO;
    isLoading=NO;
    dataSource=[[NSMutableArray alloc]init];
    //self.title = @"FSDropDownMenu";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIView* headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    headerView.backgroundColor=[UIColor colorWithWhite:1 alpha:1.f];
    [self.view addSubview:headerView];
    
    NSArray* headArray=@[@"全部类型",@"出发地 ",@"目的地 ",@"旅行时间"];
    for (int i=0; i<4; i++) {
        UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0+(headerView.frame.size.width/4)*i, 0, headerView.frame.size.width/4, 30)];
        activityBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [activityBtn setTitle:headArray[i] forState:UIControlStateNormal];
        [activityBtn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
        
        NSDictionary *dict = @{NSFontAttributeName:activityBtn.titleLabel.font};
        CGSize size = [headArray[i] boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+25, 11, 0);
        
        
        activityBtn.tag=501+i;
        [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [activityBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:activityBtn];
        
        FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 94) andHeight:300];
        menu.transformView = activityBtn.imageView;
        menu.tag = 1001+i;
        menu.dataSource = self;
        menu.delegate = self;
        [self.view addSubview:menu];
    }
    [self creatCollection];
    [self reloadTableSource];
    [self LoadingAndRefreshing];
    
    _typeArr=[[NSMutableArray alloc]init];
    
    _departArr=[[NSMutableArray alloc]init];
    
    _areaArr=[[NSMutableArray alloc]init];
    _contryArr=[[NSMutableArray alloc]init];
    _currentContryArr=[[NSMutableArray alloc]init];
    
    _timeArr=[[NSMutableArray alloc]init];
    
    
}

-(void)creatCollection{
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, self.view.frame.size.height-145) collectionViewLayout:layout];
    _collection.dataSource=self;
    _collection.delegate=self;
    _collection.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.f];
    [self.view addSubview:_collection];
    
    [_collection registerClass:[DiscountLabelCell class] forCellWithReuseIdentifier:@"DiscountLabelCell"];
    
}

-(void)reloadTableSource{
    
    RequestModel* request=[[RequestModel alloc]init];
    request.delegate=self;
    
    
    request.path=DISCOUNT;
    [request startRequestInfo];
}

-(void)sendMessage:(id)message andPath:(NSString *)path{
    if ([path isEqualToString:DISCOUNTHEADER]) {
        [_typeArr addObjectsFromArray:message[@"data"][@"type"]];
        [_departArr addObjectsFromArray:message[@"data"][@"departure"]];
        [_areaArr addObjectsFromArray:message[@"data"][@"poi"]];
        
        for (NSDictionary* dic in _areaArr) {
            [_contryArr addObject:dic[@"country"]];
        }
        _currentContryArr=_contryArr[0];
        
        [_timeArr addObjectsFromArray:message[@"data"][@"times_drange"]];
        FSDropDownMenu *menu1 = (FSDropDownMenu*)[self.view viewWithTag:1001];
        [menu1.rightTableView reloadData];
        [menu1.leftTableView reloadData];
        FSDropDownMenu *menu2 = (FSDropDownMenu*)[self.view viewWithTag:1002];
        [menu2.rightTableView reloadData];
        [menu2.leftTableView reloadData];
        FSDropDownMenu *menu3 = (FSDropDownMenu*)[self.view viewWithTag:1003];
        [menu3.rightTableView reloadData];
        [menu3.leftTableView reloadData];
        FSDropDownMenu *menu4 = (FSDropDownMenu*)[self.view viewWithTag:1004];
        [menu4.rightTableView reloadData];
        [menu4.leftTableView reloadData];
        
    }else if([path isEqualToString:DISCOUNT]){
        NSArray* array=message[@"data"][@"lastminutes"];
        [dataSource addObjectsFromArray:array];
        [_collection reloadData];
    }else if([path isEqualToString:pathStrAll]){
        if (dataSource.count!=0) {
            [dataSource removeAllObjects];
        }
        [dataSource addObjectsFromArray:message[@"data"][@"lastminutes"]];
        //NSLog(@"%@",message);
        if (dataSource.count!=0) {
            
        }else{
            //NSLog(@"没有查找到相关条目");
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有查找到相关条目" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"清空筛选条件",nil];
            [alert show];
        }
        [_collection reloadData];
    }else{
        //NSLog(@"%@",path);
        for (NSDictionary* dic in message[@"data"][@"lastminutes"]) {
            [dataSource addObject:dic];
        }
        //[dataSource addObjectsFromArray:message[@"data"][@"lastminutes"]];
        //NSLog(@"%@",message);
        if (dataSource.count!=0) {
            
        }else{
            //NSLog(@"没有查找到相关条目");
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有查找到相关条目" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"清空筛选条件",nil];
            [alert show];
        }
        [_collection reloadData];
    }
}

#pragma mark -UIAlertViewDelegate
//点击alertView上得某一个
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //NSLog(@"确定");
        }
            break;
        case 1:
        {
            //NSLog(@"清空筛选条件");
            UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
            [btn1 setTitle:@"全部类型" forState:UIControlStateNormal];
            NSDictionary *dict1 = @{NSFontAttributeName:btn1.titleLabel.font};
            CGSize size1 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict1 context:nil].size;
            btn1.imageEdgeInsets = UIEdgeInsetsMake(11, size1.width+25, 11, 0);
            
            UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
            [btn2 setTitle:@"出发地 " forState:UIControlStateNormal];
            NSDictionary *dict2 = @{NSFontAttributeName:btn2.titleLabel.font};
            CGSize size2 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict2 context:nil].size;
            btn2.imageEdgeInsets = UIEdgeInsetsMake(11, size2.width+25, 11, 0);
            
            UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
            [btn3 setTitle:@"目的地 " forState:UIControlStateNormal];
            NSDictionary *dict3 = @{NSFontAttributeName:btn3.titleLabel.font};
            CGSize size3 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict3 context:nil].size;
            btn3.imageEdgeInsets = UIEdgeInsetsMake(11, size3.width+25, 11, 0);
            
            UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
            [btn4 setTitle:@"旅行时间" forState:UIControlStateNormal];
            NSDictionary *dict4 = @{NSFontAttributeName:btn4.titleLabel.font};
            CGSize size4 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict4 context:nil].size;
            btn4.imageEdgeInsets = UIEdgeInsetsMake(11, size4.width+25, 11, 0);
            
            [self resetItemSizeWithMenuTag:0 By:nil];
        }
        default:
            break;
    }
    
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* disCellID=@"DiscountLabelCell";
    DiscountLabelCell* disCell=[collectionView dequeueReusableCellWithReuseIdentifier:disCellID forIndexPath:indexPath];
    if (dataSource.count!=0) {
        NSString* imageStr=dataSource[indexPath.row][@"pic"];
        [disCell.disImageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:nil];
        disCell.disTitlelabel.text=dataSource[indexPath.row][@"title"];
        disCell.disTimeLabel.text=dataSource[indexPath.row][@"departureTime"];
        //NSLog(@"%@",disCell.disTimeLabel.text);
        //disCell.disPriceLabel.text=dataSource[indexPath.row][@"price"];
        
        NSString* strPrice=dataSource[indexPath.row][@"price"];
        //<em>7499</em>元起
        
        //NSLog(@"%@",strPrice);
        NSString* search = @"(>)(\\w+)(<)";
        NSRange range = [strPrice rangeOfString:search options:NSRegularExpressionSearch];
        //NSLog(@"%lu",(unsigned long)range.length);
        if (range.location != NSNotFound) {
            
            disCell.disPriceLabel.text = [strPrice substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
            
        }
        
        disCell.disDiscountLabel.text=dataSource[indexPath.row][@"lastminute_des"];
    }
    
    return disCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(182*(WIDTH/375.0), 190*(HEIGHT/667.0));
}

//设置collectionView当前页距离四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2.5*(WIDTH/375.0), 0, 2.5*(WIDTH/375.0));
}

//设置最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10*(HEIGHT/667.0);
}
//设置最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*(WIDTH/375.0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WRRecWebViewController* webView=[[WRRecWebViewController alloc]init];
    webView.pathStr=dataSource[indexPath.row][@"url"];
    [self.navigationController pushViewController:webView animated:YES];
}



-(void)btnPressed:(id)sender{
    if (self.typeArr.count==0||self.departArr.count==0||self.areaArr.count==0||self.timeArr.count==0) {
        RequestModel* request=[[RequestModel alloc]init];
        request.path=DISCOUNTHEADER;
        request.delegate=self;
        [request startRequestInfo];
    }
    UIButton* btn=(UIButton* )sender;
    //NSLog(@"%ld",(long)btn.tag);
    FSDropDownMenu *menu1 = (FSDropDownMenu*)[self.view viewWithTag:1001];
    FSDropDownMenu *menu2 = (FSDropDownMenu*)[self.view viewWithTag:1002];
    FSDropDownMenu *menu3 = (FSDropDownMenu*)[self.view viewWithTag:1003];
    FSDropDownMenu *menu4 = (FSDropDownMenu*)[self.view viewWithTag:1004];
    if (btn.tag==501) {
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu1 menuTapped];
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
        }];
    }else if(btn.tag==502){
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu2 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
        }];
    }else if (btn.tag==503) {
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu3 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu4.show==YES) {
                [menu4 menuTapped];
            }
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu4 menuTapped];
            if (menu1.show==YES) {
                [menu1 menuTapped];
            }
            if (menu2.show==YES) {
                [menu2 menuTapped];
            }
            if (menu3.show==YES) {
                [menu3 menuTapped];
            }
        }];
    }
    
}

#pragma mark - reset button size

-(void)resetItemSizeWithMenuTag:(NSInteger )tag By:(NSString*)str{
    //NSLog(@"%ld",tag);
    UIButton* btn;
    if (tag==1001) {
        btn = (UIButton*)[self.view viewWithTag:501];
    }else if (tag==1002){
        btn = (UIButton*)[self.view viewWithTag:502];
    }else if (tag==1003){
        btn = (UIButton*)[self.view viewWithTag:503];
    }else if (tag==1004){
        btn = (UIButton*)[self.view viewWithTag:504];
    }else{
        
    }
    if (tag>=1001&&tag<=1004) {
        //NSLog(@"%@",str);
        [btn setTitle:str forState:UIControlStateNormal];
        NSDictionary *dict = @{NSFontAttributeName:btn.titleLabel.font};
        CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y,size.width+33, 30);
        btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+23, 11, 0);
    }
    if ((tag>=1001&&tag<=1004)||tag==0) {
        UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
        NSString* str1=btn1.titleLabel.text;
        UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
        NSMutableString* str2=[[NSMutableString alloc]initWithString:btn2.titleLabel.text];
        UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
        NSMutableString* str3=[[NSMutableString alloc]initWithString:btn3.titleLabel.text];
        UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
        NSMutableString* str4=[[NSMutableString alloc]initWithString:btn4.titleLabel.text];
        
        if ([str2 isEqualToString:@"出发地 "]) {
            [str2 setString:@"全部出发地"];
        }
        if ([str3 isEqualToString:@"目的地 "]) {
            [str3 setString:@"全部目的地"];
        }
        if ([str4 isEqualToString:@"旅行时间"]) {
            [str4 setString:@"全部时间"];
        }
        //NSLog(@"%@,%@,%@,%@",str1,str2,str3,str4);
        
        //查找_type组的index值,找到拼接id
        int index=0;
        for (int i=0; i<_typeArr.count; i++) {
            if ([_typeArr[i][@"catename"] isEqualToString:str1]) {
                index=i;
            }
        }
        //NSLog(@"%@",_typeArr);
        NSString* pathStr1=_typeArr[index][@"id"];
        
        //查找_departArr组的index值,找到拼接id
        index=0;
        for (int i=0; i<_departArr.count; i++) {
            if ([_departArr[i][@"city_des"] isEqualToString:str2]) {
                index=i;
            }
        }
        NSString* pathStr2=_departArr[index][@"city"];
        
        //查找_areaArr数组 和_currentContryArr数组 的index值,找到拼接id
        index=0;
        int indexArea=0;
        int indexContry=0;
        NSMutableString* pathStr3=[[NSMutableString alloc]init];
        NSMutableString* pathStr4=[[NSMutableString alloc]init];
        for (int i=0; i<_areaArr.count; i++) {
            //NSLog(@"%d",i);
            NSMutableArray* tempArr=[[NSMutableArray alloc]init];
            [tempArr addObjectsFromArray:_areaArr[i][@"country"]];
            for (int j=0; j<tempArr.count; j++) {
                //NSLog(@"%d",j);
                if ([tempArr[j][@"country_name"] isEqualToString:str3]) {
                    indexContry=j;
                    indexArea=i;
                }
            }
        }
        [pathStr3 setString:[NSString stringWithFormat:@"%@",_areaArr[indexArea][@"continent_id"]]];
        [pathStr4 setString:[NSString stringWithFormat:@"%@",_currentContryArr[indexContry][@"country_id"]]];
        
        //查找_timeArr组的index值,找到拼接id
        index=0;
        for (int i=0; i<_timeArr.count; i++) {
            if ([_timeArr[i][@"description"] isEqualToString:str4]) {
                index=i;
            }
        }
        NSString* pathStr5=_timeArr[index][@"times"];
        //NSLog(@"%@ %@ %@ %@ %@",pathStr1,pathStr2,pathStr3,pathStr4,pathStr5);
        RequestModel* request=[[RequestModel alloc]init];
        request.delegate=self;
        //14c&page=%d&page_size=20&product_type=%@&times=%@%@"
        pathStrAll=[NSString stringWithFormat:DISCOUNTSMAL1,pathStr3,pathStr4,pathStr2,pathStr1,pathStr5,DISCOUNTSMAL2];
        request.path=pathStrAll;
        //NSLog(@"%@",pathStr3);
        //NSLog(@"%@",pathStrAll);
        [request startRequestInfo];
    }else{
//        _typeArr=[[NSMutableArray alloc]init];
//        
//        _departArr=[[NSMutableArray alloc]init];
//        
//        _areaArr=[[NSMutableArray alloc]init];
//        _contryArr=[[NSMutableArray alloc]init];
//        _currentContryArr=[[NSMutableArray alloc]init];
//        
//        _timeArr=[[NSMutableArray alloc]init];
        if (_typeArr.count==0&&_departArr.count==0&&_timeArr.count==0&&_areaArr.count==0&&_contryArr.count==0&&_currentContryArr.count==0) {
 
            RequestModel* request=[[RequestModel alloc]init];
            request.delegate=self;
            NSString* pageStrAll=[NSString stringWithFormat:DISCOUNTSMAL111,currentPage,DISCOUNTSMAL2];
            //NSLog(@"%d",currentPage);
            request.path=pageStrAll;
            //NSLog(@"%@",pathStr3);
            //NSLog(@"%@",pathStrAll);
            [request startRequestInfo];
            
        }else{
            //NSLog(@"%d",tag);
            UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
            NSString* str1=btn1.titleLabel.text;
            UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
            NSMutableString* str2=[[NSMutableString alloc]initWithString:btn2.titleLabel.text];
            UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
            NSMutableString* str3=[[NSMutableString alloc]initWithString:btn3.titleLabel.text];
            UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
            NSMutableString* str4=[[NSMutableString alloc]initWithString:btn4.titleLabel.text];
            
            if ([str2 isEqualToString:@"出发地 "]) {
                [str2 setString:@"全部出发地"];
            }
            if ([str3 isEqualToString:@"目的地 "]) {
                [str3 setString:@"全部目的地"];
            }
            if ([str4 isEqualToString:@"旅行时间"]) {
                [str4 setString:@"全部时间"];
            }
            //NSLog(@"%@,%@,%@,%@",str1,str2,str3,str4);
            
            //查找_type组的index值,找到拼接id
            int index=0;
            for (int i=0; i<_typeArr.count; i++) {
                if ([_typeArr[i][@"catename"] isEqualToString:str1]) {
                    index=i;
                }
            }
            //NSLog(@"%@",_typeArr);
            NSString* pathStr1=_typeArr[index][@"id"];
            
            //查找_departArr组的index值,找到拼接id
            index=0;
            for (int i=0; i<_departArr.count; i++) {
                if ([_departArr[i][@"city_des"] isEqualToString:str2]) {
                    index=i;
                }
            }
            NSString* pathStr2=_departArr[index][@"city"];
            
            //查找_areaArr数组 和_currentContryArr数组 的index值,找到拼接id
            index=0;
            int indexArea=0;
            int indexContry=0;
            NSMutableString* pathStr3=[[NSMutableString alloc]init];
            NSMutableString* pathStr4=[[NSMutableString alloc]init];
            for (int i=0; i<_areaArr.count; i++) {
                //NSLog(@"%d",i);
                NSMutableArray* tempArr=[[NSMutableArray alloc]init];
                [tempArr addObjectsFromArray:_areaArr[i][@"country"]];
                for (int j=0; j<tempArr.count; j++) {
                    //NSLog(@"%d",j);
                    if ([tempArr[j][@"country_name"] isEqualToString:str3]) {
                        indexContry=j;
                        indexArea=i;
                    }
                }
            }
            [pathStr3 setString:[NSString stringWithFormat:@"%@",_areaArr[indexArea][@"continent_id"]]];
            [pathStr4 setString:[NSString stringWithFormat:@"%@",_currentContryArr[indexContry][@"country_id"]]];
            
            //查找_timeArr组的index值,找到拼接id
            index=0;
            for (int i=0; i<_timeArr.count; i++) {
                if ([_timeArr[i][@"description"] isEqualToString:str4]) {
                    index=i;
                }
            }
            NSString* pathStr5=_timeArr[index][@"times"];
            //NSLog(@"%@ %@ %@ %@ %@",pathStr1,pathStr2,pathStr3,pathStr4,pathStr5);
            RequestModel* request=[[RequestModel alloc]init];
            request.delegate=self;
            //14c&page=%d&page_size=20&product_type=%@&times=%@%@"
            NSString* pageStrAll=[NSString stringWithFormat:DISCOUNTSMAL11,pathStr3,pathStr4,pathStr2,currentPage,pathStr1,pathStr5,DISCOUNTSMAL2];
            //NSLog(@"%d",currentPage);
            request.path=pageStrAll;
            //NSLog(@"%@",pathStr3);
            //NSLog(@"%@",pathStrAll);
            [request startRequestInfo];
        }
        
    }
    
}


#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (menu.tag==1001) {
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _typeArr.count;
        }
    }else if (menu.tag==1002){
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _departArr.count;
        }
    }else if (menu.tag==1003) {
        if (tableView == menu.rightTableView) {
            return _areaArr.count;
        }else{
            return _currentContryArr.count;
        }
    }else{
        if (tableView == menu.rightTableView) {
            return 1;
        }else{
            return _timeArr.count;
        }
    }
    
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (menu.tag==1001) {
        if (tableView == menu.rightTableView) {
            
            return @"全部类型";
        }else{
            return _typeArr[indexPath.row][@"catename"];
        }
    }else if (menu.tag==1002){
        if (tableView == menu.rightTableView) {
            
            return @"全部出发地";
        }else{
            return _departArr[indexPath.row][@"city_des"];
        }
    }else if (menu.tag==1003) {
        if (tableView == menu.rightTableView) {
            
            return _areaArr[indexPath.row][@"continent_name"];
        }else{
            return _currentContryArr[indexPath.row][@"country_name"];
        }
    }else{
        if (tableView == menu.rightTableView) {
            
            return @"全部时间";
        }else{
            return _timeArr[indexPath.row][@"description"];
        }
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%ld",menu.tag);
    if (menu.tag==1001) {
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_typeArr[indexPath.row][@"catename"]];
        }
    }else if (menu.tag==1002){
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_departArr[indexPath.row][@"city_des"]];
        }
    }else if (menu.tag==1003) {
        if(tableView == menu.rightTableView){
            if (_contryArr.count!=0) {
                _currentContryArr = _contryArr[indexPath.row];
                [menu.leftTableView reloadData];
            }
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_currentContryArr[indexPath.row][@"country_name"]];
        }
    }else{
        if(tableView == menu.rightTableView){
            
        }else{
            [self resetItemSizeWithMenuTag:menu.tag By:_timeArr[indexPath.row][@"description"]];
        }
    }
}

//实现加载刷新
-(void)LoadingAndRefreshing{
    //刷新
    [_collection addHeaderWithCallback:^{
        [dataSource removeAllObjects];
        if (isRefreshing) {
            return ;
        }
        isRefreshing=YES;
        currentPage=1;
        
        UIButton* btn1 = (UIButton*)[self.view viewWithTag:501];
        [btn1 setTitle:@"全部类型" forState:UIControlStateNormal];
        NSDictionary *dict1 = @{NSFontAttributeName:btn1.titleLabel.font};
        CGSize size1 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict1 context:nil].size;
        btn1.imageEdgeInsets = UIEdgeInsetsMake(11, size1.width+25, 11, 0);
        
        UIButton* btn2 = (UIButton*)[self.view viewWithTag:502];
        [btn2 setTitle:@"出发地 " forState:UIControlStateNormal];
        NSDictionary *dict2 = @{NSFontAttributeName:btn2.titleLabel.font};
        CGSize size2 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict2 context:nil].size;
        btn2.imageEdgeInsets = UIEdgeInsetsMake(11, size2.width+25, 11, 0);
        
        UIButton* btn3 = (UIButton*)[self.view viewWithTag:503];
        [btn3 setTitle:@"目的地 " forState:UIControlStateNormal];
        NSDictionary *dict3 = @{NSFontAttributeName:btn3.titleLabel.font};
        CGSize size3 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict3 context:nil].size;
        btn3.imageEdgeInsets = UIEdgeInsetsMake(11, size3.width+25, 11, 0);
        
        UIButton* btn4 = (UIButton*)[self.view viewWithTag:504];
        [btn4 setTitle:@"旅行时间" forState:UIControlStateNormal];
        NSDictionary *dict4 = @{NSFontAttributeName:btn4.titleLabel.font};
        CGSize size4 = [@"全部类型" boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict4 context:nil].size;
        btn4.imageEdgeInsets = UIEdgeInsetsMake(11, size4.width+25, 11, 0);
        
        [self resetItemSizeWithMenuTag:50 By:nil];
        
        isRefreshing=NO;
        [_collection headerEndRefreshing];
    }];
    //加载
    [_collection addFooterWithCallback:^{
        if (isLoading) {
            return ;
        }
        isLoading=YES;
        currentPage++;
        [self resetItemSizeWithMenuTag:50 By:nil];
        isLoading=NO;
        [_collection footerEndRefreshing];
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
