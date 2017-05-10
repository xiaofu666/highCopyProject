//
//  Bullet.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"
#import "PlayingScene.h"
#import "Player.h"
#import "Enemy.h"
#import "EnemyCache.h"
#import "BulletCache.h"


@implementation Bullet

+(id) bullet{
    return [[[self alloc]initWithBulletImage]autorelease];
}

-(id) initWithBulletImage{
    self = [super initWithSpriteFrameName:@"dl_pe_a_041.png"];
    if (self) {
        health = 1;
        self.anchorPoint = ccp(0.5, 0.5);
        CGSize size = [[CCDirector sharedDirector]winSize];
        screenRect = CGRectMake(0, 0, size.width, size.height);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(void)onExit{
    [super onExit];
    [self stopAllActions];
    [self unscheduleAllSelectors];
}

-(void)Death{
    [self removeFromParentAndCleanup:YES];
}

-(void)takeDamage:(CGFloat)damage{
    
    if (isPlayerBullet) {
        id deathAction = [self LoadAnimationActionEndFrame:4 StartFram:1 Delta:0.01 AnimateName:@"dl_pe_b_04" AnimateCacheName:@"death_name"];
        CCCallFunc * func = [CCCallFunc actionWithTarget:self selector:@selector(Death)];
        [self runAction:[CCSequence actions:deathAction,func, nil]];
    }else
        [self Death];
}

-(void) Move{
    self.position = ccpAdd(self.position,velocity);
}

-(void)RotateToDegree:(CGPoint) veloc{
    CGFloat degree = ccpToAngle(veloc);
    self.rotation = CC_RADIANS_TO_DEGREES(3.14/2-degree);
}

-(void) checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectContainsPoint([player GetDamageRect], self.position)) {
            health --;
            [self takeDamage:damage];
            [player takeDamage:damage];
            return;
        }
    }
}
-(void) checkCollisionWithEnemys{
    CCArray *enemyArray = [[PlayingScene SharedPlayingScene] getEnemyCache].children;
    Enemy * enemy;
    CCARRAY_FOREACH(enemyArray, enemy){
        if ([enemy getDeath]) {
            continue;
        }
        if ([enemy isKindOfClass:[Enemy class]]) {
            if ([enemy checkCollisionWithPoint:self.position]) {
                health --;
                [self takeDamage:damage];
                [enemy takeDamage:damage];
                return;
            }
        }
    }
}

-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam{
    damage = dam;
    velocity = vel;
    [self RotateToDegree:vel];
    self.position = startPosition;
    self.visible = YES;
    isPlayerBullet = playerBullet;
    if (frameName) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        [self setDisplayFrame:frame];
    }
    [self unscheduleAllSelectors];
    [self scheduleUpdate];
}

-(void)update:(ccTime)delta{
    if (!health) {
        return;
    }
    [self Move];
    [self isInScreenRect];
    if(isPlayerBullet) {
        [self checkCollisionWithEnemys];
    }else{
        [self checkCollisionWithPlayer];
    }
}
@end


@implementation TargetBullet

-(void)update:(ccTime)delta{
    interval += delta;
    [super update:delta];

    if (interval>0.2) {
        
        if (!self.allowedTarget) {
            velocity = ccp(0, 4);
            return;
        }
        
        if (!self.targetEnemy && !targeted && self.allowedTarget) {
            self.targetEnemy = [[[PlayingScene SharedPlayingScene] getEnemyCache] TargetBulletGetTarget];
        }
        
        if ([_targetEnemy getDeath]) {
            _targetEnemy = nil;
        }
        
        if (self.targetEnemy && ![self.targetEnemy getDeath]) {
            CGPoint v= ccpSub(self.targetEnemy.position,self.position);
            CGFloat angel = 3.14/2 - ccpToAngle(v);
//            if (fabsf(angel)>CC_DEGREES_TO_RADIANS(30)) {
//                angel = CC_DEGREES_TO_RADIANS(30) * (angel/fabsf(angel));
//            }
//            CGPoint vA = ccpForAngle(angel);
            self.rotation = CC_RADIANS_TO_DEGREES(angel);
            velocity = ccpMult(ccpNormalize(v),4.0);
            targeted = YES;
        }
        if (!targeted) {
            velocity = ccp(0, 4);
        }
    }
}

//-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString *)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam{
//    [super shootBulletAt:startPosition velocity:vel frameName:frameName isPlayerBullet:playerBullet Damage:dam];
//    
//    
//}
-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString *)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam{
    [super shootBulletAt:startPosition velocity:vel frameName:nil isPlayerBullet:playerBullet Damage:dam];
    
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:frameName AnimateCacheName:nil];
    [self runAction:[CCRepeatForever actionWithAction:action]];
}

-(void)RotateToDegree:(CGPoint)veloc{
    return;
}

-(void)Death{
//    _targetEnemy = nil;
    [self stopAllActions];
    [super Death];
}

- (id)init
{
    self = [super init];
    if (self) {
        targeted = NO;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation KuoSanDanMu


-(void)update:(ccTime)delta{
    [super update:delta];
    
    if (self.position.y < screenRect.size.height/2) {
        [self unscheduleAllSelectors];
        [self spawnQuanFangWeiDanMu];
    }
}

-(void)checkCollisionWithPlayer{
    
}

-(void) spawnQuanFangWeiDanMu{
    self.visible = NO;
    if (!self.howManyBullets) {
        self.howManyBullets = 3;
    }
    timesCount = 0;
    [self schedule:@selector(spawnBulletWithInterval:) interval:0.15 repeat:self.howManyBullets delay:0.0];
}

-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString *)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam{
    [super shootBulletAt:startPosition velocity:vel frameName:@"4.png" isPlayerBullet:playerBullet Damage:dam];
    self.scale = 2;
}

-(void) spawnBulletWithInterval:(ccTime) delta{
    timesCount ++;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    for (int i =0; i< 24; i++) {
        velocity =ccpMult(ccp(sinf(angel), cosf(angel)),EnemyBulletSpeed);
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:self.position velocity:velocity FrameName:@"4.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
        angel += 3.14/12;
    }
    if (timesCount>=self.howManyBullets) {
        [self unscheduleAllSelectors];
        [self Death];
    }
}


@end


@implementation NukeBullet

-(void)runNukeEffectAction{
    [self runAction:self.nuke_EffectAction];
}

-(void) NukeTakeDamage{
    self.isInBombing = YES;
    self.visible = YES;
    EnemyCache * enemyCache = [[PlayingScene SharedPlayingScene] getEnemyCache];
    [enemyCache clearnAllEnemy];
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache cleanUpAllBullet];
}

-(void) NukeEnd{
    self.visible = NO;
    self.isInBombing = NO;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isInBombing = NO;
        
        self.position = ccp(screenRect.size.width/2, screenRect.size.height/2);
        self.visible = NO;
        id action = [self LoadAnimationActionEndFrame:9 StartFram:1 Delta:0.1 AnimateName:@"dl_pe_a_02" AnimateCacheName:@"nuke"];
        CCCallFunc * nukeTakeDamage = [CCCallFunc actionWithTarget:self selector:@selector(NukeTakeDamage)];
        CCCallFunc * animationEnd = [CCCallFunc actionWithTarget:self selector:@selector(NukeEnd)];
        self.nuke_EffectAction = [CCSequence actions:nukeTakeDamage,action,animationEnd, nil];
    }
    return self;
}

- (void)dealloc
{
    if (self.nuke_EffectAction) {
        [self.nuke_EffectAction release];
        self.nuke_EffectAction = nil;
    }
    [super dealloc];
}

@end


@implementation JiGuangBullet

-(id)initWithBulletImage{
    self  = [super initWithBulletImage];
    if (self) {
        health = 100;
//        hasTakeDamage = NO;
        takeDamageInterval = 0.125;
        takeDamageIntervalMax = 0.125;
    }
    return self;
}

-(void)checkCollisionWithEnemys{
    
    CCArray *enemyArray = [[PlayingScene SharedPlayingScene] getEnemyCache].children;
    Enemy * enemy;
    CCARRAY_FOREACH(enemyArray, enemy){
        if ([enemy getDeath]) {
            continue;
        }
        if ([enemy isKindOfClass:[Enemy class]]) {
            if ([enemy checkCollisionWithRect:self.boundingBox]){
                health --;
//                hasTakeDamage = YES;
                [enemy takeDamage:damage];
            }
        }
    }
}
-(void)update:(ccTime)delta{
    [self Move];
    takeDamageInterval +=delta;//激光每隔0.125秒产生伤害
    
    if (takeDamageInterval >takeDamageIntervalMax) {
        takeDamageInterval = 0;
        [self checkCollisionWithEnemys];
    }
    [self isInScreenRect];
}

-(void)dealloc{
    [super dealloc];
}

@end


@implementation enemyDaoDanBullet

-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString *)frameName isPlayerBullet:(bool)playerBullet Damage:(NSInteger)dam{
    [super shootBulletAt:startPosition velocity:vel frameName:nil isPlayerBullet:playerBullet Damage:dam];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:frameName AnimateCacheName:nil];
    [self runAction:[CCRepeatForever actionWithAction:action]];
    self.rotation += 180;
    self.rotation *=-1;
}
-(void)Death{
    [self stopAllActions];
    [super Death];
}

//-(id)LoadAnimationActionEndFrame:(NSInteger)frame StartFram:(NSInteger)startFrame Delta:(CGFloat)delta AnimateName:(NSString *)animateName AnimateCacheName:(NSString *)animateCacheName{
//    
//}

@end

