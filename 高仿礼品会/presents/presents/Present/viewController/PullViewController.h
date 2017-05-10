//
//  PullViewController.h
//  presents
//
//  Created by dapeng on 16/1/11.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SPACE 10.0

@protocol PullViewControllerDelegate <NSObject>

- (void)switchChannels:(NSString *)channesText;

@optional
- (void)passChannels:(NSMutableArray *)channels;

@end


@interface PullViewController : UIView
/**
 *  已选频道数组
 */
@property (nonatomic, strong) NSMutableArray *selectedArr;
/**
 *  待选频道数组
 */
@property (nonatomic, strong) NSMutableArray *optionalArray;
/**
 *  全部cell
 */
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
/**
 *  是否排序
 */
@property (nonatomic, assign) BOOL isSort;
/**
 *  是否隐藏
 */
@property (nonatomic, assign) BOOL lastIsHidden;
/**
 *  切换频道
 */
@property (nonatomic, assign) id<PullViewControllerDelegate> pullDelegate;


@end
