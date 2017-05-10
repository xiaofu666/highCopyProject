//
//  EnemySpawnController.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "EnemySpawnController.h"

#import "EnemyCache.h"
#import "NormalFly.h"
#import "PlayingScene.h"
#import "DropArticleCache.h"


@implementation EnemySpawnController


-(void)SpawnSelector:(id)sender{
    
}

-(void)spawnWithDetail:(const EnemySpawnDetail)detail{
    spawnCount = 0;
    currentDetail = detail;
    size  = [[CCDirector sharedDirector]winSize];
}

@end

@implementation SymmetricalSpawnCtrl

-(void)SpawnSelector:(id)sender{
    CGPoint pos1;
    CGPoint pos2;
    
    if (spawnCount>=currentDetail.spawnCount) {
        [self unscheduleAllSelectors];
        [self removeFromParentAndCleanup:YES];
    }
    spawnCount ++;
    
    CGPoint pos ;
    if (currentDetail.startPos_X == -1) {
        pos = ccp((size.width - 40) * arc4random()/(float)ARC4RANDOM_MAX+40, size.height * currentDetail.startPos_Y);
    }else
        pos= ccp(size.width * currentDetail.startPos_X, size.height * currentDetail.startPos_Y);
    
    if (pos.x <= 40) {
        pos1  = ccp(pos.x, pos.y);
        pos2  = ccp(pos.x+20, pos.y);
    }else{
        pos1  = ccp(pos.x-20, pos.y);
        pos2  = ccp(pos.x+20, pos.y);
    }
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    NormalFly * fly1 = [NormalFly initWithEnemyType:currentDetail.flyType];
    [enemyCache SpawnEnemy:fly1 At:pos1 WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
//    [enemyCache SpawnEnemy:fly1 WithEnemyType:currentDetail.flyType At:pos1 WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
    NormalFly * fly2 = [NormalFly initWithEnemyType:currentDetail.flyType];
    [enemyCache SpawnEnemy:fly2 At:pos2 WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
//    [enemyCache SpawnEnemy:fly2 WithEnemyType:currentDetail.flyType At:pos2 WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
}
-(void)spawnWithDetail:(const EnemySpawnDetail)detail{
    [super spawnWithDetail:detail];
    NSInteger times = detail.spawnCount;
    if (times>1) {
        times -=1;
    }
    [self schedule:@selector(SpawnSelector:) interval:0.5 repeat:times delay:0];
}

@end


@implementation TeamSpawnCtrl

-(void) update:(ccTime)delta{
//    if (check) {
    CGPoint pos;
    for (int i=0;i<enemyArray.count;i++ ) {
        Enemy * enemy = [enemyArray objectAtIndex:i];
        pos = enemy.position;
            if ([enemy getDeath]){
                [enemyArray removeObject:enemy];
            }
            if (enemyArray.count == 0) {
                //产生 道具
                
                //
                DropArticleCache * dropcache = [[PlayingScene SharedPlayingScene] getDropActicleCache];
                NSInteger rand = arc4random() %2;
                [dropcache spawnArticleAt:pos which:rand];
                
                [self unscheduleAllSelectors];
                [self removeFromParentAndCleanup:YES];
            }
        }
//    }
}

-(void)SpawnSelector:(id)sender{
    if (spawnCount>=currentDetail.spawnCount) {
        check = YES;
    }
    spawnCount++;
    CGPoint pos ;
    if (currentDetail.startPos_X == -1) {
        pos = ccp((size.width - 30) * arc4random()/(float)ARC4RANDOM_MAX+30, size.height * currentDetail.startPos_Y);
    }else
        pos= ccp(size.width * currentDetail.startPos_X, size.height * currentDetail.startPos_Y);
    
    NormalFly * fly = [NormalFly initWithEnemyType:currentDetail.flyType];
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    [enemyArray addObject:fly];
    [enemyCache SpawnEnemy:fly At:pos WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
//    [enemyCache SpawnEnemy:fly WithEnemyType:currentDetail.flyType At:pos WithMoveType:currentDetail.moveType HasArticle:3 AndShootIntervalMax:0 isElite:currentDetail.isEliteFly];
}

-(void)spawnWithDetail:(const EnemySpawnDetail)detail{
    [super spawnWithDetail:detail];
    check = NO;
    enemyArray  = [[NSMutableArray alloc]init];
    [self schedule:@selector(SpawnSelector:) interval:0.5 repeat:detail.spawnCount-1 delay:0];
    [self scheduleUpdate];
}

- (void)dealloc
{
    if (enemyArray) {
        [enemyArray removeAllObjects];
        [enemyArray release];
        enemyArray = nil;
    }
    [super dealloc];
}
@end


@implementation ContinuousSpawnCtrl

-(void)SpawnSelector:(id)sender{
    
    if (spawnCount>=currentDetail.spawnCount) {
        [self unscheduleAllSelectors];
        [self removeFromParentAndCleanup:YES];
    }
    spawnCount ++;
    
    CGPoint pos ;
    if (currentDetail.startPos_X == -1) {
        pos = ccp((size.width - 30) * arc4random()/(float)ARC4RANDOM_MAX +30, size.height * currentDetail.startPos_Y);
    }else
        pos= ccp(size.width * currentDetail.startPos_X, size.height * currentDetail.startPos_Y);
//    if (pos.x<=0) {
//        pos.x +=5;
//    }
//    if (pos.x>=size.width) {
//        pos.x -= 5;
//    }
    NormalFly * fly = [NormalFly initWithEnemyType:currentDetail.flyType];
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    [enemyCache SpawnEnemy:fly At:pos WithMoveType:currentDetail.moveType HasArticle:currentDetail.dropArticle AndShootIntervalMax:currentDetail.shootIntervalMax isElite:currentDetail.isEliteFly];
//    [enemyCache SpawnEnemy:fly WithEnemyType:currentDetail.flyType At:pos WithMoveType:currentDetail.moveType HasArticle:3 AndShootIntervalMax:0 isElite:currentDetail.isEliteFly];
}

-(void)spawnWithDetail:(const EnemySpawnDetail)detail{
    [super spawnWithDetail:detail];
    
    NSInteger times = detail.spawnCount;
    if (times>1) {
        times -=1;
    }
    [self schedule:@selector(SpawnSelector:) interval:0.5 repeat:times delay:0];
}

@end
