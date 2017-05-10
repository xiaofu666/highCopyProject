//
//  SelectArtifactViewController.m
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SelectArtifactViewController.h"

@interface SelectArtifactViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, channelsTableViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *presentArr;
@property (nonatomic, strong) NSMutableArray   *buttonTitleArr;
@property (nonatomic, strong) NSArray          *channelsArr;
@property (nonatomic, strong) NSMutableArray   *channelsTitle;
@property (nonatomic, strong) UIButton         *button;
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) UIView           *channelsView;
@property (nonatomic, strong) NSArray          *titleArr;
@property (nonatomic, strong) NSMutableArray   *idArray;
@property (nonatomic, assign) CGFloat          tableViewHeight;
@property (nonatomic, copy  ) NSString         *chanceName;
@property (nonatomic, copy  ) NSString         *url;
@property (nonatomic, copy  ) NSString         *target;
@property (nonatomic, copy  ) NSString         *scene;
@property (nonatomic, copy  ) NSString         *personality;
@property (nonatomic, copy  ) NSString         *prices;
@property (nonatomic, strong) NSMutableArray   *targetArr;
@property (nonatomic, strong) NSMutableArray   *sceneArr;
@property (nonatomic, strong) NSMutableArray   *personalityArr;
@property (nonatomic, strong) NSMutableArray   *pricesArr;
@property (nonatomic, strong) NSMutableArray   *imageArr;
@property (nonatomic, copy  ) NSString         *next_url;
@property (nonatomic, strong) MBProgressHUD    *HUD;

@end

@implementation SelectArtifactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"选礼神器";

    [self getData];
    [self getButtonData];
    [self createTableView];
}
#pragma mark -----------------数据请求---------------------
- (void)getData {
    
    self.imageArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:selectShenqi parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = result[@"data"][@"items"];
        self.next_url = result[@"data"][@"paging"][@"next_url"];

        for (NSDictionary *dic in array) {
            [self.imageArr addObject:dic[@"cover_image_url"]];
            HotModel *hotModel = [[HotModel alloc] initWithDictionary:dic];
            [self.presentArr addObject:hotModel];
            
        }
        _HUD.hidden = YES;
        [self createCollectionView];
        [self addFooter];

    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getButtonData {
    self.buttonTitleArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.idArray = [[NSMutableArray alloc] initWithCapacity:0];
    [SAPNetWorkTool getWithUrl:@"http://api.liwushuo.com/v2/search/item_filter" parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = result[@"data"][@"filters"];
        self.channelsArr = [NSArray arrayWithArray:array];
        
        for (NSDictionary *dic in array) {
            
            [self.buttonTitleArr addObject:dic[@"name"]];
            
        }
        [self createFourButton];

    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];

}
- (void)getDetailDta {
    self.imageArr = [[NSMutableArray alloc] initWithCapacity:0];

    self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/search/item_by_type?limit=20&offset=0&personality=%@&price=%@&scene=%@&target=%@", self.personality, self.prices, self.scene, self.target];
    [SAPNetWorkTool getWithUrl:url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = result[@"data"][@"items"];
        NSLog(@"%@", self.next_url);
        for (NSDictionary *dic in array) {
            
            HotModel *hotModel = [[HotModel alloc] initWithDictionary:dic];
            [self.presentArr addObject:hotModel];
            [self.imageArr addObject:dic[@"cover_image_url"]];
            
        }
        [self.collectionView reloadData];
        
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark -----------------------collectionView------------------------
- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((self.view.width - 20) / 2, self.view.height / 2.5);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, self.view.width, self.view.height - 79) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.849 alpha:1.000];
    [self.collectionView registerClass:[NZCHotCollectionViewCell class] forCellWithReuseIdentifier:@"NZCHotCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.presentArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NZCHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NZCHotCollectionViewCell" forIndexPath:indexPath];
    HotModel *hotModel = self.presentArr[indexPath.item];
    cell.hotModel = hotModel;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NZCHotDetialViewController *hotDetial = [[NZCHotDetialViewController alloc] init];
    HotModel *hotModel = self.presentArr[indexPath.item];
        hotDetial.model = self.presentArr[indexPath.item];
        NSString *str = [NSString stringWithFormat:@"http://www.liwushuo.com/items/%@", hotModel.id];
    NSArray *arr = [NSArray arrayWithObject:self.imageArr[indexPath.item]];
        hotDetial.urlString = str;
        hotDetial.array = arr;
    [self.navigationController pushViewController:hotDetial animated:YES];
    
}

#pragma mark ----------------------筛选按钮-----------------------------------
- (void)createFourButton {
    for (int i = 0; i < self.buttonTitleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.width / 4 * i, 0, self.view.width / 4, 29.5);
        [button setTitle:self.buttonTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
//        button.layer.borderWidth = 0.5;
        [self.view addSubview:button];
    }
    
}

- (void)fourButtonAction:(UIButton *)sender {
    self.channelsTitle = [[NSMutableArray alloc] initWithCapacity:0];
    self.idArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.targetArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.sceneArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.personalityArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.pricesArr = [[NSMutableArray alloc] initWithCapacity:0];

        for (NSDictionary *dic in [self.channelsArr[sender.tag - 10] valueForKey:@"channels"]) {
            [self.channelsTitle addObject:dic[@"name"]];
            if (sender.tag == 10) {
                [self.targetArr addObject:dic[@"id"]];
            }else if (sender.tag == 11) {
                [self.sceneArr addObject:dic[@"id"]];
            }else if (sender.tag == 12) {
                [self.personalityArr addObject:dic[@"id"]];
            }else if (sender.tag == 13) {
                [self.pricesArr addObject:dic[@"key"]];
            }

        }

    
    
    self.titleArr = [NSArray arrayWithArray:self.channelsTitle];
    
    [self.tableView reloadData];
    [self.view bringSubviewToFront:self.channelsView];

}



#pragma mark ------------pullTableView--------------------
- (void)createTableView {
    self.channelsView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.view.width, self.view.height - 30)];
    
    
    UIButton *blackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blackButton.frame = CGRectMake(0, 130, self.view.width, self.view.height - 130);
    [blackButton addTarget:self action:@selector(blackButtonActiv:) forControlEvents:UIControlEventTouchUpInside];
    blackButton.backgroundColor = [UIColor blackColor];
    blackButton.alpha = 0.5;
    
    [self.channelsView addSubview:blackButton];
    [self.view addSubview:self.channelsView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 130) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerClass:[ChannelsTableViewCell class] forCellReuseIdentifier:@"ChannelsTableViewCell"];
    [self.channelsView addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelsTableViewCell"];
    cell.channelsArr = self.channelsTitle;
    cell.channelsDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)passTag:(NSInteger)tag {
//    UIButton *buttonOne = (UIButton *)[self.view viewWithTag:10];
//    UIButton *buttonTwo = (UIButton *)[self.view viewWithTag:11];
//    UIButton *buttonThree = (UIButton *)[self.view viewWithTag:12];
//    UIButton *buttonFour = (UIButton *)[self.view viewWithTag:13];

    
   if (tag > 0) {
        if (self.target == nil) {
            self.target = @"";
        }if (self.scene == nil) {
            self.scene = @"";
        }if (self.personality == nil) {
            self.personality = @"";
        }if (self.prices == nil) {
            self.prices = @"";
        }
        if (self.targetArr.count > 0) {
            
        self.target = self.targetArr[tag - 1];
        }
        if (self.sceneArr.count > 0) {
            
        self.scene = self.sceneArr[tag - 1];
        }
        if (self.personalityArr.count > 0) {
            
        self.personality = self.personalityArr[tag - 1];
        }
        if (self.pricesArr.count > 0) {
            
        self.prices = self.pricesArr[tag - 1];
        }
       self.chanceName = self.channelsTitle[tag - 1];
    
       [self getDetailDta];
        
    }
    else {
        [self getData];
    }
    [self.view bringSubviewToFront:self.collectionView];
}

- (void)blackButtonActiv:(UIButton *)black {
    [self.view bringSubviewToFront:self.collectionView];
    
}

- (void)addFooter {
    __weak typeof(self) block = self;
    
    [self.collectionView addFooterWithCallback:^{
        
        
        [SAPNetWorkTool getWithUrl:block.next_url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
            NSArray *array = result[@"data"][@"items"];
            block.next_url = result[@"data"][@"paging"][@"next_url"];
            for (NSDictionary *dic in array) {
                HotModel *hotModel = [[HotModel alloc] initWithDictionary:dic];
                [block.presentArr addObject:hotModel];
                [block.imageArr addObject:dic[@"cover_image_url"]];
            }
            [block.collectionView reloadData];
            [block.collectionView footerEndRefreshing];
        } fail:^(NSError *error) {
            NSLog(@"%@", error);
        }];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
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
