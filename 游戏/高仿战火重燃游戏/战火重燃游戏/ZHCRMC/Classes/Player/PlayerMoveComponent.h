//
//  PlayerMoveComponent.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Player;
@interface PlayerMoveComponent : CCNode<CCTargetedTouchDelegate>  {
    CGPoint touchLocation;
    CGPoint lastPos;
    CGPoint veloc;
}
@property(assign,nonatomic) Player * componentParent;

@end
