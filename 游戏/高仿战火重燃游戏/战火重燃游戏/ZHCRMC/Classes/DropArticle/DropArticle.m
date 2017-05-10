//
//  DropArticle.m
//  ZHCR
//
//  Created by jiangyu on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DropArticle.h"

#import "Player.h"
#import "PlayingScene.h"

@implementation DropArticle

-(void)update:(ccTime) delta{
    interval += delta;
    self.position = ccpAdd(self.position, velocity);
    
    [self isOutsideScreenArea];
    if (!isdeath) {
        [self checkCollisionWithPlayer];
    }
}
-(void) checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene ] getPlayer];
    
    if (CGRectIntersectsRect([player GetEatArtRect], self.boundingBox)) {
        [self unscheduleAllSelectors];
        [self AddPropertyForShip];
        [self removeFromParentAndCleanup:YES];
    }
}

-(void)spawnAt:(CGPoint)pos{
    self.position = pos;
    startPos = pos;
}

-(CGPoint)setPos:(CGPoint)pos{
    
    float halfWidth = self.contentSize.width * 0.5f;
    float halfHeight = self.contentSize.height * 0.5f;
    
    CGPoint veloc = ccpSub(pos, startPos);
    veloc = ccpNormalize(veloc);
    if (pos.x<=halfWidth+1 || pos.x>=screenRect.size.width - halfWidth -1) {
        velocity = ccp(veloc.x*-1, veloc.y);
        startPos = pos;
//        NSLog(@"velocity x:%f y:%f",velocity.x,velocity.y);
    }
    if (pos.y<=halfHeight +1 || pos.y>=screenRect.size.height - halfHeight -1) {
        velocity = ccp(veloc.x, veloc.y*-1);
        startPos = pos;
//        NSLog(@"velocity x:%f y:%f",velocity.x,velocity.y);
    }
    
    if (CGRectContainsRect(screenRect, [self boundingBox]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		if (pos.x < halfWidth)
		{
			pos.x = halfWidth;
		}
		else if (pos.x > (screenSize.width - halfWidth))
		{
			pos.x = screenSize.width - halfWidth;
		}
		
		if (pos.y < halfHeight)
		{
			pos.y = halfHeight;
		}
		else if (pos.y > (screenSize.height - halfHeight))
		{
			pos.y = screenSize.height - halfHeight;
		}
	}
    //	velocity = CGPointZero;
    return pos;
}


-(void) AddPropertyForShip{
    
}

-(void) isOutsideScreenArea{
	if (!CGRectContainsRect(screenRect, [self boundingBox])){
        isdeath = YES;
        [self death];
    }
}

-(void) death{
    [self stopAllActions];
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES]; 
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        isdeath = NO;
    }
    return self;
}
-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
}
- (void)dealloc
{
    [super dealloc];
}
@end


@implementation BulletTypeArct

-(void)setPosition:(CGPoint)position{
    CGPoint pos = [self setPos:position];
    [super setPosition:pos];
}

-(void)spawnAt:(CGPoint)pos{
    [super spawnAt:pos];
    CGFloat angel = arc4random()/(float)ARC4RANDOM_MAX * 360;
    velocity = ccp(sinf(angel), cosf(angel));
}

-(void)AddPropertyForShip{
    Player * player = [[PlayingScene SharedPlayingScene]getPlayer];
    [player ChangeWeapon:actionIndex];
}
-(void) ChangeAnimation{
    actionIndex++;
    if (actionIndex>=3) {
        actionIndex =0;
    }
    [self stopAllActions];
    id action = [actionArray objectAtIndex:actionIndex];
    if (interval>13) {
        CCTintTo * tint = [CCTintTo actionWithDuration:0.1 red:252 green:0 blue:242];
        CCTintTo * tintback = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
        id sequence = [CCSequence actionOne:tint two:tintback];
        id spawn = [CCSpawn actionOne:action two:sequence];
        [self runAction:[CCRepeat actionWithAction:spawn times:3]];
    }else
        [self runAction:[CCRepeat actionWithAction:action times:3]];
}
-(void)update:(ccTime)delta{
    [super update:delta];
    if (interval >20) {
        [self removeFromParentAndCleanup:YES];
    }
}
-(void)onEnter{
    [self unscheduleAllSelectors];
    actionIndex = 0;
    id action1 = [self LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_01" AnimateCacheName:@"lll"];
    id action2 = [self LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_02" AnimateCacheName:@"rrr"];
    id action3 = [self LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_03" AnimateCacheName:@"sss"];
    actionArray = [[NSArray alloc]initWithObjects:action2,action3,action1, nil];
    [super onEnter];
    [self runAction:[CCRepeat actionWithAction:action2 times:3]];
    [self schedule:@selector(ChangeAnimation) interval:1.8];
}
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)dealloc{
    [actionArray release];
    [super dealloc];
}
@end

@implementation BulletLevelArct

-(void)setPosition:(CGPoint)position{
    CGPoint pos = [self setPos:position];
    [super setPosition:pos];
}

-(void)AddPropertyForShip{
    Player * player = [[PlayingScene SharedPlayingScene]getPlayer];
    [player setAddWeaponLevelAdd:1];
}

-(void)spawnAt:(CGPoint)pos{
    [super spawnAt:pos];
    CGFloat angel = arc4random()/(float)ARC4RANDOM_MAX * 360;
    velocity = ccp(sinf(angel), cosf(angel));
}

-(void)update:(ccTime)delta{
    [super update:delta];
    if (interval>15 && !hasChangeColor) {
        hasChangeColor = YES;
        [self stopAllActions];
        id action = [self  LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_05" AnimateCacheName:@"addlevel"];
        CCTintTo * tint = [CCTintTo actionWithDuration:0.1 red:252 green:0 blue:242];
        CCTintTo * tintback = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
        id sequence = [CCSequence actionOne:tint two:tintback];
        id spawn = [CCSpawn actionOne:action two:sequence];
        [self runAction:[CCRepeatForever actionWithAction:spawn]];
    }
    if (interval>20) {
        [self removeFromParentAndCleanup:YES];
    }
}

-(void)onEnter{
    [self unscheduleAllSelectors];
    hasChangeColor = NO;
    id action = [self  LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_05" AnimateCacheName:@"addlevel"];
    [super onEnter];
    [self runAction:[CCRepeatForever actionWithAction:action]];
}

@end

@implementation PointArct

-(void)spawnAt:(CGPoint)pos{
    [super spawnAt:pos];
    velocity = ccp(0, -0.5);
}

-(void)AddPropertyForShip{
//    Player * player = [[PlayingScene SharedPlayingScene]getPlayer];
    [[PlayingScene SharedPlayingScene] setPoint:100];
}

-(void)onEnter{
    [self unscheduleAllSelectors];
    
    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xunzhang.png"];
    [self setDisplayFrame:frame];
    
    [super onEnter];
}

@end

@implementation NukeArct

-(void)setPosition:(CGPoint)position{
    CGPoint pos = [self setPos:position];
    [super setPosition:pos];
}

-(void)spawnAt:(CGPoint)pos{
    [super spawnAt:pos];
    CGFloat angel = arc4random()/(float)ARC4RANDOM_MAX * 360;
    velocity = ccp(sinf(angel), cosf(angel));
}

-(void)AddPropertyForShip{
//    Player * player = [[PlayingScene SharedPlayingScene]getPlayer];
    [[PlayingScene SharedPlayingScene] resetNukeCount:1];
}

-(void)onEnter{
    [self unscheduleAllSelectors];
    id action = [self  LoadAnimationActionEndFrame:3 StartFram:1 Delta:0.2 AnimateName:@"dl_ui_d_04" AnimateCacheName:@"addlevel"];
    [super onEnter];
    [self runAction:[CCRepeatForever actionWithAction:action]];
}
@end
