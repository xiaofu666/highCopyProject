//
//  XHBGomokuGameEngine.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

// 游戏引擎

#import <Foundation/Foundation.h>
#import "XHBGomokuChessPoint.h"
#import "XHBGomokuEnvisionStack.h"
#import "XHBGomokuChessboard.h"
typedef NS_ENUM(NSUInteger, XHBGameSoundType) {
    XHBGameSoundTypeError,
    XHBGameSoundTypeStep,
    XHBGameSoundTypeVictory,
    XHBGameSoundTypeFailed,
    XHBGameSoundTypeTimeOver
};

typedef NS_ENUM(NSUInteger, XHBGameErrorType) {
    XHBGameErrorTypeChessAxist,
    XHBGameErrorTypeComputerIsChessing,
};

typedef NS_ENUM(NSUInteger, XHBGameStatu) {
    XHBGameStatuPlayChessing,
    XHBGameStatuComputerChessing,
    XHBGameStatuFinished
};


@class XHBGomokuGameEngine;
@protocol XHBGomokuGameEngineProtocol <NSObject>

-(void)game:(XHBGomokuGameEngine*)game updateSences:(XHBGomokuChessPoint*)point;

-(void)game:(XHBGomokuGameEngine*)game finish:(BOOL)success;

-(void)game:(XHBGomokuGameEngine*)game error:(XHBGameErrorType)errorType;

-(void)game:(XHBGomokuGameEngine*)game playSound:(XHBGameSoundType)soundType;

-(void)game:(XHBGomokuGameEngine *)game statuChange:(XHBGameStatu)gameStatu;

-(void)gameRestart:(XHBGomokuGameEngine*)game;

-(void)game:(XHBGomokuGameEngine*)game undo:(XHBGomokuChessPoint*)point;


@end

@interface XHBGomokuGameEngine : NSObject

@property(nonatomic,strong)id<XHBGomokuGameEngineProtocol>delegate;
@property(nonatomic,strong)XHBGomokuEnvisionStack * envisionStack;
@property(nonatomic,strong)XHBGomokuChessboard * chessBoard;
@property(nonatomic)XHBGameStatu gameStatu;
@property(nonatomic)NSInteger maxDepth;
@property(nonatomic)BOOL playerFirst;  //  YES : 玩家先手（黑棋）  NO :玩家后手(白棋)

+(instancetype)game;

-(void)playerChessDown:(NSInteger)row line:(NSInteger)line;

-(void)reStart;

-(BOOL)undo;

-(void)begin;


@end
