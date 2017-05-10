//
//  PullCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/11.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeleteDelegate <NSObject>
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath;
@end
@interface PullCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titles;
@property (nonatomic, strong) PullModel *pullModel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign)id<DeleteDelegate> deleteDelegate;

-(void)passCell:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath;
@end
