//
//  WRASIADestinationViewController.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRASIADestinationViewController.h"
#import "scRequestModel.h"
#import "Path.h"
#import "WRASIADestinationOneCell.h"
#import "WRASIADestinationTwoCell.h"
#import "WRDestinationCountryAppModel.h"
#import "UIImageView+WebCache.h"
#import "WRDestinationHeaderView.h"
#import "WRDiscountDetailWebViewController.h"
#import "WRCityDetailsViewController.h"
#import "AppDelegate.h"
#define WIDTH (float)(self.view.frame.size.width)
#define HEIGHT (float)(self.view.frame.size.height)
@interface WRASIADestinationViewController ()<UITableViewDataSource,
UITableViewDelegate,UIScrollViewDelegate,sendRequestInfo,WRASIADestinationOneCellDelegate>

{
    
    UITableView* _tableView;
//    UIScrollView* _scrollView;
    NSTimer* _timer;
    NSMutableArray* _array;
    WRDestinationCountryAppModel* _appModel;
    NSMutableArray* _dataSource;
    scRequestModel* _requestModel;
    NSInteger _flag;
    BOOL _isUpLeft;
    BOOL _isUpRight;
    BOOL _isDownLeft;
    BOOL _isDownRight;
}
@end

@implementation WRASIADestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
    [self createNavBar];
    [self createOneCell];
    [self loadRequestInfo];
    
}
//导航栏的设置
-(void)createNavBar{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = [delegate createFrimeWithX:0 andY:0 andWidth:50 andHeight:50];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pressLeftItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;

}
-(void)viewWillDisAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _requestModel.delegate = nil;
    
    _tableView.delegate = nil;
    _tableView = nil;
    
    self.navigationController.navigationBar.alpha = 1;
    
}

-(void) dealloc
{
    [_tableView removeFromSuperview];
    
    _tableView = nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset =_tableView.contentOffset.y;
    if (scrollView){
    
    CGFloat alpha = offset / 200;
    self.navigationController.navigationBar.alpha = alpha;
    }
}

-(void)pressLeftItem{
    [(WRDestinationHeaderView*)_tableView.tableHeaderView stopTimer];
    _tableView.tableHeaderView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//请求数据
-(void)loadRequestInfo{
    _requestModel = [[scRequestModel alloc]init];
    _requestModel.path = [NSString stringWithFormat:ASIADESTINATIONDETAIL,self.country_id,pa];
    _requestModel.delegate = self;
    [_requestModel startRequestInfo];
    
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSDictionary* dic= message[@"data"];
    _appModel = [[WRDestinationCountryAppModel alloc]init];
    
    [_appModel setValuesForKeysWithDictionary:dic];
    _appModel.New_discount = dic[@"new_discount"];
    
    [_dataSource addObject:_appModel];
    
    
    WRDestinationHeaderView* headerView=[[WRDestinationHeaderView alloc]init];
    NSString* str=[_appModel.photos firstObject];
    NSMutableArray* array=[[NSMutableArray alloc]init];
    [array addObjectsFromArray:_appModel.photos];
    [array addObject:str];
    [headerView reloadDataWithArray:array];
    headerView.imageArrCount=(int)array.count;
    _tableView.tableHeaderView=headerView;
    [self addHeaderLabel];
    [_tableView reloadData];
}
-(void)addHeaderLabel{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _appModel = _dataSource[0];
    UILabel* cnnameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:150 andWidth:100 andHeight:20]];
    cnnameLabel.text = _appModel.cnname;
    cnnameLabel.font = [UIFont boldSystemFontOfSize:20];
    cnnameLabel.textColor = [UIColor whiteColor];
    [_tableView addSubview:cnnameLabel];
    UILabel* ennameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:175 andWidth:150 andHeight:20]];
    ennameLabel.font = [UIFont systemFontOfSize:13];
    ennameLabel.textColor = [UIColor whiteColor];
    ennameLabel.text = _appModel.enname;
    [_tableView addSubview:ennameLabel];
    
    UILabel* entryContLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:20 andY:195 andWidth:300 andHeight:50]];
    entryContLabel.textColor = [UIColor whiteColor];
    entryContLabel.text = _appModel.entryCont;
    entryContLabel.font = [UIFont boldSystemFontOfSize:13];
    entryContLabel.numberOfLines = 0;
    [_tableView addSubview:entryContLabel];
    

}
-(void)createOneCell{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _tableView = [[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if(_dataSource.count){
            _appModel = _dataSource[0];
            if ([_appModel.hot_city count] == 0) {
                return 0;
            }else{
                return 1;
            }
        }
        
    }else {
        if (_dataSource.count){
            _appModel = _dataSource[0];
            return [_appModel.New_discount count];
        }
    }
    return 0;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* string = @"oneCellID";
    static NSString* string2 = @"twoCellID";
    if (indexPath.section == 0) {
        WRASIADestinationOneCell* cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            
            cell = [[WRASIADestinationOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            cell.delegate = self;
        }
        if (_dataSource.count) {
            _appModel = _dataSource[0];
            cell.imageArrCount = _appModel.hot_city.count;
            [cell showAppModel:_appModel andIndexpath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        WRASIADestinationTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:string2];
        if (cell == nil) {
            cell = [[WRASIADestinationTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string2];
            
        }
        if (_dataSource.count) {
            _appModel = _dataSource[0];
            [cell showAppModel:_appModel andIndexpath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}
//实现协议方法
-(void)sendControl:(UIControl *)control{
    _appModel = _dataSource[0];
    WRCityDetailsViewController* controller = [[WRCityDetailsViewController alloc]init];
    switch (control.tag) {
        case 40:
        controller.city_id = _appModel.hot_city[0][@"id"];
            break;
        case 41:
        controller.city_id = _appModel.hot_city[1][@"id"];
            break;
        case 42:
        controller.city_id = _appModel.hot_city[2][@"id"];
            break;
        case 43:
        controller.city_id = _appModel.hot_city[3][@"id"];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 300 * HEIGHT / 667;
    }else{
        return 70 * HEIGHT / 667;
    }
}
//返回组头视图的高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 30 * HEIGHT / 667;
    
}
//设置组头标题
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_dataSource.count){
        if(section == 1){
            if ([_appModel.New_discount count] == 0) {
                NSString* countryStr = @"";
                
                return countryStr;
            }else{

                NSString* str = @"超值自由行";
                return str;
            }
        }
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        WRDiscountDetailWebViewController* controller = [[WRDiscountDetailWebViewController alloc]init];
        _appModel = _dataSource[0];
        controller.WebID = _appModel.New_discount[indexPath.row][@"id"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
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
