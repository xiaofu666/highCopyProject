//
//  Base.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Base : CCSprite {
    CGPoint velocity;
    CGRect screenRect;
}
-(void) Death;
-(void) isInScreenRect;
-(CGRect) GetDamageRect;
-(void) update:(ccTime)delta;
-(void) takeDamage:(CGFloat)damage;
-(id)LoadAnimationActionEndFrame:(NSInteger) frame StartFram:(NSInteger)startFrame Delta:(CGFloat)delta AnimateName:(NSString*) animateName AnimateCacheName:(NSString *) animateCacheName;
@end
