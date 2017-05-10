//
//  EnemyCache.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"

@class Enemy;
@interface EnemyCache : CCNode {
    BOOL currentLevelEnd;
}

-(void) spawnEnemy:(Enemy *)enemy AtPos:(CGPoint) pos;

//-(void) SpawnEnemy:(Enemy *) enemy WithEnemyType:(EnemyType) ET At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType) MT HasArticle:(NSInteger) whichArt AndShootIntervalMax:(ccTime) SIM isElite:(BOOL) isElite;
-(void) SpawnEnemy:(Enemy *) enemy At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType) MT HasArticle:(NSInteger) whichArt AndShootIntervalMax:(ccTime) SIM isElite:(BOOL) isElite;

-(void) clearnAllEnemy;
-(void) setCurrentLevelEnd:(BOOL) end;

-(Enemy* ) TargetBulletGetTarget;

@end
