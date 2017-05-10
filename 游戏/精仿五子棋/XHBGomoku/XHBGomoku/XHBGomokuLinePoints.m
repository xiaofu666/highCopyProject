//
//  XHBGomokuLinePoints.m
//  XHBGomoku
//
//  Created by weqia on 14-9-3.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuLinePoints.h"
#import "XHBGomokuChessModelTemplate.h"
#import "XHBGomokuChessPoint.h"

/**
 *
 *  每一个棋的状态可由两位的比特位来表示  00, 01 ,10
 *  XHBGomokuChessTypeBlack (黑棋)   01  ==1
 *
 *  XHBGomokuChessTypeWhite (白棋)   10  ==2
 *
 *  XHBGomokuChessTypeEmpty (空位)   11  ==3
 */

@interface XHBGomokuLinePoints ()

@end

@implementation XHBGomokuLinePoints
-(NSInteger)calculate
{
    if (!self.statuChange) {
        return self.lastScore;
    }
    self.statuChange=NO;
    long long modelValue=[self modelValue];
    if (modelValue==_lastModelValue) {
        return _lastScore;
    }
    _lastScore=[[XHBGomokuChessModelTemplate shareTemplete] calculateScoreWithModelValue:modelValue];
    _lastModelValue=modelValue;
    return _lastScore;
}
-(NSInteger)count
{
    return self.array.count;
}

-(instancetype)initWithArray:(NSArray*)array
{
    self=[super init];
    if (self) {
        self.statuChange=YES;
        self.array=array;
    }
    return self;
}

-(id)objectAtIndex:(NSUInteger)index
{
    return [self.array objectAtIndex:index];
}

-(long long)modelValue
{
    long long value=0;
    NSInteger blackCount=0;
    NSInteger whiteCount=0;
    for (NSInteger i=0; i<self.array.count; i++) {
        XHBGomokuChessPoint * point=[self objectAtIndex:i];
        NSInteger ret=3;
        if (point.chess!=nil) {
            if (point.chess.type==XHBGomokuChessTypeWhite) {
                ret=2;
                whiteCount++;
            }else if(point.chess.type==XHBGomokuChessTypeBlack){
                ret=1;
                blackCount++;
            }
        }else if(point.virtualChessType==XHBGomokuChessTypeBlack){
            ret=1;
            blackCount++;
        }else if(point.virtualChessType==XHBGomokuChessTypeWhite){
            ret=2;
            whiteCount++;
        }
        value+=ret;
        value=value<<2;
    }
    if (blackCount+whiteCount==0) {
        value=0;
    }
    return value;
}





@end
