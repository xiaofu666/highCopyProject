//
//  XHBGomokuBaseStack.m
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuBaseStack.h"

@interface XHBGomokuBaseStack ()
@property(nonatomic,strong)NSMutableArray * datas;
@end

@implementation XHBGomokuBaseStack

-(void)reuse
{
    _datas=[NSMutableArray array];
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        _datas=[NSMutableArray array];
    }
    return self;
}

-(void)push:(XHBGomokuChessPoint*)element
{
    if (element) {
        [element statuChanged];
        [_datas addObject:element];
    }
}

-(XHBGomokuChessPoint*)pop
{
    if (_datas.count==0) {
        return nil;
    }
    XHBGomokuChessPoint * point=[_datas objectAtIndex:_datas.count-1];
    point.chess=nil;
    [point statuChanged];
    [_datas removeObjectAtIndex:_datas.count-1];
    return point;
}
-(NSInteger)depth
{
    return _datas.count;
}

-(XHBGomokuChessPoint*)getTopElement
{
    return [_datas lastObject];
}

@end
