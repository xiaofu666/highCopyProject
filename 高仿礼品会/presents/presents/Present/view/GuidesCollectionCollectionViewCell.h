//
//  GuidesCollectionCollectionViewCell.h
//  presents
//
//  Created by dapeng on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuidesCollectionViewCellDelegate <NSObject>

- (void)toPDetailVCDelegate:(NSString *)pageurl withImageUrl:(NSString *)imageUrl withTitle:(NSString *)title;

@end

@interface GuidesCollectionCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) PresentMdoel *presentModel;
@property (nonatomic, assign) id<GuidesCollectionViewCellDelegate> guidesDelegate;
@end
