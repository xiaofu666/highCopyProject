//
//  XHBGomokuEnvisionStack.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHBGomokuBaseStack.h"


// 搜索栈，寻找最佳棋步

@interface XHBGomokuValue : NSObject
@property(nonatomic)NSInteger value;
@property(nonatomic)BOOL hasValue;

@end

@interface XHBGomokuEnvisionStack : XHBGomokuBaseStack
@property(nonatomic)BOOL playerFirst;  //  YES : 玩家先手（黑棋）  NO :玩家后手(白棋)
@property(nonatomic,strong)XHBGomokuValue* maxValue;
@property(nonatomic,strong,readonly)XHBGomokuChessPoint * maxPoint;

-(void)push:(XHBGomokuChessPoint*)element type:(XHBGomokuChessType)type;

-(void)pushLeafValue:(NSInteger)value;   // 设置叶子节点的值

-(BOOL)pruning;   //是否需要剪枝

-(void)reuse;

-(XHBGomokuChessPoint*)onlyPop;

@end
