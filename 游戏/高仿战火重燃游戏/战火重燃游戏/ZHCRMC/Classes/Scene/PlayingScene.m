//
//  PlayingScene.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayingScene.h"

#import "PlayingBackground.h"

#import "Player.h"
#import "BulletCache.h"
#import "HudLayer.h"
#import "EnemyCache.h"
#import "LevelController.h"
#import "DateHandle.h"
#import "Bullet.h"
#import "DropArticleCache.h"


@implementation PlayingScene

static PlayingScene * _sharedPlayingScene = nil;

+(id)SharedPlayingScene{
    if (!_sharedPlayingScene) {
        _sharedPlayingScene = [[[self alloc]init]autorelease];
        return _sharedPlayingScene;
    }
    return _sharedPlayingScene;
}

- (void)dealloc
{
    _sharedPlayingScene = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        two = NO;
        four = NO;
        six = NO;
        eight = NO;
    }
    return self;
}

#pragma mark - shoot Nuke AddWeapon

-(void)shootNuke{
    if (playerNukeCount) {
        if ([self PlayNukeEffect]) {
            playerNukeCount -- ;
            [hudLayer resetNukeButtonImage:playerNukeCount];
        }
    }
}

-(BOOL) PlayNukeEffect{
    if (nukeEffect && !nukeEffect.isInBombing) {
        [nukeEffect runNukeEffectAction];
        return YES;
    }
    return NO;
}

-(void)shootAddWeapon{
    if (player) {
        [player setTemporityAddWeapon];
    }
}


#pragma mark - startGame

-(void)gameOver{
    
    NSInteger life = [player GetLifeMax]-[player GetLifeCount];
    [hudLayer GameOverwithPlayerLife:life DamageEnemyCount:damageEnemyCount GetPoint:playerPoint];
}

-(void)currentLevelOver{
    [levelController CurrentLevelEnd];
    
    [bulletCache Setcanshoot:NO];
    [playerBulletCache Setcanshoot:NO];
    [enemyCache clearnAllEnemy];
    [enemyCache setCurrentLevelEnd:YES];
    gameLevel ++;
    PlayerSaveDate date;
    if (gameLevel>5) {
        date.level = 5;
    }else date.level = gameLevel;
    
    date.flyType        = playerType;
    date.life           = [player GetLifeCount];
    date.point          = playerPoint;
    date.nukeCount      = playerNukeCount;
    date.enemyDamaged   = damageEnemyCount;
    date.addweaponLevel = [player GetShootComponentAddWeaponLevel];
    date.weaponType     = [player GetWeaponType];
    date.weaponLevel    = [player GetWeaponLevel];
    
    [[DateHandle SharedDateHandle] SaveCurrentLevelPassedDateWithStruct:date];
    
    [bulletCache cleanUpAllBullet];
    
    NSInteger life = 4 -[player GetLifeCount];
    [hudLayer drawCurrentGameEndwithPlayerLife:life DamageEnemyCount:damageEnemyCount GetPoint:playerPoint];
}
-(void)startNextLevel{
    
    [self loadBackground:gameLevel];
    [levelController loadCurrentLevel:gameLevel];//gameLevel
    [bulletCache Setcanshoot:YES];
    [playerBulletCache Setcanshoot:YES];
    [enemyCache setCurrentLevelEnd:NO];
    [dropArticleCache cleanAllDrop];
}

-(void)startGameWithLevel:(NSInteger)level PlayerType:(NSInteger)playerTypeT playerLifeCount:(NSInteger)life PlayerPoint:(NSInteger)point damageEnemyCount:(NSInteger)enemyCount NukeCount:(NSInteger)nukeCount AddWeaponLevel:(NSInteger)addweaponLevel WeaponLevel:(NSInteger)weaponLevel bulletType:(NSInteger)bulletType{
    
    damageEnemyCount = enemyCount;
    gameLevel = level;
    
    dropArticleCache = [DropArticleCache node];
    [self addChild:dropArticleCache];
    
    
    enemyCache  = [EnemyCache node];
    [self addChild:enemyCache];
    
    
    playerType = playerTypeT;
    if (playerType) {
        player = [PlayerTwo node];
    }else{
        player = [PlayerOne node];
    }
    
    [player setPlayerLife:life];
    [self addChild:player];
    [player spawn];
    
    
    
    bulletCache = [BulletCache node];
    [self addChild:bulletCache];
    
    
    playerBulletCache = [BulletCache node];
    [self addChild:playerBulletCache];
    
    
    
    nukeEffect = [NukeBullet node];
    CGSize size = [[CCDirector sharedDirector] winSize];
    nukeEffect.position = ccp(size.width/2,size.height/2);
    [self addChild:nukeEffect];
    
    hudLayer  = [HudLayer node];
    [self addChild:hudLayer];
    
    levelController =[LevelController node];
    [self addChild:levelController];
    
    
    
    playerPoint = point;
    playerNukeCount = nukeCount;
    [hudLayer resetPoint:playerPoint];
    [hudLayer resetNukeButtonImage:playerNukeCount];
    [player setPlayerWeaponLevel:weaponLevel WeaponType:bulletType AddWeaponLevel:addweaponLevel];
    [self drawPlayerlife:life];
    
    
    if (point>=20000) {
        two = YES;
    }
    if (point >=40000) {
        four = YES;
    }
    if (point>=60000) {
        six = YES;
    }
    if (point >=80000) {
        eight = YES;
    }
    
    [self startNextLevel];
}

-(void) loadBackground:(NSInteger) level{
    CCNode * node = [self getChildByTag:BackgroundTag];
    if (node) {
        [node removeFromParentAndCleanup:YES];
    }
    switch (level) {
        case 1:{
            PlayingBackground1 * background = [PlayingBackground1 node];
            [self addChild:background z:-1 tag:BackgroundTag];
        }
            break;
        case 2:{
            PlayingBackground2 * background = [PlayingBackground2 node];
            [self addChild:background z:-1 tag:BackgroundTag];
        }
            break;
        case 3:{
            PlayingBackground3 * background = [PlayingBackground3 node];
            [self addChild:background z:-1 tag:BackgroundTag];
        }
            break;
        case 4:{
            PlayingBackground4 * background = [PlayingBackground4 node];
            [self addChild:background z:-1 tag:BackgroundTag];
        }
            break;
        case 5:{
            PlayingBackground5 * background = [PlayingBackground5 node];
            [self addChild:background z:-1 tag:BackgroundTag];
        }
            break;
        default:
            break;
    }
}

#pragma mark - get
-(Player*) getPlayer{
    return player;
}
-(EnemyCache*) getEnemyCache{
    return enemyCache;
}
-(HudLayer*) getHudlayer{
    return hudLayer;
}
-(BulletCache*) getBulletCache{
    return bulletCache;
}
-(LevelController*) getLevelController{
    return levelController;
}

-(NSInteger)getPlayerPoint{
    return playerPoint;
}
-(NSInteger)getPlayerType{
    return playerType;
}
-(BulletCache *)getPlayerBulletCache{
    return playerBulletCache;
}
-(DropArticleCache *)getDropActicleCache{
    return dropArticleCache;
}

-(NSInteger)getLevel{
    return gameLevel;
}


#pragma mark - set

-(void)setPoint:(NSInteger)point{
    playerPoint += point;
    [hudLayer resetPoint:playerPoint];
    
    if (playerPoint >=20000 && !two) {
        two = YES;
//        play
        [player addPlayerLife];
        return;
    }
    if (playerPoint >=40000 && !four) {
        four = YES;
        [player addPlayerLife];
        return;
    }
    if (playerPoint >=60000 && !six) {
        six = YES;
        [player addPlayerLife];
        //        play
        return;
    }
    if (playerPoint >=80000 && !eight) {
        eight = YES;
        [player addPlayerLife];
        return;
    }
}

-(void)resetNukeCount:(NSInteger)nuke{
    playerNukeCount += nuke;
    if (playerNukeCount>=3) {
        playerNukeCount = 3;
    }
    [hudLayer resetNukeButtonImage:playerNukeCount];
}

-(void)setDamageEnemyCount{
    damageEnemyCount ++;
}

-(void)pauseGame{
    [hudLayer pauseGame:nil];
}

-(void)drawPlayerlife:(NSInteger)lifeC{
    [hudLayer drawPlayerLifeCount:lifeC WithPlayerType:playerType];
}


@end
