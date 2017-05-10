//
//  Enemy.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Base.h"
#import "Defines.h"
@interface Enemy : Base {
    
    NSInteger point;
    
    NSInteger artType; //掉了那样物品
    
    CGFloat health;
    CGFloat healthMax;
    
    CGFloat shootInterval;
    ccTime shootIntervalMax;
    CGPoint startPos;
    
    
    BOOL isDeath;
    BOOL canMove;
    BOOL isEliteFly;
    
//    NSInteger damageCount;
}

//@property(nonatomic,strong) id idle_Action;
//@property(nonatomic,strong) id move_Action;
//@property(nonatomic,strong) id death_Action;


-(void) SpawnAt:(CGPoint) spawnPos;

-(void) SpawnArtAt:(CGPoint) selfPos; //掉落物体

//-(void) SpawnWithEnemyType:(EnemyType) ET At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType) MT HasArticle:(NSInteger) whichArt AndShootIntervalMax:(ccTime) SIM isElite:(BOOL) isElite;

-(void) SpawnAt:(CGPoint) sp WithMoveType:(EnemyMoveType) mt HasArticle:(NSInteger) whichArt AndShootIntervalMax:(ccTime) SIM isElite:(BOOL) isElite;


-(BOOL) getDeath; //是否已死亡

-(void) shoot;  //发射子弹

-(void) canMove:(BOOL) cM;

-(void) checkCollisionWithPlayer;

-(BOOL) runDeathAction;

-(BOOL) checkCollisionWithPoint:(CGPoint) pt;
-(BOOL) checkCollisionWithRect:(CGRect) rect;

#pragma mark - 


@end
