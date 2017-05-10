//
//  CarsousekNextViewController.m
//  presents
//
//  Created by dapeng on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "CarsousekNextViewController.h"

@interface CarsousekNextViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, strong) NSArray *presentArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CarsousekNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = self.NavTitle;
    [self getData];
    // Do any additional setup after loading the view.
}
#pragma mark ---------------数据请求-----------------
- (void)getData {
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?gender=1&generation=0&limit=20&offset=0",self.ids];
    [SAPNetWorkTool getWithUrl:url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"posts"];
        NSMutableArray *mutableArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {
            self.presentModel = [[PresentMdoel alloc] initWithDictionary:dic];
            [mutableArr addObject:self.presentModel];
        }
        self.presentArr = [NSArray arrayWithArray:mutableArr];
        [self createTableView];
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark ----------------tableView---------------------
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 113) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PresentTableViewCell class] forCellReuseIdentifier:@"PresentTableViewCell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PresentTableViewCell"];
    cell.presentModel = self.presentArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_SIZE.height / 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDetailViewController *detailVC = [[PDetailViewController alloc] init];
    detailVC.url = [self.presentArr[indexPath.row] content_url];
    detailVC.cover_image_url = [self.presentArr[indexPath.row] cover_image_url];
    detailVC.titles = [self.presentArr[indexPath.row] title];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
