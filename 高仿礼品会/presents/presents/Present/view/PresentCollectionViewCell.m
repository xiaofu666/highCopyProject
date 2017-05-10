//
//  PresentCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PresentCollectionViewCell.h"

@interface PresentCollectionViewCell()<UITableViewDelegate, UITableViewDataSource, PresentTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CarsouselModel *carsouselModel;
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, strong) NSMutableArray *presentArr;
@property (nonatomic, copy) NSString *next_url;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation PresentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.carouselArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.IdArray = [[NSMutableArray alloc] initWithCapacity:0];

        self.page = 0;
        [self createTableView];
        [self addheader];
    }return self;
    
}

#pragma mark ------------set---------------
- (void)setIds:(NSString *)ids {
    if (_ids != ids) {
        _ids = ids;
    }
    [self getData];
    [self addFooter];


}
#pragma mark ------------------数据请求--------------------


- (void)getData {
    self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];

    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%@/items?limit=20&offset=&gender=1&generation=1",self.ids];
    NSLog(@"%@", url);
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [_HUD hide:YES afterDelay:1];

    [SAPNetWorkTool getWithUrl:url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"items"];
        self.next_url = result[@"data"][@"paging"][@"next_url"];
        for (NSDictionary *dic in array) {
            self.presentModel = [[PresentMdoel alloc] initWithDictionary:dic];
            [self.presentArr addObject:self.presentModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];

        });
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)addheader {
    __weak typeof(self) block = self;

    
    [self.tableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [block getData];
            [block.tableView reloadData];
            [block.tableView headerEndRefreshing];

        });
    }];
    
}

- (void)addFooter {
    __weak typeof(self) block = self;
    
    
        [self.tableView addFooterWithCallback:^{
            
            block.page += 20;
            [SAPNetWorkTool getWithUrl:[NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%@/items?limit=20&offset=%ld&gender=1&generation=1",block.ids, block.page] parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
                NSArray *array = [result[@"data"] objectForKey:@"items"];
                for (NSDictionary *dic in array) {
                    
                    PresentMdoel *model = [[PresentMdoel alloc] initWithDictionary:dic];
                    [block.presentArr addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [block.tableView reloadData];
                    [block.tableView footerEndRefreshing];
                });
            } fail:^(NSError *error) {
                NSLog(@"%@", error);
            }];
            
        }];
}
#pragma mark ------------tableView--------------------
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    [self.tableView registerClass:[PresentTableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self addSubview:self.tableView];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presentArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (self.presentArr.count > indexPath.row) {
        cell.presentModel = self.presentArr[indexPath.row];
        cell.presentTVCDelegate = self;
    }
    
    return cell;
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_SIZE.height / 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.PrsentDelegate toPDetailVCDelegate:[self.presentArr[indexPath.row] valueForKey:@"url"] withImageUrl:[self.presentArr[indexPath.row] cover_image_url] withTitle:[self.presentArr[indexPath.row] title]];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)deleteCollect {
    [self.tableView reloadData];
}
@end
