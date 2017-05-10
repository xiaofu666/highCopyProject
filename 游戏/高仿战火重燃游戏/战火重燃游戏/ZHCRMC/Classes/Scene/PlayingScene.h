//
//  PlayingScene.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define BackgroundTag 999

@class NukeBullet;
@class HudLayer;
@class Player;
@class BulletCache;
@class LevelController;
@class EnemyCache;
@class DropArticleCache;

@interface PlayingScene : CCScene {
    NSInteger       playerPoint;
    NSInteger       damageEnemyCount;
    NSInteger       playerNukeCount;
    NSInteger       playerType;
    NSInteger       gameLevel;
    
    HudLayer        * hudLayer;
    Player          * player;
    BulletCache     * bulletCache;
    LevelController * levelController;
    EnemyCache      * enemyCache;
    BulletCache     * playerBulletCache;
    DropArticleCache* dropArticleCache;
    
    NukeBullet      * nukeEffect;
    
    
    
    
    BOOL two;
    BOOL four;
    BOOL six;
    BOOL eight;
    
}

+(id) SharedPlayingScene;

-(Player*)          getPlayer;
-(EnemyCache*)      getEnemyCache;
-(HudLayer*)        getHudlayer;
-(BulletCache*)     getBulletCache;
-(LevelController*) getLevelController;
-(BulletCache * )   getPlayerBulletCache;
-(DropArticleCache*)getDropActicleCache;

-(NSInteger)        getPlayerPoint;
-(NSInteger)        getPlayerType;
-(NSInteger)        getLevel;

-(void)             setPoint:(NSInteger) point;
-(void)             resetNukeCount:(NSInteger) nuke;
-(void)             setDamageEnemyCount;

-(void) gameOver;
-(void) currentLevelOver;
-(void) startNextLevel;

-(void) shootNuke;

-(void) shootAddWeapon;

-(void) startGameWithLevel:(NSInteger)level PlayerType:(NSInteger)playerTypeT playerLifeCount:(NSInteger)life PlayerPoint:(NSInteger)point damageEnemyCount:(NSInteger) enemyCount NukeCount:(NSInteger) nukeCount AddWeaponLevel:(NSInteger)addweaponLevel WeaponLevel:(NSInteger) weaponLevel bulletType:(NSInteger) bulletType;

-(void) pauseGame;

-(void) drawPlayerlife:(NSInteger) lifeC;

@end
