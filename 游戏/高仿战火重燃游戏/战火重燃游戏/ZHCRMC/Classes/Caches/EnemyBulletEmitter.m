//
//  EnemyBulletEmitter.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "EnemyBulletEmitter.h"
#import "PlayingScene.h"
#import "Player.h"
#import "Bullet.h"
#import "BulletCache.h"
#import "BigBoss.h"


@implementation EnemyBulletEmitter

-(void)Shoot:(ccTime)delta{
    if (self.parent!=nil) {
        shootPos = ccpAdd(self.parent.position,addPos);
        shootPos.y -=10;
        shootPos.x -=4;
    }
    if (normalEffect.numberOfRunningActions !=0 || !_canPlayNormalEffect) {//如果normalsprite正在播放动画就 return 或者不允许播放动画就return
        return;
    }
    normalEffect.visible = YES;
    [normalEffect runAction:normalEffect_action];
}

-(void)NormalEffectEnd{
    normalEffect.visible = NO;
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [self unscheduleAllSelectors];
    
    normalEffect.position = sp;
    
    shootCount = 0;
    target = targ;
    addPos = sp;
    if (self.parent!=nil) {
        shootPos = ccpAdd(self.parent.position,addPos);
//        shootPos = ccpAdd(shootPos, ccp(0, -8));
    }
    
    shootPos.x +=4;
    
    if (target) {
        CGPoint targetPos = target.position;
        CGPoint v= ccpSub( targetPos,shootPos);
        velocity = ccpNormalize(v);
    }else{
        velocity = ccp(0, -1);
    }
    
    keepPos = shootPos;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        shootPos = ccp(0, 0);
        shootCount = 0;
        velocity = ccp(0, 0);
        angel = 0;
        shootCount = 0;
        self.times =0;
        normalEffect = [CCSprite spriteWithSpriteFrameName:@"010005.png"];
        normalEffect.anchorPoint = ccp(0.5, 1);
        [self addChild:normalEffect];
        normalEffect.visible = NO;
        
        CCBlink * blink = [CCBlink actionWithDuration:0.1 blinks:2];
        CCCallFunc * callfun = [CCCallFunc actionWithTarget:self selector:@selector(NormalEffectEnd)];
        normalEffect_action = [CCSequence actionOne:blink two:callfun];
        [normalEffect_action retain];
        
        _canPlayNormalEffect = YES;//默认允许播放动画
    }
    return self;
}

- (void)dealloc
{
    if (normalEffect_action) {
        [normalEffect_action release];
        normalEffect_action = nil;
    }
    [super dealloc];
}
@end


@implementation LianXuBulletEmitter


-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    shootCount ++;
    if (shootCount>=self.shootCountMax) {
        [self unscheduleAllSelectors];
    }
    
    Bullet * bullet = [Bullet bullet];
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:shootPos velocity:ccpMult(velocity ,EnemyBulletSpeed)FrameName:@"3.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    [self schedule:@selector(Shoot:) interval:0.15];
}


@end

@implementation TongDaoBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    shootCount ++;
    if (shootCount>=self.shootCountMax) {
        Enemy * enemyBigBoss = (Enemy*)self.parent;
        [enemyBigBoss canMove:YES];
        [self unscheduleAllSelectors];
    }
    Bullet * bullet = [Bullet bullet];
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:shootPos velocity:ccpMult(velocity ,EnemyBulletSpeed)FrameName:@"2.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:nil];
    [self schedule:@selector(Shoot:) interval:0.04];
}

@end


@implementation SanDanBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    CGFloat ang = 3.14 - 3.14/8.0;
    for (int i = 0; i<4*2; i++) {
        velocity =ccpMult(ccp(sinf(angel), cosf(angel)),EnemyBulletSpeed);
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:shootPos velocity:velocity FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
        ang += 3.14/24;
    }
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    if (!self.times) {
        self.times = 3;
    }
    [self schedule:@selector(Shoot:) interval:0.01 repeat:self.times delay:0];
}

@end


@implementation XuanZhuanBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    shootCount ++;
    if (shootCount>=self.shootCountMax) {
        [self unscheduleAllSelectors];
    }
    
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    velocity =ccpMult(ccp(sinf(angel), cosf(angel)),EnemyBulletSpeed);
    Bullet * bullet = [Bullet bullet];
    [bulletCache shootBulletAt:shootPos velocity:velocity FrameName:@"4.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
    
    if (self.leftOrRight) {
        angel += 3.14/6;
    }else{
        angel -= 3.14/6;
    }
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    angel = 0;
    [self schedule:@selector(Shoot:) interval:1/60];
}

@end

@implementation KuoSanBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    for (int i =0; i< 24; i++) {
        velocity =ccpMult(ccp(sinf(angel), cosf(angel)),EnemyBulletSpeed);
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:shootPos velocity:velocity FrameName:@"4.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
        angel += 3.14/12;
    }
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    
    if (!self.times) {
        self.times = 3;
    }
    [self schedule:@selector(Shoot:) interval:0.15 repeat:self.times delay:0.0];
}

@end

@implementation QianFangDuoDianBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    timeCount ++;
    
    if (timeCount>=self.times) {
        [self unscheduleAllSelectors];
        Enemy* enemy = (Enemy*)self.parent;
        [enemy canMove:YES];
    }
    
    CGPoint pos = keepPos;
    angel = 192;
    pos.x -= 10*self.shootCountMax /  2;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    for (int i =0; i< 6; i++) {
        if (i == 2|| i==3) {
            CGFloat ang = CC_DEGREES_TO_RADIANS(180);
            velocity = ccpMult(ccp(sinf(ang), cosf(ang)),EnemyBulletSpeed);
            if (i==3) {
                angel -= 6;
            }
        }else{
            CGFloat ang = CC_DEGREES_TO_RADIANS(angel);
            velocity = ccpMult(ccp(sinf(ang), cosf(ang)),EnemyBulletSpeed);
            angel -=6;
        }
        pos.x +=10;
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:pos velocity:velocity FrameName:@"3.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
        angel += 3.14/12;
    }
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    timeCount = 0;
//    if (!self.times) {
        self.times = 2;
//    }
    [self schedule:@selector(Shoot:) interval:0.15 repeat:self.times delay:0.0];
}

@end

@implementation QianFangDuoDianSingleBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
    CGFloat ang = ccpToAngle(oldVeloc) + CC_DEGREES_TO_RADIANS(15);
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    for (int i=0; i<4; i++) {
        velocity = ccpForAngle(ang);
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:shootPos velocity:ccpMult(velocity,EnemyBulletSpeed) FrameName:@"1.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
        ang -= CC_DEGREES_TO_RADIANS(10);
    }
    
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    keepPos = shootPos;
    timeCount = 0;
    oldVeloc = velocity;
////    if (!self.times) {
//        self.times = 4;
////    }
    [self schedule:@selector(Shoot:) interval:0.15 repeat:3 delay:0.0];
}

@end

@implementation DuoGeBulletEmitter


-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
//    velocity = ccp(0, -1);
    CGPoint pos = sp;
    angel = 0;
    if (!self.shootCountMax) {
        self.shootCountMax = 5;
    }
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    for (int i = 0; i<self.shootCountMax; i++) {
        angel = CC_DEGREES_TO_RADIANS(i*(360/self.shootCountMax));
        CGPoint vel = ccpMult(ccp(sinf(angel), cosf(angel)),10);
        pos = ccpAdd(shootPos, vel);
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:pos velocity:ccpMult(velocity,EnemyBulletSpeed) FrameName:@"1.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
    }
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

@end

@implementation ShaoSheBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
//    CGPoint targetPos = target.position;
//    CGPoint v= ccpSub( targetPos,shootPos);
//    velocity = ccpNormalize(v);
    
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    
    Bullet * bullet = [Bullet bullet];
    CGPoint vel;
    NSInteger rand = arc4random()%3 - 2;
    CGFloat ang = CC_DEGREES_TO_RADIANS(10) * rand + ccpToAngle(velocity);
    vel = ccpForAngle(ang);
    [bulletCache shootBulletAt:shootPos velocity:ccpMult(vel,5) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    if (!self.times) {
        self.times = 15;
    }
    [self schedule:@selector(Shoot:) interval:0.1 repeat:self.times delay:0.0];
}

@end

@implementation JiGuangBulletEmitter

-(void)Shoot:(ccTime)delta{
    [super Shoot:delta];
//    shootPos = ccpAdd(self.parent.position,addPos);
    
    shoorInterval += delta;
    
    if (shoorInterval>self.times) {
        [self unscheduleAllSelectors];
        effectEnd = YES;
    }
    
    if (effectEnd) {
        BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:shootPos velocity:ccpMult(velocity,15) FrameName:@"dl_pe_b_081.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
    }
}
-(void) EffectEnd{
    effectEnd = YES;
    effectSprite.visible = NO;
}

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    [super ShootAt:sp withTarget:targ];
    if (!self.times) {
        self.times = 5;
    }
    shoorInterval = 0;
    [self schedule:@selector(Shoot:)];
    effectSprite.position = sp;
    effectSprite.visible = YES;
    effectEnd = NO;
    [effectSprite runAction:self.shootEffect_Action];
}

- (id)init
{
    self = [super init];
    if (self) {
        effectEnd  = NO;
        effectSprite = [CCSprite node];
        [self addChild:effectSprite];
        effectSprite.visible = NO;
        id actionE = [self LoadAnimationActionEndFrame:4 StartFram:1 Delta:0.2 AnimateName:@"01000" AnimateCacheName:nil];
        CCCallFunc * effectFEnd = [CCCallFunc actionWithTarget:self selector:@selector(EffectEnd)];
        self.shootEffect_Action = [CCSequence actionOne:actionE  two:effectFEnd];
        self.canPlayNormalEffect = NO;
    }
    return self;
}
- (void)dealloc
{
    if (self.shootEffect_Action) {
        [self.shootEffect_Action release];
        self.shootEffect_Action = nil;
    }
    [super dealloc];
}

@end

@implementation FaSheHouKuoSan

-(void)ShootAt:(CGPoint)sp withTarget:(Player *)targ{
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    kuosanDanmu.howManyBullets = self.times;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:self.parent.position velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];
}

@end