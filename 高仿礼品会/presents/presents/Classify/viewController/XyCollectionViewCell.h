//
//  XyClassifyCollectionViewCell.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)();

@interface XyCollectionViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) NSMutableArray *data;

@property (copy, nonatomic) Block blcok;

@end
