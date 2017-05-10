//
//  SearchTableViewCell.h
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchTableViewCellDelegate <NSObject>

- (void)passTitle:(NSString *)title;

@end


@interface SearchTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titles;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) searchModel *searchmodel;
@property (nonatomic, assign) id<searchTableViewCellDelegate> searchDelegate;
@end
