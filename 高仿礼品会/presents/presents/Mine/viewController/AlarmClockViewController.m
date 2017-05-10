//
//  AlarmClockViewController.m
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "AlarmClockViewController.h"

@interface AlarmClockViewController ()<UITableViewDelegate, UITableViewDataSource, AddAlarmViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *alarmArray;
@property (nonatomic, strong) SAKeyValueStore *store;

@end

@implementation AlarmClockViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"送礼提醒";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toAddAction:)];
    

    [self createTableView];
    


}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AlarmTableViewCell class] forCellReuseIdentifier:@"AlarmTableViewCell"];
    [self.view addSubview:self.tableView];
}

- (void)toAddAction:(UIBarButtonItem *)add {
    AddAlarmViewController *addVC = [[AddAlarmViewController alloc] init];
    addVC.addDelegate = self;
    [self.navigationController pushViewController:addVC animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.alarmArray.count > 0) {
        return self.alarmArray.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmTableViewCell"];
    cell.alarmModel = self.alarmArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddAlarmViewController *addAlarmVC = [[AddAlarmViewController alloc] init];
    addAlarmVC.timeText = [self.alarmArray[indexPath.row] valueForKey:@"time"];
    addAlarmVC.dataText = [self.alarmArray[indexPath.row] valueForKey:@"date"];
    addAlarmVC.repeatText = [self.alarmArray[indexPath.row] valueForKey:@"repeat"];
    addAlarmVC.event.text = [self.alarmArray[indexPath.row] valueForKey:@"event"];
    addAlarmVC.notes.text = [self.alarmArray[indexPath.row] valueForKey:@"notes"];
    addAlarmVC.idEvent = [self.alarmArray[indexPath.row] valueForKey:@"event"];
    [self.navigationController pushViewController:addAlarmVC animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    self.alarmArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    [self.store createTableWithName:@"alarmClock"];
    
    for (SAKeyValueItem *item in [self.store getAllItemsFromTable:@"alarmClock"]) {
        
        AlarmModel *alarmModel = [[AlarmModel alloc] initWithDictionary:item.itemObject];
        [self.alarmArray addObject:alarmModel];
    }

//    [super viewWillAppear:animated];

    [self.tableView reloadData];
}


//+ (void)alarmClock {
//    
//    self.alarmArray = [[NSMutableArray alloc] initWithCapacity:0];
//    
//    self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
//    [self.store createTableWithName:@"alarmClock"];
//    for (SAKeyValueItem *item in [self.store getAllItemsFromTable:@"alarmClock"]) {
//        AlarmModel *alarmModel = [[AlarmModel alloc] initWithDictionary:item.itemObject];
//        [self.alarmArray addObject:alarmModel];
//    }
//    
//    
//    [AlarmClockViewController registerLocalNotification:4 withArray:self.alarmArray];// 4秒后
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.store getAllItemsFromTable:@"alarmClock"];
        [self.store deleteObjectById:[self.alarmArray[indexPath.row] valueForKey:@"event"] fromTable:@"alarmClock"];
        
        [self.alarmArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData];
    }
    
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
}
#pragma mark ------------------本地通知--------------------
// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime withArray:(NSMutableArray *)array {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone systemTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitYear;
    
    // 通知内容
    notification.alertBody =  @"";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    for (AlarmModel *model in array) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        
        NSString *str =[formatter stringFromDate:notification.fireDate];
        if ([str isEqualToString:model.date]) {
            NSString *alarm = [NSString stringWithFormat:@"%@:该买礼物了，亲！", model.event];
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:alarm forKey:@"key"];
            
//            NSLog(@"%@", [userDict valueForKey:@"key"]);
            notification.userInfo = userDict;
        }
    
    }
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
//+ (void)cancelLocalNotificationWithKey:(NSString *)key {
//    // 获取所有本地通知数组
//    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
//    
//    for (UILocalNotification *notification in localNotifications) {
//        NSDictionary *userInfo = notification.userInfo;
//        if (userInfo) {
//            // 根据设置通知参数时指定的key来获取通知参数
//            NSString *info = userInfo[@"key"];
//            
//            // 如果找到需要取消的通知，则取消
//            if (info != nil) {
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//                break;
//            }
//        }
//    }
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

@end
