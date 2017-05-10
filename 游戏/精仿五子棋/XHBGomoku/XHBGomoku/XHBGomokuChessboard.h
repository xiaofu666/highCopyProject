//
//  XHBGomokuChessboard.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//


// 棋局的抽象

#define RowCount 15
#define CenterRow 8

#import <Foundation/Foundation.h>
#import "XHBGomokuChessPoint.h"



@interface NSNumber (cache)
+(NSNumber*)cahceNumber:(NSInteger)value;
@end



@interface XHBGomokuChessboard : NSObject<XHBGomokuChessPointProtocol>
@property(nonatomic,strong,readonly)NSArray * points;
@property(nonatomic,strong)NSArray * successPoints; //胜利的五个子
+(instancetype)newChessboard;

-(XHBGomokuChessPoint*)pointAtRow:(NSInteger)row line:(NSInteger)line;

-(BOOL)couldChessDowm:(XHBGomokuChessPoint*)point;


-(NSInteger)calculate;

-(NSInteger)determine; // 0: 谁也没胜 ， 1 : 黑棋胜利   2:  白棋胜利

-(void)enumerateFrom:(XHBGomokuChessPoint*)point callback:(BOOL(^)(XHBGomokuChessPoint*))callback; // 从最后落子点的周围开始枚举

@end
