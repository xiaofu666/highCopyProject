//
//  NZCHotCarouselTableViewCell.h
//  presents
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZCHotCarouselTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) HotModel *hotModel;

@property (nonatomic, strong) UILabel *titleStr;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UILabel *priceString;

@property (nonatomic, strong) Carousel *carousel;
@property (nonatomic, assign) CGFloat heigh;



@end
