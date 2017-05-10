//
//  XyWholeViewController.m
//  presents
//
//  Created by Xy on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyWholeViewController.h"
#import "XyWholeTableViewCell.h"
#import "WholeModel.h"

@interface XyWholeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *wholeTableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@end

@implementation XyWholeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.mutableArray = [NSMutableArray arrayWithCapacity:0];
    self.title = @"全部专题";
    UINib *nib = [UINib nibWithNibName:@"XyWholeTableViewCell" bundle:nil];
    self.wholeTableView.delegate = self;
    self.wholeTableView.dataSource = self;
    self.wholeTableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    self.wholeTableView.separatorStyle = NO;
    [self.wholeTableView registerNib:nib forCellReuseIdentifier:@"XyWholeTableViewCellIdentifier"];
    [self getData];
    [self addHeader];
    [self addFooter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取网络请求
- (void)getData {
    [SAPNetWorkTool getWithUrl:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections?limit=20&offset=%ld", self.page] parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        
        NSArray *array = [result[@"data"] objectForKey:@"collections"];
        if (array.count == 0) {
            return;
        }
        for (NSDictionary *dic in array) {
            WholeModel *model = [[WholeModel alloc] initWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.wholeTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XyWholeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XyWholeTableViewCellIdentifier"];
    if (indexPath.row < self.dataSource.count) {
        WholeModel *model = self.dataSource[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WholeModel *model = self.dataSource[indexPath.row];
    CarsousekNextViewController *controller = [[CarsousekNextViewController alloc] init];
    controller.ids = model.nId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 刷新加载
- (void)addHeader {
    [self.wholeTableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getData];
            [self.wholeTableView headerEndRefreshing];
        });
    }];
}

- (void)addFooter {
    [self.wholeTableView addFooterWithCallback:^{
        self.page += 20;
        [self getData];
        [self.wholeTableView footerEndRefreshing];
    }];
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
