//
//  Union_News_TableView_View.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DetailsBlock)(NSString *string , NSString *type);

@interface Union_News_TableView_View : UIView


@property (nonatomic, copy) DetailsBlock detailsBlock;

@property (nonatomic, copy) DetailsBlock topicBlock;

@property (nonatomic, retain) UITableView *tableView;//表视图

@property (nonatomic, copy) NSString *urlstring;//URL字符串

@property (nonatomic , assign) NSInteger scrollPage;//在滑动视图中的页数

@end
