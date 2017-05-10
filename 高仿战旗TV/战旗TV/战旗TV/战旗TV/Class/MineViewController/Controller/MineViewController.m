//
//  MineViewController.m
//  战旗TV
//
//  Created by 小富 on 16/6/21.
//  Copyright © 2016年 于洋. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSArray *imageArr;
    NSArray *nameArr;
}
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.photoImage.layer.masksToBounds = YES;
    self.photoImage.layer.cornerRadius = 50;
    imageArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    nameArr = @[@"每日任务",@"我的订阅",@"开播提醒",@"观看历史",@"私信",@"官方公告"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
        cell.textLabel.text = nameArr[indexPath.row];
    } else if (indexPath.section == 1){
        cell.imageView.image = [UIImage imageNamed:imageArr[4]];
        cell.textLabel.text = nameArr[4];
    } else {
        cell.imageView.image = [UIImage imageNamed:imageArr[5]];
        cell.textLabel.text = nameArr[5];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
