//
//  XHBGomokuBaseStack.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHBGomokuChessPoint.h"
@interface XHBGomokuBaseStack : NSObject

-(NSInteger)depth;
-(void)push:(XHBGomokuChessPoint*)element;
-(XHBGomokuChessPoint*)pop;
-(void)reuse;
-(XHBGomokuChessPoint*)getTopElement;
@end
