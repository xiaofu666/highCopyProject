//
//  XyWholeTableViewCell.h
//  presents
//
//  Created by Xy on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholeModel.h"

@interface XyWholeTableViewCell : UITableViewCell
@property (strong, nonatomic) WholeModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UIView *views;
@property (weak, nonatomic) IBOutlet UILabel *sLable;
@property (weak, nonatomic) IBOutlet UILabel *lables;
@property (strong, nonatomic) IBOutlet UIView *myView;

@end
