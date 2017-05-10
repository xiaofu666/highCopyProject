//
//  XHBGomokuLinePoints.h
//  XHBGomoku
//
//  Created by weqia on 14-9-3.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>

// 每一行，列，斜列 的点
@interface XHBGomokuLinePoints : NSObject
@property(nonatomic,strong)NSArray* array;
@property(nonatomic,readonly)long long lastModelValue;  // 上次计算得出的 模型代数（每种排列都有一个唯一标识数）
@property(nonatomic,readonly)NSInteger lastScore; // 上次计算出的得分
@property(nonatomic)BOOL statuChange;

-(NSInteger)calculate;

-(instancetype)initWithArray:(NSArray*)array;

-(id)objectAtIndex:(NSUInteger)index;

-(NSInteger)count;

@end
