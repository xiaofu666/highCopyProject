//
//  XyLinkageView.h
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 Xy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyGiftCollectionModel.h"

@interface XyLinkageView : UIView



- (void)initWithView;
- (void)tableViewDataSource:(NSArray *)dataSource;
- (void)collectionViewDataSource:(NSArray *)dataSource;
@end
