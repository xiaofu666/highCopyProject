//
//  XHBGomokuEnvisionStack.m
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuEnvisionStack.h"

@implementation XHBGomokuValue
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.value=0;
    }
    return self;
}
@end


@interface XHBGomokuEnvisionStack ()
@property(nonatomic,strong)NSMutableArray * values;

@end

@implementation XHBGomokuEnvisionStack
-(instancetype)init
{
    self=[super init];
    if (self ) {
        _values=[NSMutableArray array];
    }
    return self;
}
-(void)reuse
{
 //   NSLog(@"\n\n\n\n\n\n\n **********************");
    [super  reuse];
    _maxPoint=nil;
    _maxValue=nil;
    _values=[NSMutableArray array];
}

-(void)push:(XHBGomokuChessPoint*)element type:(XHBGomokuChessType)type
{
    if (element.chess!=nil) {
        return;
    }
    element.virtualChessType=type;
    [super push:element];
    [_values addObject:[[XHBGomokuValue alloc]init]];
}

-(XHBGomokuChessPoint*)onlyPop
{
    NSInteger depth=[self depth];
    if (depth==0) {
        return nil;
    }
    XHBGomokuChessPoint * point=[super pop];
    point.virtualChessType=XHBGomokuChessTypeEmpty;
    [_values removeObjectAtIndex:_values.count-1];
    return point;
}

-(XHBGomokuChessPoint*)pop
{
    NSInteger depth=[self depth];
    if (depth==0) {
        return nil;
    }
    XHBGomokuChessPoint * point=[super pop];
    point.virtualChessType=XHBGomokuChessTypeEmpty;
    XHBGomokuValue * value=[_values lastObject];
    if (depth==1) {
        if (_maxValue==nil) {
            _maxValue=[[XHBGomokuValue alloc]init];
            _maxValue.value=value.value;
            _maxPoint=point;
         //   NSLog(@"ROW: %d , LINE:%d  score :%d",point.row,point.line,self.maxValue.value);
        }
        if (value.value>_maxValue.value) {
            _maxValue.value=value.value;
            _maxPoint=point;
         //   NSLog(@"ROW: %d , LINE:%d  score :%d",point.row,point.line,self.maxValue.value);
        }
    }
    [_values removeObjectAtIndex:_values.count-1];
    if (_values.count>0) {
        XHBGomokuValue * valueBottom=[_values lastObject];
        if (valueBottom.hasValue) {
            if (depth%2==0) {
                valueBottom.value=valueBottom.value<value.value?valueBottom.value:value.value;
            }else{
                valueBottom.value=valueBottom.value>value.value?valueBottom.value:value.value;
            }
        }else{
            valueBottom.value=value.value;
            valueBottom.hasValue=YES;
        }
    }
    return point;
}

-(void)pushLeafValue:(NSInteger)value
{
    XHBGomokuValue * valueBottom=[_values lastObject];
    valueBottom.hasValue=YES;
    valueBottom.value=value;
}

-(BOOL)pruning
{
    NSInteger depth=[self depth];
    if (depth>0) {
        XHBGomokuValue * bottomValue=[_values lastObject];
        XHBGomokuValue *secondValue;
        if (depth>1) {
            secondValue=[_values objectAtIndex:depth-2];
        }else if(self.maxValue){
            secondValue=self.maxValue;
        }
        if (secondValue) {
            if (depth%2==0) {
                if (bottomValue.value>=secondValue.value) {
                    return YES;
                }else{
                    return NO;
                }
            }else{
                if (bottomValue.value<=secondValue.value) {
                    return YES;
                }else{
                    return NO;
                }
            }
        }
    }
    return NO;
}



@end
