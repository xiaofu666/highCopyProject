//
//  WRMineViewController.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/3.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRMineViewController.h"
#import "WRMineTableViewCell.h"
@interface WRMineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* table;
    NSArray* titleSource;
    NSArray* detailSource;
}

@end

@implementation WRMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"说走就走";
    // Do any additional setup after loading the view.
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-70)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    titleSource=@[@"开发者",@"消息设置",@"当前版本",@"版本更新"];
    detailSource=@[@"dpp",@"关闭",@"一路向西 1.0",@"已是最新版本"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* mineCellID=@"WRMineTableViewCell";
    WRMineTableViewCell* mineCell=[tableView dequeueReusableCellWithIdentifier:mineCellID];
    if (mineCell==nil) {
        mineCell=[[WRMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellID];
    }
    mineCell.labelTitle.text=titleSource[indexPath.section];
    mineCell.labelDetail.text=detailSource[indexPath.section];
    return mineCell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
