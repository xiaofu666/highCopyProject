//
//  NZCHotDetialViewController.h
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NZCHotDetialViewController : BaseViewController


@property (nonatomic, strong) HotModel *model;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *shopButton;

@property (nonatomic, strong) UIView *views;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) UITextField *field;;

@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) SAKeyValueStore *store;



@end
