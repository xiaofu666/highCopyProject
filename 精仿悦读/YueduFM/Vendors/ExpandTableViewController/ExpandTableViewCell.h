//
//  ExpandTableViewCell.h
//  YueduFM
//
//  Created by StarNet on 9/24/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandTableViewCell.h"

@interface ExpandTableViewCell : UITableViewCell

@property (nonatomic, weak) ExpandTableViewController* expandTableViewController;

@property (nonatomic, strong) id model;

@end
