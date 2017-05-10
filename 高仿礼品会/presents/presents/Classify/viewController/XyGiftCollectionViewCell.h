//
//  XyGiftCollectionViewCell.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyLinkageView.h"
#import "XyGiftModel.h"
#import "XyGiftCollectionModel.h"

@interface XyGiftCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) XyLinkageView *linkageView;
@property (strong, nonatomic) NSMutableArray *tableViewArray;
@property (strong, nonatomic) NSMutableArray *CollectionViewArray;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end
