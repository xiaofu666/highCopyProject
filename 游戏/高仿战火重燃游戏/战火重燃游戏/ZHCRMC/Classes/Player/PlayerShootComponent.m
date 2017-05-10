
//
//  PlayerShootComponent.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerShootComponent.h"

#import "PlayingScene.h"

#import "Player.h"

#import "Bullet.h"
#import "BulletCache.h"

@implementation PlayerShootComponent


-(void) update:(ccTime)delta{
    shootInterval +=delta;
    if (!isShoot || !self.player) {     return;    }
    
    if (shootInterval >shootIntervalMax) {
        switch (shootType) {
            case clusterBomb_Bullet:
                [self startSpawnNormalBullet:self.player.GetShootPos];
                break;
            case laser_Bullet:
                [self startSpawnLaserBullet:self.player.GetShootPos interval:delta];
                //                shootIntervalMax = 0.0f;
                break;
            case pellet_Bullet:
                [self startSpawnPelletBullet:self.player.GetShootPos];
                break;
            default:
                break;
        }
        
        [self.player playShootEffect:shootType];
        shootInterval = 0.0f;
    }

}

#pragma mark weaponShoot

-(void) startSpawnNormalBullet:(CGPoint)startPos{
    CGPoint defaultStartPos =startPos;
    defaultStartPos.y -= 8 * bulletCount;
    startPos.x -= 9/2 * (bulletCount+1);
    for (int i=0 ; i<bulletCount; i++) {
        startPos.x +=8;
        CGFloat x1 = (bulletCount-1)*(bulletCount-1)*16 ;
        CGFloat x2 = (i - (bulletCount-1)/2.0)*((i - (bulletCount-1)/2.0)*16);
        CGFloat y = sqrtf(x1 -x2);
        startPos.y = defaultStartPos.y + y*4 -bulletLevel*2;
        Bullet * bullet = [Bullet bullet];
        
        BulletCache * bulletCache =[[PlayingScene SharedPlayingScene] getPlayerBulletCache];
        [bulletCache shootBulletAt:startPos velocity:CGPointMake(0, bulletSpeed) FrameName:bulletName isPlayerBullet:YES Bullet:bullet Damage:bulletDamage];
        
    }
    //    NSLog(@"%@",bulletName);
}

-(void) startSpawnPelletBullet:(CGPoint)startPos{
    CGPoint defaultStartPos =startPos;
    defaultStartPos.y -= 8 * bulletCount;
    startPos.x -= 9/2 * (bulletCount+1);
    for (int i=0 ; i<bulletCount; i++) {
        for (int j =0; j<2; j++) {
            startPos.x +=4.2;
            CGFloat x1 = (bulletCount-1)*(bulletCount-1)*16;
            CGFloat x2 = (i - (bulletCount-1)/2.0)*((i - (bulletCount-1)/2.0)*16);
            CGFloat y = sqrtf(x1 -x2);
            startPos.y = defaultStartPos.y + y*4 - bulletLevel*3;
            Bullet * bullet = [Bullet bullet];
            CGFloat velocityX = (i - (bulletCount-1)/2.0);
            bullet.rotation = velocityX *4;
            CGPoint velocity =ccpNormalize(CGPointMake(velocityX, bulletSpeed*2));
            
            BulletCache * bulletCache =[[PlayingScene SharedPlayingScene] getPlayerBulletCache];
            [bulletCache shootBulletAt:startPos velocity:ccpMult(velocity,bulletSpeed) FrameName:bulletName isPlayerBullet:YES Bullet:bullet Damage:bulletDamage];
        }
    }
}

-(void) startSpawnLaserBullet:(CGPoint)startPos interval:(ccTime)delta{
    startPos.y+=15;
    Bullet * bullet = [JiGuangBullet bullet];
    //    [batch addChild:bullet];
    //    [[PlayerBulletCache sharedPlayerBulletCache] shootBulletAt:startPos velocity:CGPointMake(0, bulletSpeed) FrameName:bulletName isPlayerBullet:YES Bullet:bullet Damage:bulletDamage];
    
    BulletCache * bulletCache =[[PlayingScene SharedPlayingScene] getPlayerBulletCache];
    [bulletCache shootBulletAt:startPos velocity:CGPointMake(0, bulletSpeed) FrameName:bulletName isPlayerBullet:YES Bullet:bullet Damage:bulletDamage];
}

#pragma mark - addWeaponShoot

-(void) targetShoot:(ccTime)delta{
    addWeaponInrerval += delta;
    if (addWeaponInrerval>addWeaponIntervalMax) {
        addWeaponInrerval = 0;
    }else return;
    
    if (isShoot && addWeaponLevel) {
        Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
        if ([[PlayingScene SharedPlayingScene] getPlayerType] ) {
            [self targetBulletshoot:[player GetLeftShootPosition] Where:0];
            [self targetBulletshoot:[player GetRightShootPosition] Where:1];
        }
        else{
            [self normalShoot:[player GetLeftShootPosition] Where:0];
            [self normalShoot:[player GetRightShootPosition] Where:1];
        }
    }
}

-(void) targetBulletshoot:(CGPoint)startPos Where:(NSInteger)where{
    
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getPlayerBulletCache];
    
    for (int i=0;i<addWeaponLevel; i++) {
        TargetBullet * targetBullet = [TargetBullet bullet];
        targetBullet.allowedTarget = YES;
        int j;
        if (where) {
            j=1;
        }else{
            j=-1;
        }
        [bulletCache shootBulletAt:startPos velocity:CGPointMake(j*(i+1), -i) FrameName:@"b" isPlayerBullet:YES Bullet:targetBullet Damage:25];
    }
}
-(void) normalShoot:(CGPoint)startPos Where:(NSInteger)where{
    
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getPlayerBulletCache];
    
    for (int i=0;i<addWeaponLevel+1; i++) {
        TargetBullet * bullet = [TargetBullet bullet];
        bullet.allowedTarget = NO;
        int j;
        if (where) {
            j=1;
        }else{
            j=-1;
        }
        [bulletCache shootBulletAt:startPos velocity:CGPointMake(j*(i+1), -i) FrameName:@"a" isPlayerBullet:YES Bullet:bullet Damage:25];
    }
}

#pragma mark - bullet Setting
-(void) setShootType:(PlayerShootType)type{
    if (shootType == type) {
//        [self setBulletLevel:bulletLevel+1];
        bulletLevel++;
    }else{
        if (!bulletLevel) {
//            [self setBulletLevel:1];
            bulletLevel = 1;
        }
    }
    shootType = type;
    switch (type) {
        case clusterBomb_Bullet:
            bulletName = @"dl_pe_a_041.png";
            shootIntervalMax = 0.33f;
            bulletSpeed = 5;
            break;
        case laser_Bullet:
            bulletName = @"dl_pe_b_071.png";
            bulletSpeed = 8;
            break;
        case pellet_Bullet:
            bulletName = @"dl_pe_a_031.png";
            shootIntervalMax = 0.5f;
            bulletSpeed = 5;
            break;
        default:
            break;
    }
    [self setBulletLevel:bulletLevel];
}

-(void) setBulletLevel:(NSInteger)le{
    bulletLevel = le;
    if (bulletLevel>=3) {
        bulletLevel=3;
    }
    bulletCount = 3+(bulletLevel-1)*2;
    switch (shootType) {
        case clusterBomb_Bullet:
            bulletDamage =10;//2<<(bulletLevel-1);
            break;
        case laser_Bullet:
                if (bulletLevel==2){
                    shootIntervalMax = 0.2f;
//                    bulletName = @"dl_pe_a_06.png";
                }else if (bulletLevel ==3){
                    shootIntervalMax = 0.125;
//                    bulletName = @"dl_pe_a_07.png";
                }else{
                    shootIntervalMax = 0.3;
//                    bulletName = @"dl_pe_a_05.png";
                }
            bulletDamage =40;//3*(2<<(bulletLevel-1))/5;
            break;
        case pellet_Bullet:
            bulletDamage =15;//2<<(bulletLevel-1)/2;
            break;
        default:
            break;
    }
    
//    bulletDamage *= 100;
}

-(void) SetIsShoot:(BOOL)isSh{
    isShoot = isSh;
}

-(void) resetShootComponent{
    isInTemporaryAddWeapon = NO;
    beforeTemporaryAddWeaponLevel = 0;
    [self unschedule:@selector(endTemporaryAddWeapon)];
    isShoot = NO;
    addWeaponLevel = 0;
    bulletLevel = 0;
//    bulletCount = 3;
    [self setShootType:clusterBomb_Bullet];
}


-(void)setAddWeaponLevel:(NSInteger)level{
    if (isInTemporaryAddWeapon) {
        beforeTemporaryAddWeaponLevel++;
        if (beforeTemporaryAddWeaponLevel>3) {
            beforeTemporaryAddWeaponLevel = 3;
        }
        return;
    }
    addWeaponLevel = level;
    addWeaponIntervalMax = 1.0;
    if (addWeaponLevel>=3) {
        addWeaponLevel = 3;
    }
}

-(void)temporaryAddAddWeapon{ // 临时增加 weapon
    isInTemporaryAddWeapon = YES;
    beforeTemporaryAddWeaponLevel = addWeaponLevel;
    addWeaponIntervalMax = 0.2;
    addWeaponLevel = 3;
    [self scheduleOnce:@selector(endTemporaryAddWeapon) delay:4];
}

-(void) endTemporaryAddWeapon{
    if (!isInTemporaryAddWeapon) {
        return;
    }
    isInTemporaryAddWeapon = NO;
    addWeaponIntervalMax = 0.8;
    addWeaponLevel = beforeTemporaryAddWeaponLevel;
}

-(NSInteger) getBulletLevel{
    return bulletLevel;
}
-(NSInteger)getBulletType{
    return shootType;
}
-(NSInteger) getAddBulletLevel{
    if (isInTemporaryAddWeapon) {
        return beforeTemporaryAddWeaponLevel;
    }
    return addWeaponLevel;
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        isShoot = NO;
        bulletName = nil;
        isInTemporaryAddWeapon = NO;
//        bulletLevel =2;
//        bulletCount =7;
//        addWeaponLevel = 0;
//        [self setShootType:pellet_Bullet];
    }
    return self;
}
-(void)onEnter{
    [super onEnter];
    [self scheduleUpdate];
    
//    [self schedule:@selector(update:) interval:0.3];
    [self schedule:@selector(targetShoot:) interval:0.1];
}

@end
