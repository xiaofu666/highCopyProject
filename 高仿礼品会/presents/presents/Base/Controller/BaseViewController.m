//
//  BaseViewController.m
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSMutableArray *alarmArray;
@property (nonatomic, strong) SAKeyValueStore *store;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewWillAppear:(BOOL)animated {
    self.alarmArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    [self.store createTableWithName:@"alarmClock"];
    
    for (SAKeyValueItem *item in [self.store getAllItemsFromTable:@"alarmClock"]) {
        
        AlarmModel *alarmModel = [[AlarmModel alloc] initWithDictionary:item.itemObject];
        [self.alarmArray addObject:alarmModel];
    }
    
    
    [AlarmClockViewController registerLocalNotification:4 withArray:self.alarmArray];// 4秒后

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
