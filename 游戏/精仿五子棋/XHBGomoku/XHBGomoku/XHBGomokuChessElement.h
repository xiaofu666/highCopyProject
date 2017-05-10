//
//  XHBGomokuChessElement.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

// 棋子
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XHBGomokuChessType) {
    XHBGomokuChessTypeEmpty=0, // 空白
    XHBGomokuChessTypeBlack=1, // 黑子
    XHBGomokuChessTypeWhite=2, // 白子
};

@interface XHBGomokuChessElement : NSObject
@property(nonatomic,readonly) XHBGomokuChessType type;
+(instancetype)getChess:(XHBGomokuChessType)type;
@end
