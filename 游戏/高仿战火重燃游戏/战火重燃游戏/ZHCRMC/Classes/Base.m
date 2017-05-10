//
//  Base.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Base.h"


@implementation Base


-(void)update:(ccTime)delta{
    
}

-(void)takeDamage:(CGFloat)damage{
    
}
-(void)isInScreenRect{
    if(!CGRectContainsPoint(screenRect, self.position)){
        [self Death];// Death];
    }
}

-(CGRect)GetDamageRect{
    return CGRectZero;
}
-(void)Death{
    
}

-(id)LoadAnimationActionEndFrame:(NSInteger) frame StartFram:(NSInteger)startFrame Delta:(CGFloat)delta AnimateName:(NSString*) animateName AnimateCacheName:(NSString *) animateCacheName{
    NSMutableArray * frameArray = [NSMutableArray arrayWithCapacity:frame];
    for (int i = startFrame; i <= frame ; i++){
        CCSpriteFrame * frames = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[animateName stringByAppendingFormat:@"%d.png", i]];
        //NSLog(@"%@",[animateName stringByAppendingFormat:@"%02d.png", i]);
        [frameArray addObject:frames];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frameArray delay:delta];
    //[[CCAnimationCache sharedAnimationCache]addAnimation:animation name:animateCacheName];
    id action = [CCAnimate actionWithAnimation:animation];
    return action;
}

- (id)init
{
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector]winSize];
        screenRect = CGRectMake(-1, -1, size.width+1, size.height+1);
    }
    return self;
}
@end
