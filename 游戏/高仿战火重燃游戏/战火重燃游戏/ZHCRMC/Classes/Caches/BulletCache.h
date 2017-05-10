//
//  BulletCache.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
@class Bullet;
@interface BulletCache : CCNode {
    CCSpriteBatchNode * batchNode;
    BOOL canShoot;
}

-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel FrameName:(NSString*)frameName isPlayerBullet:(bool)playerBullet Bullet:(Bullet *) bullet Damage:(CGFloat)damage;

-(void) shootNuke;
-(void) Setcanshoot:(BOOL) cS;

-(void) cleanUpAllBullet;

-(void) shootAddWeapon;

-(void) ShootOneBullet:(CGPoint)stP FrameName:(NSString *) frameName;
-(void) ShootThreeBullet:(CGPoint)stP FrameName:(NSString *) frameName;

-(void)ShootOneBulletAndRotateTo:(CGPoint)stP FrameName:(NSString *)frameName;
@end
