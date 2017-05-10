//
//  EnemySpawnController.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-16.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"

@interface EnemySpawnController : CCNode {
    EnemySpawnDetail currentDetail;
    NSInteger spawnCount;
    
    CGSize size;
}

-(void) SpawnSelector:(id) sender;

-(void) spawnWithDetail:(const EnemySpawnDetail)detail;
@end

@interface  SymmetricalSpawnCtrl: EnemySpawnController

@end


@interface TeamSpawnCtrl : EnemySpawnController{
    NSMutableArray * enemyArray;
    BOOL check;
}
@end

@interface ContinuousSpawnCtrl : EnemySpawnController

@end



