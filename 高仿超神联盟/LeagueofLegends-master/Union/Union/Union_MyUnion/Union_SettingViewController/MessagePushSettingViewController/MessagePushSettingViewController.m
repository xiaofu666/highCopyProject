//
//  MessagePushSettingViewController.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MessagePushSettingViewController.h"

#import "MessagePushSettingCell.h"

@interface MessagePushSettingViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , retain ) UITableView *tableView;


@end

@implementation MessagePushSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息推送设置";
    
    //
    
    //初始化表视图
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MessagePushSettingCell class] forCellReuseIdentifier:@"cell"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---UITableViewDataSource , UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 1;
            
            break;
            
        case 1:
            
            return 2;
            
            break;
            
        default:
            
            return 0;
            
            break;
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessagePushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //获取本地存储的值
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (indexPath.section) {
            
        case 0:
            
            cell.style = MessagePushSettingCellStyleStateLabel;
            
            cell.titleStr = @"接收新消息通知";
            
            //判断系统版本
            
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
                
                //iOS8以上判断是否开启了推送设置
                
                if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
                    
                    cell.stateStr = @"已开启";
                    
                } else {
                    
                    cell.stateStr = @"已关闭";
                    
                }
                
            }else{
                
                //iOS7
                
                
                
            }
            
            break;
            
        case 1:
            
            switch (indexPath.row) {
                    
                case 0:
                    
                    cell.style = MessagePushSettingCellStyleStateSwitch;
                    
                    cell.titleStr = @"声音";
                    
                    cell.isOpen = [[defaults objectForKey:@"setting_messagepush_issound"] boolValue];
                    
                    break;
                    
                case 1:
                    
                    cell.style = MessagePushSettingCellStyleStateSwitch;
                    
                    cell.titleStr = @"震动";
                    
                    cell.isOpen = [[defaults objectForKey:@"setting_messagepush_isvibration"] boolValue];
                    
                    break;
                    
                default:
                    
                    break;
            }
            
            break;
            
        default:
            
            
            break;
    }

    
    return cell;
    
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return @" 您可以在您设备的'设置'-'通知'中进行修改";
            
            break;
            
        case 1:
            
            return @"";
            
            break;
            
        default:
            
            return @"";
            
            break;
    }
    
}




@end
