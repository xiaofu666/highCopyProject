//
//  NormalFly.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NormalFly.h"

#import "BulletCache.h"
#import "PlayingScene.h"
#import "EnemyBulletEmitter.h"
#import "Bullet.h"

@implementation NormalFly

+(id) initWithEnemyType:(EnemyType)enemyType{
    
    switch (enemyType) {
        case 1:
            return [NormalFlyOne node];
            break;
        case 2:
            return [NormalFlyTwo node];
            break;
        case 3:
            return [NormalFlyThree node];
            break;
        case 4:
            return [NormalFlyFour node];
            break;
        case 5:
            return [NormalFlyFive node];
            break;
        case 6:
            return [NormalFlySix node];
            break;
        case 7:
            return [NormalFlySeven node];
            break;
        case 8:
            return [NormalFlyEight node];
            break;
        case 9:
            return [NormalFlyNine node];
            break;
        case 10:
            return [NormalFlyTen node];
            break;
        default:
            break;
    }
    return nil;
}



- (id)init
{
    self = [super init];
    if (self) {
        self.visible = NO;
        shootType = 1;
        
        isMoveStop = NO;
        moveStopInterval = 0;
    }
    return self;
}



-(id)SpawnTintAction{
    CCTintTo * tint = [CCTintTo actionWithDuration:0.1 red:252 green:0 blue:242];
    CCTintTo * tintback = [CCTintTo actionWithDuration:0.1 red:255 green:255 blue:255];
    id sequence = [CCSequence actionOne:tint two:tintback];
    return sequence;
}

//-(void)SpawnWithEnemyType:(EnemyType)ET At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType)MT HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
//    [super SpawnWithEnemyType:ET At:spawnPos WithMoveType:MT HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
//    
//    arcCount = 0;
//    self.position = spawnPos;
//    startPos = spawnPos;
//    
//    moveType = MT;
//    artType = whichArt;
//    
//    shootIntervalMax = SIM;
//    self.visible = YES;
//    shootOnce = NO;
//    canMove = YES;
//    
//
//    shootIntervalMax +=1.0;
//    
//    lastPos = ccp(screenRect.size.width/2, screenRect.size.height/5*3);
//    if(moveType == 12){ velocity = ccp(0, -1); }
//    
//    
//    
//    [self unscheduleUpdate];
//    [self scheduleUpdate];
//}

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    arcCount = 0;
    self.position = sp;
    startPos = sp;

    outScrenTime = 0;
    
    moveType = mt;
    artType = whichArt;

    shootIntervalMax = SIM;
    self.visible = YES;
    shootOnce = NO;
    canMove = YES;
    artType = whichArt;
    
    shootIntervalMax +=1.0;
    lastPos = ccp(screenRect.size.width/2, screenRect.size.height/5*3);
    if(moveType == 12){ velocity = ccp(0, -1); }
}

-(void)move:(const EnemyMoveType)mt{
    if (isDeath) {
        return;
    }
    switch (mt) {
        case 1:
            [self moveTypeOneCalc];
            break;
        case 2:
            [self moveTypeTwoCalc];
            break;
        case 3:
            [self moveTypeThreeCalc];
            break;
        case 4:
            [self moveTypeFourCalc];
            break;
        case 5:
            [self moveTypeFiveCalc];
            break;
        case 6:
            [self moveTypeSixCalc];
            break;
        case 7:
            [self moveTypeSevenCalc];
            break;
        case 8:
            [self moveTypeEightCalc];
            break;
        case 9:
            [self moveTypeNineCalc];
            break;
        case 10:
            [self moveTypeTenCalc];
            break;
        case 11:
            [self moveTypeElevenCalc];
            break;
        case 12:
            [self moveTypeTwelveCalc];
            break;
        default:
            break;
    }
}

-(void)update:(ccTime)delta{
    if (isDeath) {
        return;
    }
    if (isMoveStop) {
        moveStopInterval += delta;//计算停顿时间
    }
    outScrenTime +=delta;
    [self move:moveType];
    
    if (canMove) {
        self.position = ccpAdd(self.position,ccpMult(velocity,1.5));
    }
    [self isInScreenRect];
    shootInterval +=delta;
    if (shootInterval >= shootIntervalMax && !shootOnce) {
        if (shootIntervalMax ==1) {
            shootOnce = YES;
        }
        [self shoot];
        shootInterval = 1.0;
    }
    [self checkCollisionWithPlayer];
}

#pragma mark - moveType
-(void) takeRotate{
    
    CGFloat rotate = ccpToAngle(velocity);
    
    rotate = CC_RADIANS_TO_DEGREES(3.14/2*3-rotate);
    
    if (self.rotation!=rotate) {
        self.rotation = rotate;
    }
}

-(void) moveTypeOneCalc{//斜线移动
    if (startPos.x<160) {
        velocity = ccpNormalize(ccp(1, -1));
    }else{
        velocity = ccpNormalize(ccp(-1, -1));
    }
    [self takeRotate];
}

-(void) moveTypeTwoCalc{// 圆心在左下边
    CGPoint vel;
    if (startPos.x<160) {
        vel = ccpSub(ccp(startPos.x,startPos.y  - 160), self.position);
        vel = ccpPerp(vel);
    }else{
        vel = ccpSub(ccp(startPos.x,startPos.y  - 160), self.position);
        vel = ccpRPerp(vel);
    }
    vel.y -=0.1;
    velocity = ccpNormalize(vel);
    
    [self takeRotate];
}
-(void) moveTypeThreeCalc{//圆心在右下边
    return;
}
-(void) moveTypeFourCalc{//圆心在屏幕顶端中点
    CGPoint vel;
    CGFloat r = fabsf(startPos.x - 160);
    if (startPos.x<160) {
        vel = ccpSub(ccp(startPos.x + r,startPos.y), self.position);
        vel = ccpRPerp(vel);
    }else{
        vel = ccpSub(ccp(startPos.x - r,startPos.y), self.position);
        vel = ccpPerp(vel);
    }
    vel.y -=0.1;
    velocity = ccpNormalize( vel);
    
    [self takeRotate];
}
-(void) moveTypeFiveCalc{//圈圈
    CGPoint vel;
    CGPoint pos;
    if (startPos.x<160) {
        pos = ccp(startPos.x + arcCount * 0.15, startPos.y-arcCount *0.15);
        vel = ccpSub(ccp(pos.x,pos.y - 60), self.position);
        vel = ccpRPerp(vel);
    }else{ 
        pos = ccp(startPos.x - arcCount * 0.15, startPos.y- arcCount *0.15);
        vel = ccpSub(ccp(pos.x,pos.y - 60), self.position);
        vel = ccpPerp(vel);
    }
    vel.y -=0.1;
    arcCount ++;
    velocity = ccpNormalize( vel);
    
    [self takeRotate];
}
-(void) moveTypeSixCalc{// 圆心在左边或右边 与起始点同水平线上
    CGPoint vel;
    if (startPos.x<160) {
        vel = ccpSub(ccp(startPos.x - 360,startPos.y), self.position);
        vel = ccpPerp(vel);
    }else{
        vel = ccpSub(ccp(startPos.x + 360,startPos.y), self.position);
        vel = ccpRPerp(vel);
    }
    velocity = ccpNormalize( vel);
    
    [self takeRotate];
}
-(void) moveTypeSevenCalc{//直线
    velocity = ccp(0,-1);
}

-(void) moveTypeEightCalc{// 向下 停 向上
    if(self.position.y < screenRect.size.height/3*2 && !isMoveStop){
        velocity = ccp(0,0);
        isMoveStop = YES;
    }else{
        if (moveStopInterval<3.0 && isMoveStop) {
            return;
        }
        if (isMoveStop) {
            velocity = ccp(0,1);
        }else
            velocity = ccp(0,-1);
    }
}
-(void) moveTypeNineCalc{//向下 停 向下
    if(self.position.y < screenRect.size.height/3*2 && !isMoveStop){
        velocity = ccp(0,0);
        isMoveStop = YES;
    }else{
        if (moveStopInterval<3.0 && isMoveStop) {
            return;
        }
        velocity = ccp(0,-1);
    }
}
-(void) moveTypeTenCalc{//向右 停 向左
    CGPoint pos;
    int x;
    if (startPos.x<160) {
        x = -1;
        pos = ccp(screenRect.size.width,self.position.y);
    }else{
        x = 1;
        pos = ccp(0,self.position.y);
    }
    CGFloat distance = ccpDistance(self.position, pos);
    if (distance<self.boundingBox.size.width) {
        velocity = ccp(x, 0);
        isMoveStop = YES;
    }else{
        if (isMoveStop) {return;}
        if (startPos.x<160) {
            velocity = ccp(1, 0);
        }else
            velocity = ccp(-1, 0);
    }
}

-(void) moveTypeElevenCalc{// 向下 ( 向右  向左 循环)
    
    if (outScrenTime>30.0) {
        return;
    }
    
    
    if(self.position.y < screenRect.size.height/3*2 && !isMoveStop){
        velocity = ccp(0.5,0);
        isMoveStop = YES;
    }else{
        if (isMoveStop) {
            CGPoint pos1 = ccp(0, screenRect.size.height/3*2);
            CGPoint pos2 = ccp(screenRect.size.width, screenRect.size.height/3*2);
            CGFloat distance1 = ccpDistance(pos1, self.position);
            CGFloat distance2 = ccpDistance(pos2, self.position);
            if (distance1<50) {
                velocity = ccp(0.5, 0);
            }
            if (distance2<=50) {
                velocity = ccp(-0.5, 0);
            }
        }else
            velocity = ccp(0,-1);
    }
}

-(void) moveTypeTwelveCalc{// 5点循环
    
    if (outScrenTime>30.0) {
        return;
    }
    if (ccpDistance(self.position, lastPos )<=5) {
        velocity = CGPointZero;
        velocity = [self GetNextMoveToVeloc];
    }
}

-(CGPoint) GetNextMoveToVeloc{
    CGSize size = [[CCDirector sharedDirector]winSize];
    NSInteger pos = arc4random()%5;
    CGPoint nextPos;
    switch (pos) {
        case 0:
            nextPos = ccp(self.boundingBox.size.width/2, size.height-self.boundingBox.size.height/2);
            break;
        case 1:
            nextPos = ccp(size.width/2 , size.height-self.boundingBox.size.height/2);
            break;
        case 2:
            nextPos = ccp(size.width - self.boundingBox.size.width/2, size.height-self.boundingBox.size.height/2);
            break;
        case 3:
            nextPos = ccp(size.width/5*2, size.height/5*3);
            break;
        case 4:
            nextPos = ccp(size.width/5*4, size.height/5*3);
            break;
        default:
            //            NSLog(@"areNotExit00");
            break;
    }
    //    NSLog(@"%f,%f",nextPos.x,nextPos.y);
    lastPos = nextPos;
    CGFloat x1 = (self.position.x - nextPos.x) * (self.position.x - nextPos.x);
    CGFloat y1 = (self.position.y - nextPos.y) * (self.position.y - nextPos.y);
    CGFloat veloc = -1*sqrtf(x1 +y1);
    //    bullet.rotation =(target.x - startPos.x) / (target.y - startPos.y);
    CGPoint vel = CGPointMake((self.position.x - nextPos.x)/veloc, (self.position.y - nextPos.y)/veloc);
    return vel;
}


//-(void)moveTypeThirteenCalc{
//    CGPoint pos;
//    int x;
//    if (startPos.x<160) {
//        x = -1;
//        pos = ccp(screenRect.size.width,self.position.y);
//    }else{
//        x = 1;
//        pos = ccp(0,self.position.y);
//    }
//    CGFloat distance = ccpDistance(self.position, pos);
//    if (distance<self.boundingBox.size.width) {
//        velocity = ccp(x, 0);
//        isMoveStop = YES;
//    }else{
//        if (isMoveStop) {return;}
//        if (startPos.x<160) {
//            velocity = ccp(1, 0);
//        }else
//            velocity = ccp(-1, 0);
//    }
//}



#pragma mark - shoot


-(CGPoint) selfGetLeftShootPos{
    return ccp(self.position.x - self.boundingBox.size.width/2, self.position.y);
}
-(CGPoint) selfGetRightShootPos{
    return ccp(self.position.x + self.boundingBox.size.width/2, self.position.y);
}

#pragma mark - takedamage death

-(void)takeDamage:(CGFloat)damage{
    [super takeDamage:damage];
}

-(CGRect)GetDamageRect{
    if (!isDeath) {
        CGFloat width = self.boundingBox.size.width;
        CGFloat height = self.boundingBox.size.height;
         return CGRectMake(self.position.x - width/3, self.position.y - height/3, width/3*2, height/3*2);
    }
    return CGRectZero;
}

-(void)Death{
    [super Death];
    isDeath = YES;
    self.visible = NO;
    [self unscheduleUpdate];
    
    [self scheduleOnce:@selector(removeFromParentxx) delay:2.0];
}

-(void) removeFromParentxx{
    [self removeFromParentAndCleanup:YES];
}

-(BOOL)runDeathAction{
    id deathAction = [self LoadAnimationActionEndFrame:5 StartFram:1 Delta:0.1 AnimateName:@"dl_pe_b_01" AnimateCacheName:nil];
    CCCallFunc * deathFun = [CCCallFunc actionWithTarget:self selector:@selector(Death)];
    CCSequence * seq = [CCSequence actionOne:deathAction two:deathFun];
    [self runAction:seq];
    return YES;
}


- (void)dealloc
{
    [super dealloc];
}
@end

@implementation NormalFlyOne


-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
    [self setDisplayFrame:frame];
    if (isElite) {
        health *=2;
        id sequence = [self SpawnTintAction];
        [self runAction:[CCRepeatForever actionWithAction:sequence]];
    }
    [self scheduleUpdate];
}


-(void)shoot{
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache ShootOneBullet:self.position FrameName:@"1.png"];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 50;
        point =5;
    }
    return self;
}

@end

@implementation NormalFlyTwo


-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
//    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
//    [self setDisplayFrame:frame];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:@"dl_enemy_02_" AnimateCacheName:nil];
    if (isElite) {
        health *=2;
         id action1= [CCSpawn actionOne:action two:[self SpawnTintAction]];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }else
        [self runAction:[CCRepeatForever actionWithAction:action]];
    [self scheduleUpdate];
}

//-(void)update:(ccTime)delta{
//    [super update:delta];
//}

-(void)shoot{
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    CGPoint pos;
    CGPoint pos2;
    if (arc4random()%2) {
        pos  = ccp(self.position.x-4,self.position.y);
        pos2 = ccp(self.position.x+4,self.position.y);
    }else{
        pos  = ccp(self.position.x,self.position.y-4);
        pos2 = ccp(self.position.x,self.position.y+4);
    }
    [bulletCache ShootOneBullet:pos FrameName:@"4.png"];
    [bulletCache ShootOneBullet:pos2 FrameName:@"4.png"];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 100;
        point = 10;
    }
    return self;
}

@end

@implementation NormalFlyThree

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    //    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
    //    [self setDisplayFrame:frame];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:@"dl_enemy_03_" AnimateCacheName:nil];
    if (isElite) {
        health *=2;
        id action1 = [CCSpawn actionOne:action two:[self SpawnTintAction]];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }else
        [self runAction:[CCRepeatForever actionWithAction:action]];
    
    [self scheduleUpdate];
}

-(void)shoot{
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    CGPoint pos  = [self selfGetLeftShootPos];
    CGPoint pos2 = [self selfGetRightShootPos];
    [bulletCache ShootThreeBullet:pos FrameName:@"c"];
    [bulletCache ShootThreeBullet:pos2 FrameName:@"c"];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 150;
        point = 15;
    }
    return self;
}

@end

@implementation NormalFlyFour

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    SIM = 2;
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    //    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
    //    [self setDisplayFrame:frame];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:@"dl_enemy_04_" AnimateCacheName:nil];
    if (isElite) {
        health *=2;
        id action1 = [CCSpawn actionOne:action two:[self SpawnTintAction]];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }else
        [self runAction:[CCRepeatForever actionWithAction:action]];
    
    lianxu = [LianXuBulletEmitter node];
    lianxu.canPlayNormalEffect = NO;
    lianxu.shootCountMax = 4;
    [self addChild:lianxu];
    [self scheduleUpdate];
}

-(void)shoot{
    [lianxu ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 200;
        point = 20;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation NormalFlyFive

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    SIM = 2.0;
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    //    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
    //    [self setDisplayFrame:frame];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:@"dl_enemy_05_" AnimateCacheName:nil];
    if (isElite) {
        health *=2;
        id action1 = [CCSpawn actionOne:action two:[self SpawnTintAction]];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }else
        [self runAction:[CCRepeatForever actionWithAction:action]];
    
    duoge = [QianFangDuoDianSingleBulletEmitter node];
    duoge.canPlayNormalEffect = NO;
//    duoge.shootCountMax = 4;
    [self addChild:duoge];
    [self scheduleUpdate];
}

-(void)shoot{
    [duoge ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 250;
        point = 25;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation NormalFlySix

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    SIM = 2.0;
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    
    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_06_1.png"];
    [self setDisplayFrame:frame];
    
//    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.2 AnimateName:@"dl_enemy_06_" AnimateCacheName:nil];
    
    if (isElite) {
        health *=2;
        id action1 = [self SpawnTintAction];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }
    
    duoge = [DuoGeBulletEmitter node];
    duoge.canPlayNormalEffect = NO;
    duoge.shootCountMax = 8;
    [self addChild:duoge];
    
    [self scheduleUpdate];
}

-(void)shoot{
    [duoge ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 200;
        point = 30;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation NormalFlySeven

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    SIM = 2.0;
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_07_1.png"];
    [self setDisplayFrame:frame];
    
    if (isElite) {
        health *=2;
        id action1 = [self SpawnTintAction];
        [self runAction:[CCRepeatForever actionWithAction:action1]];
    }
    
    [self scheduleUpdate];
}

-(void)shoot{
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache ShootOneBulletAndRotateTo:self.position FrameName:@"dl_pe_b_071.png"];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 250;
        point = 35;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation NormalFlyEight

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        //        CGFloat width = self.boundingBox.size.width;
        //        CGFloat height = self.boundingBox.size.height;
        //        return CGRectMake(self.position.x - width/3, self.position.y - height/3, width/3*2, height/3*2);
        CGRect rect = CGRectMake(self.position.x -10, self.position.y - 10, 20, 20);
        if (CGRectIntersectsRect([player GetDamageRect], rect)) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_bigenemy_01_1.png"];
    [self setDisplayFrame:frame];
    
    xuanzhuan = [XuanZhuanBulletEmitter node];
    xuanzhuan.canPlayNormalEffect = NO;
    xuanzhuan.leftOrRight = YES;
    xuanzhuan.shootCountMax = 12 * 3;
    [self addChild:xuanzhuan];
    
    tongdaoo = [TongDaoBulletEmitter node];
    tongdaoo.canPlayNormalEffect = NO;
    tongdaoo.shootCountMax = 5;
    [self addChild:tongdaoo];
    tongdaot = [TongDaoBulletEmitter node];
    tongdaot.canPlayNormalEffect = NO;
    tongdaot.shootCountMax = 5;
    [self addChild:tongdaot];
    
    duoge = [DuoGeBulletEmitter node];
    duoge.canPlayNormalEffect = NO;
    [self addChild:duoge];
    
    [self scheduleUpdate];
}

-(void)shoot{
    NSInteger rand = arc4random()%3;
    switch (rand) {
        case 0:
            [xuanzhuan ShootAt:ccp(0, 0) withTarget:nil];
            break;
        case 1:
            [tongdaoo ShootAt:ccp(-10, 0) withTarget:nil];
            [tongdaot ShootAt:ccp(10, 0) withTarget:nil];
            break;
        case 2:
            [duoge ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
            break;
        default:
            break;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 1000;
        point = 50;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end

#import "Bullet.h"

@implementation NormalFlyNine

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        //        CGFloat width = self.boundingBox.size.width;
        //        CGFloat height = self.boundingBox.size.height;
        //        return CGRectMake(self.position.x - width/3, self.position.y - height/3, width/3*2, height/3*2);
        CGRect rect = CGRectMake(self.position.x -10, self.position.y - 10, 20, 20);
        if (CGRectIntersectsRect([player GetDamageRect], rect)) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}
-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    //    CCSpriteFrame * frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_enemy_01_1.png"];
    //    [self setDisplayFrame:frame];
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_bigenemy_02_" AnimateCacheName:nil];
    [self runAction:[CCRepeatForever actionWithAction:action]];
    
    duodianone = [QianFangDuoDianBulletEmitter node];
    duodianone.canPlayNormalEffect = NO;
    duodianone.times = 2;
    [self addChild:duodianone];
    duodianS = [QianFangDuoDianSingleBulletEmitter node];
    duodianS.canPlayNormalEffect = NO;
    duodianS.times = 4;
    [self addChild:duodianS];
    
    
    [self scheduleUpdate];
}

-(void)shoot{
    NSInteger rand = arc4random()%3;
    switch (rand) {
        case 0:
            [self kuosandanmu];
            break;
        case 1:
            [duodianone ShootAt:ccp(0, 0) withTarget:nil];
            break;
        case 2:
            [duodianS ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
            break;
        default:
            break;
    }
}

-(void) kuosandanmu{
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:self.position velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 2000;
        point = 100;
    }
    return self;
}

@end

@implementation NormalFlyTen

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        //        CGFloat width = self.boundingBox.size.width;
        //        CGFloat height = self.boundingBox.size.height;
        //        return CGRectMake(self.position.x - width/3, self.position.y - height/3, width/3*2, height/3*2);
        CGRect rect = CGRectMake(self.position.x -10, self.position.y - 10, 20, 20);
        if (CGRectIntersectsRect([player GetDamageRect], rect)) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
    [super SpawnAt:sp WithMoveType:mt HasArticle:whichArt AndShootIntervalMax:SIM isElite:isElite];
    
    id action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_bigenemy_03_" AnimateCacheName:nil];
    [self runAction:[CCRepeatForever actionWithAction:action]];
    
    duoge = [DuoGeBulletEmitter node];
    duoge.canPlayNormalEffect = NO;
    [self addChild:duoge];
    duodianSO = [QianFangDuoDianSingleBulletEmitter node];
    duodianSO.canPlayNormalEffect = NO;
    duodianSO.times = 2;
    [self addChild:duodianSO];
    duodianST = [QianFangDuoDianSingleBulletEmitter node];
    duodianST.canPlayNormalEffect =NO;
    duodianST.times = 2;
    [self addChild:duodianST];
    shaoshe = [ShaoSheBulletEmitter node];
    shaoshe.canPlayNormalEffect = NO;
    shaoshe.times =7;
    [self addChild:shaoshe];
    
    
    [self scheduleUpdate];
}

-(void)shoot{
    NSInteger rand = arc4random()%3;
    switch (rand) {
        case 0:
            [duoge ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
            break;
        case 1:
            [duodianSO ShootAt:ccp(-10, 0) withTarget:nil ];
            [duodianST ShootAt:ccp(10, 0) withTarget:nil];
            break;
        case 2:
            [shaoshe ShootAt:ccp(0, 0) withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
            break;
        default:
            break;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        health = 2500;
        point = 150;
    }
    return self;
}

@end


