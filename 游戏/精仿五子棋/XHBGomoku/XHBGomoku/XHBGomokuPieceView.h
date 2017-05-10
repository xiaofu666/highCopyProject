//
//  XHBGomokuPieceView.h
//  XHBGomoku
//
//  Created by weqia on 14-9-1.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHBGomokuChessPoint.h"
@interface XHBGomokuPieceView : UIView
@property(nonatomic,strong)XHBGomokuChessPoint * point;
+(instancetype)piece:(XHBGomokuChessPoint*)point;
-(void)setSelected:(BOOL)selected;

@end
