//
//  AddAlarmViewController.m
//  presents
//
//  Created by dapeng on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "AppDelegate.h"
@interface AddAlarmViewController ()<UITableViewDelegate, UITableViewDataSource, alarmTimeDelegate, RepeatViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SAPPickViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加提醒";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finashiButtonAction:)];
    self.event = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.event.placeholder = @"   事件提醒";
    
    self.notes = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    self.notes.placeholder = @"   可以写下对方想要的礼物、兴趣和收件地址等信息~";
    
    
    [self createTableView];
}

- (void)finashiButtonAction:(UIBarButtonItem *)right {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.event.text, @"event", self.timeText, @"time", self.dataText, @"date", self.notes.text, @"notes", self.repeatText, @"repeat", nil];
    SAKeyValueStore *store = [[SAKeyValueStore alloc] initDBWithName:@"myitems.db"];
    NSString *tableName = @"alarmClock";
    [store createTableWithName:tableName];
    if (![self.idEvent isEqualToString:self.event.text]) {
        [store deleteObjectById:self.idEvent fromTable:tableName];
    }
    
    [store putObject:dic withId:dic[@"event"] intoTable:tableName];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
}

- (void)toAddAction:(UIBarButtonItem *)add {
    AddAlarmViewController *addVC = [[AddAlarmViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 20;
    }else {
        return CGFLOAT_MIN;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return @"备注";
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 150;
    }else {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    
    if (indexPath.section == 0) {
        [cell addSubview:self.event];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"发生日期";
            cell.detailTextLabel.text = self.dataText;
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"提醒时间";
            cell.detailTextLabel.text = self.timeText;
        }else {
            cell.textLabel.text = @"重复";
            cell.detailTextLabel.text = self.repeatText;
        }
    }else {
        [cell addSubview:self.notes];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
            SAPPickerView *pickview=[[SAPPickerView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
            pickview.delegate = self;
            [pickview show];
        }else if (indexPath.row == 1) {
            AlarmTimeViewController *alarmTimeVC = [[AlarmTimeViewController alloc] init];
            alarmTimeVC.timeDelegate = self;
            [self.navigationController pushViewController:alarmTimeVC animated:NO];
        }else {
            RepeatViewController *repeatVC = [[RepeatViewController alloc] init];
            repeatVC.repeatDelegate = self;
            [self.navigationController pushViewController:repeatVC animated:NO];
        }
    }else {
        
    }
}
#pragma mark --------------delegate----------------
- (void)passText:(NSString *)text {
    self.timeText = text;
}
- (void)passRepeat:(NSString *)text {
    self.repeatText = text;
}
-(void)toobarDonBtnHaveClick:(SAPPickerView *)pickView resultString:(NSString *)resultString{
    
    self.dataText = resultString;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];

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
