//
//  XyClassifyCollectionViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyCollectionViewCell.h"
#import "XyClassButtonModel.h"
#import "XyClassButtonTableViewCell.h"
#import "XyClassifyTableViewCell.h"
#import "XyClassifyModel.h"

@implementation XyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
        self.data = [NSMutableArray arrayWithCapacity:0];
        [self getData];
        [self getDataSource];
        [self addSubview:self.tableView];

    }
    return self;
}



#pragma mark - dataSource
- (void)getData {
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    [SAPNetWorkTool getWithUrl:kStrategyButtonURL parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        NSDictionary *dic = result[@"data"];
        NSArray *array = dic[@"channel_groups"];
        for (NSDictionary *dics in array) {
            XyClassButtonModel *model = [[XyClassButtonModel alloc] initWithDictionary:dics];
            [self.data addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_HUD hide:YES afterDelay:2];
            
            [self.tableView reloadData];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - dataSource
- (void)getDataSource {
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _HUD.color = [UIColor blackColor];
    _HUD.dimBackground = YES;
    _HUD.labelText = @"正在加载";
    
    [SAPNetWorkTool getWithUrl:kStrategySpecialURL parameter:nil httpHeader:nil responseType:ResponseTypeJSON success:^(id result) {
        NSDictionary *dic = result[@"data"];
        NSArray *array = dic[@"collections"];
        for (NSDictionary *dics in array) {
            XyClassifyModel *model = [[XyClassifyModel alloc] initWithDictionary:dics];
            [self.dataSource addObject:model];
        }
        self.url = [dic[@"collections"] valueForKey:@"next_url"];
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}




















#pragma mark - tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[XyClassifyTableViewCell class] forCellReuseIdentifier:@"XyClassifyTableViewCellIdentifier"];
        [_tableView registerClass:[XyClassButtonTableViewCell class] forCellReuseIdentifier:@"XyClassButtonTableViewCellIdentifier"];
    }
    return _tableView;
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, XHIGHT * 20)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, XHIGHT * 100, XHIGHT * 20)];
        lable.text = @"专题";
        lable.font = [UIFont systemFontOfSize:13];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(view.width - XWIDTH * 55, 0, XWIDTH * 55, view.height);
        [button setTitle:@"查看全部>" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [view addSubview:button];
        [view addSubview:lable];
        return view;
    }
    return nil;
}

- (void)buttonDidPress:(UIButton *)sender {
    self.blcok();
}


#pragma mark - 计算自适应Button高度Cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.data.count + 1)  {
        if (indexPath.section == 0) {
            return XHIGHT * 60;
        }else {
            XyClassButtonModel *model = self.data[indexPath.section - 1];
            if ((model.chan.count % 4) == 0) {
                if (indexPath.section == 1) {
                    return (XHIGHT * 100) * (model.chan.count / 4) - XHIGHT * 25;
                }else {
                    return (XHIGHT * 100) * (model.chan.count / 4);
                }
            }else {
                if (indexPath.section == 1) {
                    return (XHIGHT * 100) * ((model.chan.count / 4) + 1) - XHIGHT * 25;
                }else {
                    return (XHIGHT * 100) * ((model.chan.count / 4) + 1);
                }
            }
        }
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        XyClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XyClassifyTableViewCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:self.dataSource];
        [cell.collectionView reloadData];
        return cell;
    }else {
        XyClassButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XyClassButtonTableViewCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section < self.data.count + 1) {
            XyClassButtonModel *model = self.data[indexPath.section - 1];
            [cell setModel:model];
            [cell.collectionView reloadData];
        }
        return cell;
    }
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height - 113);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count + 1;
}

@end
