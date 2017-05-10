//
//  NZCHotDetialTableViewCell.h
//  presents
//
//  Created by dllo on 16/1/7.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NZCHotDetialTableViewCell : UITableViewCell<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *picTableView;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *textAndPic;
@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) UIView *headView;

@end
