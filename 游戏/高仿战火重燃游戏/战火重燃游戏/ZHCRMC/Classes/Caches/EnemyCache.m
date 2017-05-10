//
//  EnemyCache.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"

#import "Enemy.h"


@implementation EnemyCache

-(void) spawnEnemy:(Enemy *)enemy AtPos:(CGPoint) pos{
    if (currentLevelEnd) {
        return;
    }
    
    [self addChild:enemy];
    [enemy SpawnAt:pos];
}

//-(void)SpawnEnemy:(Enemy *)enemy WithEnemyType:(EnemyType)ET At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType)MT HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
//    [self addChild:enemy];
//    [enemy SpawnWithEnemyType:ET At:spawnPos WithMoveType:MT HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
//    [enemy SpawnAt:spawnPos WithMoveType:ET HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
//    [enemy release];
//    [self clearnAllEnemys];
//}

-(void)SpawnEnemy:(Enemy *)enemy At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType)MT HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [self addChild:enemy];
    [enemy SpawnAt:spawnPos WithMoveType:MT HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
//    [enemy release];
}


-(void) clearnAllEnemy{
    CCNode * node;
    CCARRAY_FOREACH(self.children, node) {
        if ([node isKindOfClass:[Enemy class]]) {
            Enemy *enemy = (Enemy*)node;
            if ([enemy getDeath]) {
                continue;
            }
            [enemy takeDamage:700];
        }
    }
}


-(void) setCurrentLevelEnd:(BOOL) end{
    currentLevelEnd = end;
}

-(Enemy *)TargetBulletGetTarget{
    CCNode * node;
    NSInteger childCount = self.children.count;
    if (!childCount) {
        return nil;
    }
    
    NSInteger index = arc4random()%childCount;
    node = [self.children objectAtIndex:index];
    if ([node isKindOfClass:[Enemy class]]) {
        Enemy * enemy =  (Enemy*)node;
        if (![enemy getDeath]) {
            return enemy;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        currentLevelEnd = NO;
    }
    return self;
}
@end
