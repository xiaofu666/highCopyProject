//
//  Player.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"
#import "cocos2d.h"
#import "Base.h"
@class PlayerMoveComponent;
@class PlayerShootComponent;

@interface Player : Base {
    NSInteger lifeCount;
    NSInteger lifeMax;
    CGFloat health;
    CGFloat speed;
    
    PlayerShipState currentState;
    
    CCSprite * shootEffect;
    
    PlayerMoveComponent * moveComponent;
    PlayerShootComponent * shootComponent;
    
    BOOL isdeath;
    BOOL canEatArt;
    
//    BOOL isInAddWeaponCooding;
}

@property(nonatomic,strong) id idle_Action;
@property(nonatomic,strong) id move_Action;
@property(nonatomic,strong) id death_Action;


-(void) ChangeWeapon:(NSInteger) weaponType;
-(void) playShootEffect:(PlayerShootType)effectType;

-(void) addPlayerLife;
-(void) setPlayerLife:(NSInteger)life;
-(void) setVelocity:(CGPoint)veloc;
-(void) setTemporityAddWeapon;
-(void) setAddWeaponLevelAdd:(NSInteger) level;
-(void) setPlayerWeaponLevel:(NSInteger) weaponLevel WeaponType:(NSInteger) weaponType AddWeaponLevel:(NSInteger) addWeaponLevel;

-(void) spawn;

-(NSInteger)    GetLifeMax;
-(NSInteger)    GetLifeCount;
-(CGPoint)      GetShootPos;
-(CGPoint)      GetLeftShootPosition;
-(CGPoint)      GetRightShootPosition;
-(NSInteger)    GetWeaponLevel;
-(NSInteger)    GetWeaponType;
-(NSInteger)    GetShootComponentAddWeaponLevel;
-(CGRect)       GetEatArtRect;

@end


@interface PlayerOne : Player

@end
@interface PlayerTwo : Player

@end
