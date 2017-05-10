//
//  WRCityDetailsViewController.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCityDetailsViewController.h"
#import "WRCityOneCell.h"
#import "WRCityTwoCell.h"
#import "scRequestModel.h"
#import "WRCityAppModel.h"
#import "Path.h"
#import "WRDestinationHeaderView.h"
#import "WRDiscountDetailWebViewController.h"
#import "AppDelegate.h"

#define WIDTH (float)(self.view.frame.size.width)
#define HEIGHT (float)(self.view.frame.size.height)
@interface WRCityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo,WRCityOneCellDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _dataSource;
    scRequestModel* _requestModel;
    WRCityAppModel* _appModel;
}
@end

@implementation WRCityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
    [self createUI];
    [self loadRequestInfo];
}

-(void)createUI{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _tableView = [[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];

}
-(void)loadRequestInfo{
    _requestModel = [[scRequestModel alloc]init];
    _requestModel.path = [NSString stringWithFormat:CityPATH,self.city_id,CityPath];
    _requestModel.delegate = self;
    [_requestModel startRequestInfo];
    
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSDictionary * dic = message[@"data"];
        _appModel = [[WRCityAppModel alloc]init];
        [_appModel setValuesForKeysWithDictionary:dic];
        _appModel.New_discount = dic[@"new_discount"];
        [_dataSource addObject:_appModel];
    
    WRDestinationHeaderView* headerView=[[WRDestinationHeaderView alloc]init];
    if ([_appModel.photos count] > 0) {
        NSString* str=[_appModel.photos firstObject];
        NSMutableArray* array=[[NSMutableArray alloc]init];
        [array addObjectsFromArray:_appModel.photos];
        [array addObject:str];
        [headerView reloadDataWithArray:array];
        headerView.imageArrCount=(int)array.count;
        
    }
    _tableView.tableHeaderView=headerView;
    [self addHeaderLabel];
    //数据源发生改变 刷新表格
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if(_dataSource.count){
            _appModel = _dataSource[0];
            if ([_appModel.local_discount count] == 0) {
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* string = @"oneCell";
    static NSString* string2 = @"twoCell";
    if (indexPath.section == 0) {
        WRCityOneCell* cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[WRCityOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            cell.delegate = self;
        }
        if (_dataSource.count){
            _appModel = _dataSource[0];
            cell.imageArrCount = [_appModel.local_discount count];
            [cell showAppModel:_appModel andIndexpath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        WRCityTwoCell* cell = [tableView dequeueReusableCellWithIdentifier:string2];
        if (cell == nil) {
            cell = [[WRCityTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string2];
            
        }
        if (_dataSource.count){
            _appModel = _dataSource[0];
            [cell showAppModel:_appModel andIndexpath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
//实现协议方法
-(void)sendControl:(UIControl *)control{
    WRDiscountDetailWebViewController* controller = [[WRDiscountDetailWebViewController alloc]init];
    _appModel = _dataSource[0];
  
    controller.WebID = [NSString stringWithFormat:@"%@",_appModel.New_discount[control.tag - 60][@"id"]] ;
    [self.navigationController pushViewController:controller animated:YES];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 450 * HEIGHT / 667;
    }else{
        return 70 * HEIGHT / 667;
    }
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
        controller.WebID = [NSString stringWithFormat:@"%@",_appModel.New_discount[indexPath.row][@"id"]] ;
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
