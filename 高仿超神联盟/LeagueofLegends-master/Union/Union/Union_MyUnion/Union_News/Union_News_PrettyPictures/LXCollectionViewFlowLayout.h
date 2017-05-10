//
//  LXCollectionViewFlowLayout.h
//  
//
//  Created by HarrisHan on 15/6/6.
//  Copyright (c) 2015年 HarrisHan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCollectionViewFlowLayout;

@protocol LXwaterFlowDelegate <NSObject>

-(CGFloat)LXwaterFlow:(LXCollectionViewFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;

@end

@interface LXCollectionViewFlowLayout : UICollectionViewLayout

@property(nonatomic , assign) UIEdgeInsets sectionInset;

@property(nonatomic , assign) CGFloat rowMagrin;//行间距

@property(nonatomic , assign) CGFloat colMagrin;//列间距

@property(nonatomic , assign) CGFloat colCount;//列个数

@property(nonatomic , assign) id<LXwaterFlowDelegate>delegate;

@end
