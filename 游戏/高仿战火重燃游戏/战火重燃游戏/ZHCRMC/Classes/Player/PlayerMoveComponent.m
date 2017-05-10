//
//  PlayerMoveComponent.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerMoveComponent.h"
#import "Player.h"


@implementation PlayerMoveComponent

-(id)init{
    if (self = [super init]) {
        veloc = ccp(0, 1);
        [[[CCDirector sharedDirector]touchDispatcher ]addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self scheduleUpdate];
    }
    return self;
}
-(void) update:(ccTime) delta{
    if (self.componentParent == nil) {
        return;
    }
    
    if (CGPointEqualToPoint(lastPos, touchLocation)) {
        [self.componentParent setVelocity:ccp(0, 0)];
    }else{
        veloc = ccpSub( touchLocation,lastPos);
        veloc = ccpNormalize(veloc);
        [self.componentParent setVelocity:ccpMult(veloc,7)];
        lastPos = touchLocation;
    }
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!self.componentParent) {
        return NO;
    }
    touchLocation = [self convertTouchToNodeSpace:touch];
    //
    touchLocation = [self convertToWorldSpace:touchLocation];
    lastPos = touchLocation;
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!self.componentParent) {
        return ;
    }
    CGPoint pos = [self convertTouchToNodeSpace:touch];
    pos = [self convertToWorldSpace:pos];
    if (ccpDistance(touchLocation, pos)<3) {
        return;
    }
    touchLocation = pos;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!self.componentParent) {
        return ;
    }
    [self.componentParent setVelocity:ccp(0, 0)];
}
-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!self.componentParent) {
        return;
    }
    [self.componentParent setVelocity:ccp(0, 0)];
}

-(void)onEnter{
    [super onEnter];
}

-(void)onExit{
    [[[CCDirector sharedDirector]touchDispatcher ]removeDelegate:self];
}
- (void)dealloc
{
    [super dealloc];
}
@end
