//
//  RecommendTableCell.h
//  DouYU
//
//  Created by admin on 15/11/1.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChanelData;

@protocol RecommendTableCellDelegate <NSObject>

-(void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata;

@end

@interface RecommendTableCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *modelArray;

@property(nonatomic,assign)int  tags; //所在section

@property(nonatomic,assign)id delegate;



@end
