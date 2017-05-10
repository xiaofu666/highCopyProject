//
//  PlayerShootComponent.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
@class Player;
@interface PlayerShootComponent : CCNode {
    NSInteger bulletLevel;
    NSInteger bulletCount;
    NSInteger bulletDamage;
    
    NSInteger addWeaponLevel;
    
    CGFloat bulletSpeed;
    CGFloat shootInterval;
    CGFloat shootIntervalMax;
    
    CGFloat addWeaponInrerval;
    CGFloat addWeaponIntervalMax;
    NSInteger beforeTemporaryAddWeaponLevel;
    
    NSString * bulletName;
    
    PlayerShootType shootType;
    
    BOOL isShoot;
    BOOL isInTemporaryAddWeapon;//是否在零时增加addweapon
}

@property(nonatomic,assign) Player * player;

-(void) setShootType:(PlayerShootType)type;
-(void) SetIsShoot:(BOOL)isSh;
-(void) resetShootComponent;
//-(void) setAddWeaponLevel;
-(void) setBulletLevel:(NSInteger)le;
-(void) setAddWeaponLevel:(NSInteger) level;

-(void) temporaryAddAddWeapon;

-(NSInteger) getBulletLevel;
-(NSInteger) getBulletType;
-(NSInteger) getAddBulletLevel;
@end
