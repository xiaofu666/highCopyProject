//
//  WRDestinationViewController.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRDestinationViewController.h"
#import "RequestModel.h"
#import "WRDestinationAppModel.h"
#import "WROneCell.h"
#import "WRTwoCell.h"
#import "Path.h"
#import "WRASIADestinationViewController.h"
#import "WRCityDetailsViewController.h"
#import "AppDelegate.h"

//目的地模块
@interface WRDestinationViewController ()<UITableViewDataSource,UITableViewDelegate,sendRequestInfo,WROneCellDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _array;//放置七大洲
    NSMutableArray* _dataSource;
    NSDictionary* _dictNum;//存放id在数组中的顺序
    WRDestinationAppModel* _appModel;
    NSInteger _flag;
    BOOL _isRight;
    BOOL _isLeft;
    RequestModel* _requestModel;
}
@end

@implementation WRDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"说走就走";
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _tableView = [[UITableView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:667] style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _array = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
    _dictNum = @{@"10":@"0",@"12":@"1",@"234":@"2",@"235":@"3",@"239":@"4",@"76":@"5",@"759":@"6",};
    _num = 0;
    _isLeft = YES;
    _isRight = NO;
    [self.view addSubview:_tableView];
    [self createHeader];
    [self loadRequestInfo];
}
-(void)createHeader{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;

    UIImageView* imageView = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:64 andWidth:375 andHeight:200]];
    imageView.tag = 100;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"map@2x"];
    _tableView.tableHeaderView = imageView;
    //地图上的一层阴影
    UIImageView* shadow = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:375 andHeight:200]];
    shadow.backgroundColor = [UIColor cyanColor];
    shadow.alpha = 0.1;
    [imageView addSubview:shadow];
    
    //北美洲
    UIImageView* spotView1 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:50 andY:50 andWidth:10 andHeight:10]];

    spotView1.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView1];
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = [delegate createFrimeWithX:60 andY:45 andWidth:35 andHeight:20];
    [button1 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button1 setTitle:@"北美洲" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:9];
    [button1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 234;
    [_array addObject:button1];
    [imageView addSubview:button1];
    
    //南美洲
    UIImageView* spotView2 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:105 andY:130 andWidth:10 andHeight:10]];
    spotView2.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView2];
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = [delegate createFrimeWithX:115 andY:125 andWidth:35 andHeight:20];
    [button2 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button2 setTitle:@"南美洲" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:9];
    [button2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 235;
    [_array addObject:button2];
    [imageView addSubview:button2];
    
    //非洲
    UIImageView* spotView3 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:200 andY:120 andWidth:10 andHeight:10]];
    spotView3.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView3];
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = [delegate createFrimeWithX:210 andY:115 andWidth:35 andHeight:20];
    [button3 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button3 setTitle:@"非洲" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:9];
    [button3 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 76;
    [_array addObject:button3];
    [imageView addSubview:button3];
    
    //欧洲
    UIImageView* spotView4 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:220 andY:50 andWidth:10 andHeight:10]];
    spotView4.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView4];
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = [delegate createFrimeWithX:230 andY:45 andWidth:35 andHeight:20];
    [button4 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button4 setTitle:@"欧洲" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize:9];
    [button4 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button4.tag = 12;
    [_array addObject:button4];
    [imageView addSubview:button4];
    
    //南极洲
    UIImageView* spotView5 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:245 andY:170 andWidth:10 andHeight:10]];
    spotView5.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView5];
    UIButton* button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = [delegate createFrimeWithX:255 andY:165 andWidth:35 andHeight:20];
    [button5 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button5 setTitle:@"南极洲" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button5.titleLabel.font = [UIFont systemFontOfSize:9];
    [button5 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button5.tag = 759;
    [_array addObject:button5];
    [imageView addSubview:button5];
    
    //亚洲
    UIImageView* spotView6 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:295 andY:55 andWidth:10 andHeight:10]];
    spotView6.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView6];
    UIButton* button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = [delegate createFrimeWithX:305 andY:50 andWidth:35 andHeight:20];
    [button6 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button6 setTitle:@"亚洲" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button6.titleLabel.font = [UIFont systemFontOfSize:9];
    [button6 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button6.tag = 10;
    [_array addObject:button6];
    [imageView addSubview:button6];
    
    //大洋洲
    UIImageView* spotView7 = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:320 andY:120 andWidth:10 andHeight:10]];
    spotView7.image = [UIImage imageNamed:@"扎点_Small_Pressed@2x"];
    [imageView addSubview:spotView7];
    UIButton* button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    button7.frame = [delegate createFrimeWithX:330 andY:115 andWidth:35 andHeight:20];
    [button7 setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [button7 setTitle:@"大洋洲" forState:UIControlStateNormal];
    [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button7.titleLabel.font = [UIFont systemFontOfSize:9];
    [button7 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    button7.tag = 239;
    [_array addObject:button7];
    [imageView addSubview:button7];
}
-(void)pressBtn:(id)sender{
    UIButton* button = (UIButton*) sender;
    _num = [_dictNum[[NSString stringWithFormat:@"%ld",button.tag]] integerValue];
    for (UIButton* btn in _array) {
        if (button.tag == btn.tag) {
            
            [btn setTitleColor:[UIColor colorWithRed:arc4random() % 256 /255.0f green:arc4random() % 256 /255.0f  blue:arc4random() % 256 /255.0f  alpha:0.8] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [_tableView reloadData];
}
-(void)loadRequestInfo{
    _requestModel = [[RequestModel alloc]init];
    _requestModel.delegate = self;
    _requestModel.path = DESTINATION;
    [_requestModel startRequestInfo];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _requestModel.delegate = nil;
}
-(void)sendMessage:(id)message andPath:(NSString *)path{
    NSArray* array = message[@"data"];
    for(NSDictionary * dic in array)
    {
        _appModel = [[WRDestinationAppModel alloc]init];
        [_appModel setValuesForKeysWithDictionary:dic];
        _appModel.country_id = dic[@"id"];
//        NSLog(@"%ld",[_appModel.country count]);
        [_dataSource addObject:_appModel];
    }
    //数据源发生改变 刷新表格
    [_tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_dataSource.count) {
            _appModel = _dataSource[_num];
            if ([_appModel.hot_country count] == 1) {
                return [_appModel.hot_country count] ;
            }
                return [_appModel.hot_country count] * 0.5;
         }
    }else{
            if (_dataSource.count) {
                _appModel = _dataSource[_num];
                return [_appModel.country count];
         }
    }
    return 0;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* string1 = @"oneCellID";
    static NSString* string2 = @"twoCellID";
    if (indexPath.section == 0) {
        WROneCell* cell = [tableView dequeueReusableCellWithIdentifier:string1];
        
        if (cell == nil) {
            cell = [[WROneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string1];
            cell.delegate = self;
        }
        if (_dataSource.count){
            _appModel = _dataSource[_num];
            [cell showAppModel:_appModel andIndexpath:indexPath];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }else{
        
        WRTwoCell* cell = [tableView dequeueReusableCellWithIdentifier:string2];
            if (cell == nil) {
            cell = [[WRTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string2];
            }
            if (_dataSource.count) {
                _appModel = _dataSource[_num];
                [cell showAppModel:_appModel andIndexpath:indexPath];
            }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           return cell;
        }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 250 * self.view.frame.size.height / 667;
    }else{
        return 54 * self.view.frame.size.height / 667;
    }
}
//返回组头视图的高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 30 * self.view.frame.size.height / 667;
    
}
//设置组头标题
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_dataSource.count){
    NSString* str = [_dataSource[_num] cnname];
    NSString* hotStr = [NSString stringWithFormat:@"%@热门目的地",str];
        if ([_appModel.country count] == 0) {
            NSString* countryStr = @"";
            NSArray* titleArray = @[hotStr,countryStr];
             return titleArray[section];
        }else{
            NSString* countryStr = [NSString stringWithFormat:@"%@其他目的地",str];
            NSArray* titleArray = @[hotStr,countryStr];
             return titleArray[section];
        }
    }
    return 0;
}
//实现协议方法
-(void)sendControl:(UIControl *)control{
    if (control.tag < 20) {
        _isLeft = YES;
        _isRight = NO;
    
    }else{
        _isRight = YES;
        _isLeft = NO;
    }
    _appModel = _dataSource[_num];
    WRASIADestinationViewController* controller = [[WRASIADestinationViewController alloc]init];
    WRCityDetailsViewController * controller1 = [[WRCityDetailsViewController alloc]init];

    if (_isLeft) {
        _flag = (control.tag - 10) * 2;
        if ([_appModel.hot_country[_flag][@"flag"] intValue] == 1) {
            controller.country_id = _appModel.hot_country[_flag][@"id"];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            controller1.city_id = [NSString stringWithFormat:@"%@",_appModel.hot_country[_flag][@"id"]];
            [self.navigationController pushViewController:controller1 animated:YES];
        }
    }else{
        _flag = (control.tag - 20) * 2 + 1;
        if ([_appModel.hot_country[_flag][@"flag"] intValue] == 1) {
            controller.country_id = _appModel.hot_country[_flag][@"id"];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            controller1.city_id = [NSString stringWithFormat:@"%@",_appModel.hot_country[_flag][@"id"]];
            [self.navigationController pushViewController:controller1 animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        _appModel = _dataSource[_num];
        /////////////////////////////
        if ([_appModel.country[indexPath.row][@"flag"] intValue] == 1) {
           
            WRASIADestinationViewController* controller = [[WRASIADestinationViewController alloc]init];
            controller.country_id = _appModel.country[indexPath.row][@"id"];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            WRCityDetailsViewController * controller = [[WRCityDetailsViewController alloc]init];
            controller.city_id = [NSString stringWithFormat:@"%@",_appModel.country[indexPath.row][@"id"]];
            NSLog(@"%@",controller.city_id);
            [self.navigationController pushViewController:controller animated:YES];
        
        }
        
    }

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
