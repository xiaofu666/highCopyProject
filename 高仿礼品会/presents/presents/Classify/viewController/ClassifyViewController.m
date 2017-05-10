//
//  ClassifyViewController.m
//  presents
//
//  Created by dapeng on 16/1/6.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "ClassifyViewController.h"
#import "XyCollectionViewCell.h"
#import "XyGiftCollectionViewCell.h"
#import "XyClassButtonModel.h"
#import "CarsousekNextViewController.h"
#import "XyViewController.h"
#import "XyWholeViewController.h"

@interface ClassifyViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (retain, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UISegmentedControl *segmentedControl;



@end

@implementation ClassifyViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(putch:) name:@"id" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(putchVC:) name:@"vid" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
 
    self.navigationController.navigationBar.translucent = NO;

    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createSearchButton];
    [self segmentedControls];
}

- (void)night {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"nightMode"];
    
    if (!(passWord == nil) && [passWord isEqualToString:@"day"]){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.311 green:0.765 blue:0.756 alpha:1.000];
    }else{
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        
    }
    
}

- (void)putch:(NSNotification *)nsn {
    CarsousekNextViewController *controller = [[CarsousekNextViewController alloc] init];
    controller.ids = nsn.object;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)putchVC:(NSNotification *)nsn {
    XyViewController *viewController = [[XyViewController alloc] init];
    viewController.newsId = [nsn.object nId];
    viewController.titles = [nsn.object name];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)segmentedControls {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"攻略", @"礼物"]];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.frame = CGRectMake(0, 0, 150, 20);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.segmentedControl.layer.cornerRadius = 2;
    self.segmentedControl.layer.masksToBounds = YES;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlDidPress:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlDidPress:(UISegmentedControl *)sender {

    if (sender.selectedSegmentIndex == 1) {
        self.collectionView.contentOffset = CGPointMake(self.view.width, 0);
    }else {
        self.collectionView.contentOffset = CGPointMake(0, 0);
    }

    
}


#pragma mark - UICollectionView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = CGFLOAT_MIN;
        flowLayout.sectionInset = UIEdgeInsetsMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN);

        flowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滑动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[XyCollectionViewCell class] forCellWithReuseIdentifier:@"XyClassifyCollectionViewCellIdentifier"];
        [_collectionView registerClass:[XyGiftCollectionViewCell class] forCellWithReuseIdentifier:@"XyGiftCollectionViewCellIdentifier"];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        XyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XyClassifyCollectionViewCellIdentifier" forIndexPath:indexPath];
        cell.blcok = ^() {
            XyWholeViewController *wholeVC = [[XyWholeViewController alloc] init];
            [self.navigationController pushViewController:wholeVC animated:YES];
        };
        return cell;
    }else {
        XyGiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XyGiftCollectionViewCellIdentifier" forIndexPath:indexPath];
        return cell;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return 2;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.collectionView.contentOffset.x == 0) {
        self.segmentedControl.selectedSegmentIndex = 0;
    }else {
        self.segmentedControl.selectedSegmentIndex = 1;
    }
}


- (void)createSearchButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"searchButtonIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
- (void)searchButtonAction:(UIBarButtonItem *)right {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [self night];
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


