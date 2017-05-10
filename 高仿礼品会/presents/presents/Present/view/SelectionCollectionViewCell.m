//
//  SelectionCollectionViewCell.m
//  presents
//
//  Created by dapeng on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SelectionCollectionViewCell.h"

@interface SelectionCollectionViewCell()<UITableViewDelegate, UITableViewDataSource, carouselDelegate, selectionTableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CarsouselModel *carsouselModel;
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, strong) NSMutableArray *presentArr;
@property (nonatomic, strong) NSMutableArray *scrollImageArr;
@property (nonatomic, strong) NSMutableArray *NavTitleArr;
@property (nonatomic, copy) NSString *next_url;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end



@implementation SelectionCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.IdArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.target_urlArr = [[NSMutableArray alloc] initWithCapacity:0];


        [self getCarouselData];
        [self getData];
        [self addheader];
    }return self;
    
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark -------------------数据请求------------------------
- (void)getData {
    self.presentArr = [[NSMutableArray alloc] initWithCapacity:0];
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:PresentURL parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"items"];
        self.next_url = result[@"data"][@"paging"][@"next_url"];
        for (NSDictionary *dic in array) {
            self.presentModel = [[PresentMdoel alloc] initWithDictionary:dic];
            [self.presentArr addObject:self.presentModel];
        }
        [_HUD hide:YES afterDelay:1];
        [self addFooter];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getCarouselData {
    self.carousel = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height / 4)];
    [SAPNetWorkTool getWithUrl:CarouselURL parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
        NSArray *array = [result[@"data"] objectForKey:@"banners"];
        self.carouselArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.carouselTitleArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.NavTitleArr = [[NSMutableArray alloc] initWithCapacity:0];
        
     
        for (NSDictionary *dic in array) {
            self.carsouselModel = [[CarsouselModel alloc] initWithDictionary:dic];
            
            [self.carouselArray addObject:self.carsouselModel.image_url];
            [self.target_urlArr addObject:self.carsouselModel.target_url];
            if (self.carsouselModel.target_id == nil) {
                self.carsouselModel.target_id = @"666";
            }
                [self.IdArray addObject:self.carsouselModel.target_id];
            
        }
        [self.carousel setArray:[NSArray arrayWithArray:self.carouselArray] withTitArray:nil];
        self.carousel.delegate = self;

    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];

    [self createTableView];
    
}




#pragma mark ---------------tableView-----------------------
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.tableView registerClass:[SelectionTableView class] forCellReuseIdentifier:@"SelectionTableView"];
    [self.tableView registerClass:[PresentTableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self addSubview:self.tableView];
    //    [self.tableView.tableHeaderView addSubview: self.carousel];
    //    self.tableView.tableHeaderView = self.carousel;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return self.presentArr.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section == 0) {
        self.tableView.tableHeaderView = self.carousel;
        SelectionTableView *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionTableView"];
        cell.selecDelegate = self;
//        cell.scrollImageArr = self.scrollImageArr;
        return cell;

    }
    else if (indexPath.section == 1) {

        PresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.presentModel = self.presentArr[indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.height / 5;
    }else {
        return SCREEN_SIZE.height / 5;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [self.selectionDelegate toPDetailVCDelegate:[self.presentArr[indexPath.row] valueForKey:@"url"] withImageUrl:[self.presentArr[indexPath.row] cover_image_url]  withTitle:[self.presentArr[indexPath.row] title]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
        return CGFLOAT_MIN;
    
}
- (void)selectionUrl:(NSString *)url {
    [self.selectionDelegate toPDetailVCDelegate:url withImageUrl:nil withTitle:nil];
}
- (void)selectionId:(NSString *)ids {
    [self.selectionDelegate toCarsouselNextVC:ids withUrl:nil withNavTitle:nil];
}

- (void)passCarouselValues:(NSInteger)count {
    if ([self.target_urlArr[count] length] == 0) {
        
        [self.selectionDelegate toCarsouselNextVC:self.IdArray[count] withUrl:nil withNavTitle:nil];
    }
    
    else if ([self.target_urlArr[count] length] > 1) {
    
        [self.selectionDelegate toCarsouselNextVC:nil withUrl:self.target_urlArr[count] withNavTitle:nil];
        
    }
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
    if (block.next_url != nil) {
        
        [self.tableView addFooterWithCallback:^{
            
            
            [SAPNetWorkTool getWithUrl:block.next_url parameter:nil httpHeader:nil responseType:ResponseTypeJSON   success:^(id result) {
                NSArray *array = [result[@"data"] objectForKey:@"items"];
                block.next_url = result[@"data"][@"paging"][@"next_url"];
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
}

@end
