//
//  LevelController.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "LevelController.h"

#import "PlayingScene.h"
#import "BigBoss.h"
#import "EnemyCache.h"
#import "DateHandle.h"
#import "NormalFly.h"
#import "EnemySpawnController.h"


@implementation LevelController

- (id)init
{
    self = [super init];
    if (self) {
        
        timeCtrl = 0.0;
        getDetailIndex = 0;
        size = [[CCDirector sharedDirector] winSize];
//        BigBoss * bigBoss = [BigBossThree node];
//
//        EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
//
//        [enemyCache spawnEnemy:bigBoss AtPos:ccp(160, 480)];
//        NormalFly * normalFly = [NormalFly initWithEnemyType:5];
        
//        [enemyCache SpawnEnemy:normalFly At:ccp(size.width/2, size.height) WithMoveType:9 HasArticle:-1 AndShootIntervalMax:2 isElite:YES];
//
//        [enemyCache SpawnEnemy:normalFly At:ccp(160, 480) WithMoveType:8 HasArticle:3 AndShootIntervalMax:2 isElite:NO];
    }
    return self;
}

- (void)dealloc
{
////    if (arrayTimeCtrl) {
////        [arrayTimeCtrl release];
//        arrayTimeCtrl = nil;
////    }
////    if (arraySpawnDetail) {
////        [arraySpawnDetail release];
//        arraySpawnDetail = nil;
////    }
    [super dealloc];
}

-(void)loadCurrentLevel:(NSInteger)level{ // 加载关卡X level
    spawnAgain = YES;
    NSString *levelName;
    switch (level) {
        case 1:
            levelName = @"levelOne";
            break;
        case 2:
            levelName = @"levelTwo";
            break;
        case 3:
            levelName = @"levelThree";
            break;
        case 4:
            levelName = @"levelFour";
            break;
        case 5:
            levelName = @"levelFive";
            break;
            
        default:
            return;
            break;
    }
    [[DateHandle SharedDateHandle] loadWhichLevelDate:levelName];
    arrayTimeCtrl = [[DateHandle SharedDateHandle] getTimeArray];
    arraySpawnDetail = [[DateHandle SharedDateHandle] getEnemyArray];
    timeCtrl = 0.0;
    interval = 0.0;
    getDetailIndex = 0;
    currentSpawnDetail = [self getCurrentSpawnDetail];
    
//    [self spawnBigBoss];
    [self unscheduleUpdate];
    [self scheduleUpdate];
}

-(EnemySpawnDetail)getCurrentSpawnDetail{ // 得到当前产生敌机 细节
    EnemySpawnDetail detail;
    
    timeCtrl = [[arrayTimeCtrl objectAtIndex:getDetailIndex]floatValue];
//    NSLog(@"time:%f",timeCtrl);
    NSArray * array = [arraySpawnDetail objectAtIndex:getDetailIndex];
    
    detail.flyType          = [[array objectAtIndex:0]integerValue];
    detail.moveType         = [[array objectAtIndex:1]integerValue];
    detail.startPos_X       = [[array objectAtIndex:2]floatValue];
    detail.startPos_Y       = [[array objectAtIndex:3]floatValue];
    detail.shootIntervalMax = [[array objectAtIndex:4]floatValue];
    detail.spawnType        = [[array objectAtIndex:5]integerValue];
    detail.spawnCount       = [[array objectAtIndex:6]integerValue];
    detail.dropArticle      = [[array objectAtIndex:7]integerValue];
    detail.isEliteFly       = [[array objectAtIndex:8]boolValue];
    
//    NSLog(@"flyType:%d,moveType:%d,X:%f,Y:%f,ShootIn:%f,SpawnType:%d,SpawnCount:%d,Drop:%d",detail.flyType,detail.moveType,detail.startPos_X,detail.startPos_Y,detail.shootIntervalMax,detail.spawnType,detail.spawnCount,detail.dropArticle);
    
//    NSLog(@"flyType:%d MoveType :%d X: %f Y: %f",detail.flyType,detail.moveType,detail.startPos_X,detail.startPos_Y);
    getDetailIndex ++;
//    if (detail.flyType == 8 ||detail.flyType == 9||detail.flyType == 10) {
//        NSLog(@"spawnSmallBoss : %d",detail.flyType);
//    }
//    [self unscheduleUpdate];
//    [self scheduleUpdate];
    return detail;
}

-(void) update:(ccTime)delta{
    interval += delta;
    if (interval>timeCtrl) {
//        NSLog(@"timeCtrl :%f",timeCtrl);
        switch (currentSpawnDetail.spawnType) {
            case 1:
                [self singleSpawn:currentSpawnDetail];
                break;
            case 2:
                [self symmetricalSpawn:currentSpawnDetail];
                break;
            case 3:
                [self teamSpawn:currentSpawnDetail];
                break;
            case 4:
                [self continuousSpawn:currentSpawnDetail];
                break;
            case 5:
                [self AtSameTimeSpawn:currentSpawnDetail];
                break;
            default:
                return;
                break;
        }
        currentSpawnDetail = [self getCurrentSpawnDetail];
    }
    
    if (getDetailIndex>=arrayTimeCtrl.count) {
        [self spawnBigBoss];
        [self  unscheduleUpdate];
        arrayTimeCtrl = nil;
        arraySpawnDetail = nil;
    }
}


-(void) spawnBigBoss{
    [self unscheduleAllSelectors];
    [self scheduleOnce:@selector(SpawnBigBossSelector) delay:10];
    [self schedule:@selector(SpawnElFlySelector:) interval:30.0];
}

-(void) SpawnElFlySelector:(ccTime) delta{
    NSInteger level = [[PlayingScene SharedPlayingScene] getLevel];
    NSInteger type;
    switch (level) {
        case 1:
            type = 1;
            break;
        case 2:
            type = 3;
            break;
        case 3:
            type = 4;
            break;
        case 4:
            type = 6;
            break;
        case 5:
            type = 7;
            break;
        default:
            return;
            break;
    }
    NormalFly * normalFly = [NormalFly initWithEnemyType:type];
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    [enemyCache SpawnEnemy:normalFly At:ccp(size.width/2, size.height) WithMoveType:9 HasArticle:-1 AndShootIntervalMax:2 isElite:YES];
}
-(void) SpawnBigBossSelector{
    NSInteger level = [[PlayingScene SharedPlayingScene] getLevel];
    BigBoss * bigBoss;
    switch (level) {
        case 1:
            bigBoss = [BigBossOne node];
            break;
        case 2:
            bigBoss = [BigBossTwo node];
            break;
        case 3:
            bigBoss = [BigBossThree node];
            break;
        case 4:
            bigBoss = [BigBossFour node];
            break;
        case 5:
            bigBoss = [BigBossFive node];
            break;
            
        default:
            return;
            break;
    }
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    
    [enemyCache spawnEnemy:bigBoss AtPos:ccp(160, 480)];
}

-(void) singleSpawn:(const EnemySpawnDetail)detail{ // 产生单个敌人
    NormalFly * fly = [NormalFly initWithEnemyType:detail.flyType];
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    
    CGPoint pos ;
    if (detail.startPos_X == -1) {
        pos = ccp((size.width - 40) * arc4random()/(float)ARC4RANDOM_MAX+40, size.height * detail.startPos_Y);
    }else
        pos= ccp(size.width * detail.startPos_X, size.height * detail.startPos_Y);
//    if (detail.flyType == 8 || detail.flyType == 9|| detail.flyType == 10){
//        NSLog(@"smallBossSpawn Atx:%f y:%f",pos.x,pos.y);
//    }
    [enemyCache SpawnEnemy:fly At:pos WithMoveType:detail.moveType HasArticle:detail.dropArticle AndShootIntervalMax:detail.shootIntervalMax isElite:detail.isEliteFly];
//    [enemyCache SpawnEnemy:fly WithEnemyType:detail.flyType At:pos WithMoveType:detail.moveType HasArticle:detail.dropArticle AndShootIntervalMax:detail.shootIntervalMax isElite:detail.isEliteFly];
}

-(void) symmetricalSpawn:(const EnemySpawnDetail)detail{// 产生左右对称敌人
    SymmetricalSpawnCtrl * symmetrcalSpawnCtrl = [SymmetricalSpawnCtrl node];
    [self addChild:symmetrcalSpawnCtrl];
    [symmetrcalSpawnCtrl spawnWithDetail:detail];
}

-(void) teamSpawn:(const EnemySpawnDetail)detail{ // 产生一队的敌人
    TeamSpawnCtrl * teamSpawnCtrl = [TeamSpawnCtrl node];
    [self addChild:teamSpawnCtrl];
    [teamSpawnCtrl spawnWithDetail:detail];
}


-(void) continuousSpawn:(const EnemySpawnDetail)detail{ //连续产生敌人
    ContinuousSpawnCtrl * continuesSpawnCtrl = [ContinuousSpawnCtrl node];
    [self addChild:continuesSpawnCtrl];
    [continuesSpawnCtrl spawnWithDetail:detail];
}

-(void) AtSameTimeSpawn:(const EnemySpawnDetail)detail{// 同时产生
    [self symmetricalSpawn:detail];
}

-(void) CurrentLevelEnd{
    [self unscheduleAllSelectors];
}

@end
