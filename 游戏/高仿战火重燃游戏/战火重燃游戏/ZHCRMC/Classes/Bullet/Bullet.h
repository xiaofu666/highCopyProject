//
//  Bullet.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Base.h"
@class Enemy;
@interface Bullet : Base {
    CGFloat damage;
    CGFloat speed;
    BOOL isPlayerBullet;
    NSInteger health;
}
+(id) bullet;
-(id) initWithBulletImage;
//@property(nonatomic,assign) id deathAction;

-(void) RotateToDegree:(CGPoint) veloc;
-(void) Move;
-(void) checkCollisionWithPlayer;
-(void) checkCollisionWithEnemys;
-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam;
@end


@interface TargetBullet : Bullet{
    
    CGPoint startPos;
    CGFloat interval;
    CGFloat intervalMax;
    
    
    BOOL targeted;
}
@property(nonatomic,readwrite) BOOL allowedTarget; //允许 设置目标
@property(nonatomic,assign)  Enemy * targetEnemy;
@end

@interface KuoSanDanMu : Bullet{
    CGFloat angel;
    NSInteger timesCount;
}

@property(readwrite,nonatomic) NSInteger howManyBullets;

@end

@interface NukeBullet : Base

@property(nonatomic,strong) id nuke_EffectAction;
@property(nonatomic,readwrite) BOOL isInBombing;// 正在爆炸中

-(void) runNukeEffectAction;

@end


@interface  JiGuangBullet : Bullet{
    ccTime takeDamageIntervalMax;
    ccTime takeDamageInterval;
}

@end

@interface enemyDaoDanBullet: Bullet

@end
