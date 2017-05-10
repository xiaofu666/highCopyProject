//
//  XHBGomokuChessElement.m
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import "XHBGomokuChessElement.h"

@implementation XHBGomokuChessElement
+(instancetype)getChess:(XHBGomokuChessType)type
{
    XHBGomokuChessElement * chess=[[XHBGomokuChessElement alloc]initWithType:type];
    return chess;
    
}
-(instancetype)initWithType:(XHBGomokuChessType)type{
    self=[super init];
    if (self) {
        _type=type;
    }
    return self;
}

@end
