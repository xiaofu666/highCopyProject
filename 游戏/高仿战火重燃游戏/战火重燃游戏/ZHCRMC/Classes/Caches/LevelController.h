//
//  LevelController.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"

@interface LevelController : CCNode {
    EnemySpawnDetail currentSpawnDetail;
    
    ccTime interval;
    ccTime timeCtrl;
    NSInteger getDetailIndex;
    NSInteger allSpawnCount;
    
    NSArray * arrayTimeCtrl;
    NSArray * arraySpawnDetail;
    
    CGSize size;
    
    BOOL spawnAgain; // 用于控制是否已久产生boss
}

-(EnemySpawnDetail) getCurrentSpawnDetail;

-(void) CurrentLevelEnd;

-(void) loadCurrentLevel:(NSInteger)level;

@end
