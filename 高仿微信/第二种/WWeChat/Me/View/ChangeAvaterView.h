//
//  ChangeAvaterView.h
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAvaterView : UIView

/**
 *  弹出的view
 */
@property(nonatomic,strong)UIView * popView;

/**
 *  thisTag 50000
 */
@property(nonatomic,assign)NSInteger  thisTag;

- (instancetype)initWithFrame:(CGRect)frame andBtnArr:(NSArray *)btnArr;

- (void)show;

- (void)hide;

@end
