//
//  BulletCache.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BulletCache.h"

#import "Player.h"
#import "PlayingScene.h"
#import "Bullet.h"

@implementation BulletCache

- (id)init
{
    self = [super init];
    if (self) {
        canShoot = NO;
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_pe_a_041.png"];
		// use the bullet's texture (which will be the Texture Atlas used by the game)
		batchNode = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        [self addChild:batchNode];
    }
    return self;
}

-(void)Setcanshoot:(BOOL)cS{
    canShoot = cS;
}

-(void)shootNuke{
//    NukeBomb * nuke = [NukeBomb node];
//    nuke.playerPlayingScene = gamePlayingScene;
//    [self addChild:nuke];
}
-(void)cleanUpAllBullet{
    [batchNode removeAllChildrenWithCleanup:YES];
}

-(void) shootAddWeapon{
    
}

-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel FrameName:(NSString *)frameName isPlayerBullet:(bool)playerBullet Bullet:(Bullet *)bullet Damage:(CGFloat)damage{
    if (!canShoot) {
        return;
    }
    [batchNode addChild:bullet];
    [bullet shootBulletAt:startPosition velocity:vel frameName:frameName isPlayerBullet:playerBullet Damage:damage];
}

-(void)ShootOneBullet:(CGPoint)stP FrameName:(NSString *)frameName{
    if (!canShoot) {
    return;
    }
    Player * target = [[PlayingScene SharedPlayingScene] getPlayer];
    Bullet * bullet = [Bullet bullet];
    CGPoint vel = ccpNormalize(ccpSub(target.position, stP));
    vel = ccpMult(vel, EnemyBulletSpeed);
    [self shootBulletAt:stP velocity:vel FrameName:frameName isPlayerBullet:NO Bullet:bullet Damage:1];
}

-(void)ShootThreeBullet:(CGPoint)stP FrameName:(NSString *)frameName{
    if (!canShoot) {
        return;
    }
    enemyDaoDanBullet * bullet = [enemyDaoDanBullet bullet];
    CGPoint vel = ccp(0,-1);
    vel = ccpMult(vel, EnemyBulletSpeed);
    [self shootBulletAt:stP velocity:ccpMult(vel ,3) FrameName:frameName isPlayerBullet:NO Bullet:bullet Damage:1];
}

-(void)ShootOneBulletAndRotateTo:(CGPoint)stP FrameName:(NSString *)frameName{
    if (!canShoot) {
        return;
    }
    Player * target = [[PlayingScene SharedPlayingScene] getPlayer];
    Bullet * bullet = [Bullet bullet];
    CGPoint vel = ccpNormalize(ccpSub(target.position, stP));
    vel = ccpMult(vel, EnemyBulletSpeed);
    
    CGFloat degree =CC_RADIANS_TO_DEGREES(ccpToAngle(vel));
    bullet.rotation = degree;
    
    [self shootBulletAt:stP velocity:ccpMult(vel ,3)FrameName:frameName isPlayerBullet:NO Bullet:bullet Damage:1];
}

@end
