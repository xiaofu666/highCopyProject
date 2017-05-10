//
//  PullCollectionReusableView.h
//  presents
//
//  Created by dapeng on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,ButtonState){
    StateComplish = 0 ,
    StateSortDelete
};
typedef void(^ClickBlock) (ButtonState state);

@interface PullCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *clickButton;
@property (nonatomic, assign)BOOL buttonHidden;

-(void)clickWithBlock:(ClickBlock)clickBlock;
@end
