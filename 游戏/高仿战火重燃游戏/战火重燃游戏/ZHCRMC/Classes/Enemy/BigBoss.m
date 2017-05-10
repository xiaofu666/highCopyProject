//
//  BigBoss.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BigBoss.h"
#import "EnemyBulletEmitter.h"
#import "PlayingScene.h"
#import "Bullet.h"
#import "HudLayer.h"
#import "BulletCache.h"

@implementation BigBoss

- (id)init
{
    self = [super init];
    if (self) {
        point = 500;
        beTintTo = YES;
        
//        id deathAction = [self LoadAnimationActionEndFrame:15 StartFram:1 Delta:0.01 AnimateName:@"dl_pe_b_03"  AnimateCacheName:@"smallFlyDeath"];
//        CCCallFunc * deathF = [CCCallFunc actionWithTarget:self selector:@selector(Death)];
//        self.death_Action = [CCSequence actionOne:deathAction two:deathF];
    }
    return self;
}

-(void)SpawnAt:(CGPoint)spawnPos{
    [super SpawnAt:spawnPos];
     velocity = ccp(0, -1);
    health = healthMax;
    CGSize size = [[CCDirector sharedDirector]winSize];
    lastPos = ccp(size.width/2, size.height/5*3);
    
    [self loadEmitter]; //加载武器
    
    [self scheduleUpdate];
    [self runIdleAction];
}

-(void) runIdleAction{
    
}

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self GetDamageRect])) {//CGRectContainsPoint([player GetDamageRect], self.position)
            [player takeDamage:1];
        }
    }
}

-(void)update:(ccTime)delta{
    if (isDeath) {
        return;
    }
    if (ccpDistance(self.position, lastPos )<=5) {
        velocity = CGPointZero;
        velocity = [self GetNextMoveToVeloc];
    }
    if (canMove) {
        self.position = ccpAdd(self.position, ccpMult(velocity,0.4));
    }
    [self isInScreenRect];
    [self checkCollisionWithPlayer];
    shootInterval += delta;
    
    if (shootInterval>shootIntervalMax) {
        [self shoot];
        shootInterval =0.0f;
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

-(void)takeDamage:(CGFloat)damage{
    [super takeDamage:damage];
    HudLayer * hudLayer = [[PlayingScene SharedPlayingScene] getHudlayer];
    if(isDeath){
        [hudLayer hidHealthSprite];
        [[PlayingScene SharedPlayingScene] currentLevelOver];
        return;
    }
    CGFloat percentage = health/healthMax * 100;
    [hudLayer resetBossHealthBar:percentage];
    
    if (beTintTo && !isDeath) {
        beTintTo = NO;
        CCTintTo * tint = [CCTintTo actionWithDuration:0.08 red:255 green:0 blue:0];
        CCTintTo * tintback = [CCTintTo actionWithDuration:0.08 red:255 green:255 blue:255];
        CCCallFunc * tintEnd = [CCCallFunc actionWithTarget:self selector:@selector(TintEnd)];
        CCSequence * seq = [CCSequence actions:tint,tintback,tintEnd,nil ];
//        CCSpawn * spawn = [CCSpawn actionOne:seq two:self.idle_Action];
//        [self stopAllActions];
        [self runAction:seq];
    }
}

-(void)Death{
    [super Death];
    isDeath = YES;
    self.visible = NO;
    [self unscheduleAllSelectors];
    [self scheduleOnce:@selector(removeFromParentxx) delay:2.0];
}

-(void) removeFromParentxx{
    [self removeFromParentAndCleanup:YES];
}

-(BOOL)runDeathAction{
    id deathAction = [self LoadAnimationActionEndFrame:15 StartFram:1 Delta:0.01 AnimateName:@"dl_pe_b_03"  AnimateCacheName:@"smallFlyDeath"];
    CCCallFunc * deathF = [CCCallFunc actionWithTarget:self selector:@selector(Death)];
    CCSequence * sequence = [CCSequence actionOne:deathAction two:deathF];
    [self runAction:sequence];
    return YES;
}

-(void) TintEnd{
    beTintTo = YES;
//    [self stopAllActions];
//    [self runAction:self.idle_Action];
//    [self runAction:[CCRepeatForever actionWithAction: self.idle_Action]];
}


-(void)shoot{
    
}

-(void)loadEmitter{
    
}

-(void)canMove:(BOOL)cM{
    canMove = cM;
}

@end


@implementation BigBossOne

- (id)init
{
    self = [super init];
    if (self) {
        healthMax = BigBoss1HealthMax;
        shootIntervalMax = 2.0f;
        health = healthMax;
        shootIndex = 0;
//        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss01_" AnimateCacheName:@"bigBossOne"];
    }
    return self;
}

-(void)runIdleAction{
    id idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss01_" AnimateCacheName:@"bigBossOne"];
    [self runAction:[CCRepeatForever actionWithAction:idle_Action]];
}

-(CGRect) getRectOne{
    return CGRectMake(self.position.x - 49, self.position.y +12,98 ,20);
}
-(CGRect) getRectTwo{
    return CGRectMake(self.position.x - 7, self.position.y - 30,22,37);
}

-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self getRectOne], pt) ||
        CGRectContainsPoint([self getRectTwo], pt)) {
        return true;
    }
    return false;
}
-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self getRectOne], rect) ||
        CGRectIntersectsRect([self getRectTwo], rect)) {
        return true;
    }
    return false;
}

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self getRectOne]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectTwo])) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}

-(void)loadEmitter{
    CCSprite * spriteF = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss01_1.png"];
    CGPoint posInChild = ccp(spriteF.textureRect.size.width/2, spriteF.textureRect.size.height/2);
    
    tongdao1 = [TongDaoBulletEmitter node];
    tongdao1.position = posInChild;
    tongdao1.shootCountMax = 7;
    [self addChild:tongdao1];
    
    tongdao2 = [TongDaoBulletEmitter node];
    tongdao2.position = posInChild;
    tongdao2.shootCountMax = 7;
    [self addChild:tongdao2];
    
    xuanzhuan0 = [XuanZhuanBulletEmitter node];
    xuanzhuan0.position = posInChild;
    xuanzhuan0.shootCountMax = 12*5;
    [self addChild:xuanzhuan0];
    
    xuanzhuan1 = [XuanZhuanBulletEmitter node];
    xuanzhuan1.position = posInChild;
    xuanzhuan1.leftOrRight = YES;
    xuanzhuan1.shootCountMax = 12*5;
    [self addChild:xuanzhuan1];
    
    xuanzhuan2 = [XuanZhuanBulletEmitter node];
    xuanzhuan2.position = posInChild;
    xuanzhuan2.shootCountMax = 12*5;
    [self addChild:xuanzhuan2];
    
    qianfang = [QianFangDuoDianBulletEmitter node];
    qianfang.position = posInChild;
    qianfang.times = 3;
    qianfang.shootCountMax = 6;
    [self addChild:qianfang];
    
    lianxu = [LianXuBulletEmitter node];
    lianxu.position = posInChild;
    lianxu.shootCountMax = 10;
    [self addChild:lianxu];
}

-(void)shoot{
    switch (shootIndex) {
        case 0:
            [self shootTongDaoEmitter];
            [self ShootDuoDianOnBehandEmitter];
            canMove = NO;
            shootIntervalMax = 2.0;
            break;
        case 1:
            [self shootXuanZhuanOnTopEmitter];
            [self shootLianXuOnTopEmitter];
            shootIntervalMax = 3.0;
            break;
        case 2:
            [self shootXuanZhuanAtLeft];
            shootIntervalMax = 3.0;
            break;
        case 3:
            [self shootXuanZhuanAtRight];
            shootIntervalMax = 3.0;
            break;
        case 4:
            [self shootXuanZhuanAtRight];
            [self ShootDuoDianOnBehandEmitter];
            canMove = NO;
            shootIntervalMax = 2.0;
            break;
        case 5:
            [self shootXuanZhuanAtLeft];
            [self shootXuanZhuanAtRight];
            shootIntervalMax = 3.0;
            break;
        case 6:
            [self shootTongDaoEmitterTwo];
            [self ShootDuoDianOnBehandEmitter];
            shootIntervalMax = 1.0;
            canMove = NO;
            break;
        default:
            break;
    }
    shootIndex ++;
    if (shootIndex>=6) {
        shootIndex =0;
    }
}


-(void) shootTongDaoEmitter{
    CGPoint leftOnePos = ccp(-48,0);
    CGPoint rightOnePos = ccp(+50,0);
    
    [tongdao1 ShootAt:leftOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [tongdao2 ShootAt:rightOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) shootTongDaoEmitterTwo{
    CGPoint leftOnePos = ccp(-48,0);
    CGPoint rightOnePos = ccp(+50,0);
    
    [tongdao1 ShootAt:leftOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [tongdao2 ShootAt:rightOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) shootXuanZhuanOnTopEmitter{
    CGPoint topPos = ccp(2,20);
    [xuanzhuan0 ShootAt:topPos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) shootXuanZhuanAtLeft{
    CGPoint leftOnePos = ccp(-48,0);
    [xuanzhuan1 ShootAt:leftOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) shootXuanZhuanAtRight{
     CGPoint rightOnePos = ccp(+50,0);
    [xuanzhuan2 ShootAt:rightOnePos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) ShootDuoDianOnBehandEmitter{
    CGPoint topPos = ccp(2,20);
    [qianfang ShootAt:topPos withTarget:nil];
}

-(void) shootLianXuOnTopEmitter{
    CGPoint topPos = ccp(2,20);
    [lianxu ShootAt:topPos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}


@end


@implementation BigBossTwo

- (id)init
{
    self = [super init];
    if (self) {
        healthMax = BigBoss2HealthMax;
        shootIntervalMax = 2.0f;
        health = healthMax;
        shootIndex = 0;
//        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss02_" AnimateCacheName:@"bigBossTwo"];
    }
    return self;
}
-(void)runIdleAction{
    id idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss02_" AnimateCacheName:@"bigBossTwo"];
    [self runAction:[CCRepeatForever actionWithAction:idle_Action]];
}

-(CGRect) getRectOne{
    return CGRectMake(self.position.x - 70, self.position.y - 36,140 ,60);
}

-(CGRect) getRectTwo{
    return CGRectMake(self.position.x - 44, self.position.y - 86,28 ,65);
}

-(CGRect) getRectThree{
    return CGRectMake(self.position.x + 20, self.position.y - 85,28 ,65);
}

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self getRectOne]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectTwo]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectThree])) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}
-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self getRectOne],pt) ||
        CGRectContainsPoint([self getRectTwo],pt) ||
        CGRectContainsPoint([self getRectThree],pt)) {
        return true;
    }
    return false;
}
-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self getRectOne], rect) ||
        CGRectIntersectsRect([self getRectTwo], rect) ||
        CGRectIntersectsRect([self getRectThree], rect)) {
        return true;
    }
    return false;
}

-(void)loadEmitter{
    CCSprite * spriteF = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss02_1.png"];
    CGPoint posInChild = ccp(spriteF.textureRect.size.width/2, spriteF.textureRect.size.height/2);
//    QianFangDuoDianBulletEmitter    * duodiantop;
    duodiantop  = [QianFangDuoDianSingleBulletEmitter node];
    duodiantop.position = posInChild;
    duodiantop.times = 4;
    duodiantop.shootCountMax = 4;
    [self addChild:duodiantop];
//    QianFangDuoDianBulletEmitter    * duodianLeft;
    duodianLeft = [QianFangDuoDianBulletEmitter node];
    duodianLeft.position = posInChild;
    duodianLeft.times = 2;
    duodianLeft.shootCountMax = 6;
    [self addChild:duodianLeft];
//    QianFangDuoDianBulletEmitter    * duodianRight;
    duodianRight = [QianFangDuoDianBulletEmitter node];
    duodianRight.position = posInChild;
    duodianRight.shootCountMax = 6;
    duodianRight.times = 2;
    [self addChild:duodianRight];
//    
//    ShaoSheBulletEmitter            * shaosheLeft;
    shaosheLeft = [ShaoSheBulletEmitter node];
    shaosheLeft.position = posInChild;
    [self addChild:shaosheLeft];
//    ShaoSheBulletEmitter            * shaosheRight;
    shaosheRight = [ShaoSheBulletEmitter node];
    shaosheRight.position = posInChild;
    [self addChild:shaosheRight];
//    
//    KuoSanBulletEmitter             * kuosan;
    kuosan = [KuoSanBulletEmitter node];
    kuosan.position = posInChild;
    kuosan.times = 5;
    [self addChild:kuosan];
//    
//    LianXuBulletEmitter             * lianxuOne;
    lianxuOne = [LianXuBulletEmitter node];
    lianxuOne.position = posInChild;
    lianxuOne.shootCountMax = 10;
    [self addChild:lianxuOne];
//    LianXuBulletEmitter             * lianxuTwo;
    lianxuTwo = [LianXuBulletEmitter node];
    lianxuTwo.position = posInChild;
    lianxuTwo.shootCountMax = 10;
    [self addChild:lianxuTwo];
//    
//    TongDaoBulletEmitter            * tongdaoOne;
    tongdaoOne = [TongDaoBulletEmitter node];
    tongdaoOne.position = posInChild;
    tongdaoOne.shootCountMax = 10;
    [self addChild:tongdaoOne];
//    TongDaoBulletEmitter            * tongdaoTwo;
    tongdaoTwo = [TongDaoBulletEmitter node];
    tongdaoTwo.position = posInChild;
    tongdaoTwo.shootCountMax = 10;
    [self addChild:tongdaoTwo];
//    TongDaoBulletEmitter            * tongdaoThree;
    tongdaoThree = [TongDaoBulletEmitter node];
    tongdaoThree.position = posInChild;
    tongdaoThree.shootCountMax = 10;
    [self addChild:tongdaoThree];
//    TongDaoBulletEmitter            * tongdaoFour;
    tongdaoFour = [TongDaoBulletEmitter node];
    tongdaoFour.position = posInChild;
    tongdaoFour.shootCountMax = 10;
    [self addChild:tongdaoFour];
//    
//    XuanZhuanBulletEmitter          * xuanzhuan;
    xuanzhuan = [XuanZhuanBulletEmitter node];
    xuanzhuan.position = posInChild;
    xuanzhuan.shootCountMax = 12;
    [self addChild:xuanzhuan];
}

-(void) shoot{
    switch (shootIndex) {
        case 0:
            canMove = NO;
            [self ShuangTongDaoEmitterAtMidPos];
            shootIntervalMax = 1.0;
            break;
        case 1:
            [self QianFangDuoDianEmitterAtLefftPos];
            [self QianFangDuoDianEmitterAtRightPos];
            shootIntervalMax = 2.0;
            break;
        case 2:
            [self QuanFangWeiKuoSanAtCenterPos];
            shootIntervalMax = 3.0;
            break;
        case 3:
            [self JiQiangShaoSheAtLeftArmPos];
            [self JiQiangShaoSheAtRightArmPos];
            shootIntervalMax = 3.0;
            break;
        case 4:          
            canMove = NO;
            [self QianFangDuoDianEmitterAtTopPos];
            [self ShuangTongDaoEmitterAtMidPos];  
            shootIntervalMax = 3.0;
            break;
        case 5:
            [self JiaoChaDanEmitterAtOutSidePos];
            shootIntervalMax = 1.0;
            break;
        case 6:
            [self JiaoChaDanEmitterAtInSidePos];
            shootIntervalMax = 2.0;
            break;
        case 7:
            [self JiQiangShaoSheAtLeftArmPos];
            [self QianFangDuoDianEmitterAtTopPos];
            shootIntervalMax = 1.0;
            break;
        case 8:
            [self QianFangDuoDianEmitterAtTopPos];
            shootIntervalMax = 1.0;
            break;
        case 9:
            [self JiQiangShaoSheAtRightArmPos];
            [self QianFangDuoDianEmitterAtTopPos];
            shootIntervalMax = 3.0;
            break;
        case 10:
            [self JiQiangShaoSheAtRightArmPos];
            [self JiQiangShaoSheAtLeftArmPos];
            shootIntervalMax = 3.0;
            break;
        case 11:
            [self XuanZhuanDanEmitterArCenterPos];
            shootIntervalMax =1.0;
            break;
        case 12:
            [self XuanZhuanDanEmitterArCenterPos];
            shootIntervalMax =1.0;
            break;
        case 13:
            [self XuanZhuanDanEmitterArCenterPos];
            shootIntervalMax =3.0;
            break;
        default:
            break;
    }
    
    shootIndex++;
    if(shootIndex>=13){
        shootIndex = 0;
    }
}

-(void) QianFangDuoDianEmitterAtTopPos{
    CGPoint pos = ccp(4, 28);
    [duodiantop ShootAt:pos withTarget:nil];
}

-(void) QianFangDuoDianEmitterAtLefftPos{
    CGPoint pos = ccp(-18, 51);
    [duodianLeft ShootAt:pos withTarget:nil];
}

-(void) QianFangDuoDianEmitterAtRightPos{
    CGPoint pos = ccp(18, 51);
    [duodianRight ShootAt:pos withTarget:nil];
}

-(void) JiQiangShaoSheAtLeftArmPos{
    CGPoint pos = ccp(-66, -45);
    [shaosheLeft ShootAt:pos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) JiQiangShaoSheAtRightArmPos{
    CGPoint pos = ccp(74, -45);
    [shaosheRight ShootAt:pos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) QuanFangWeiKuoSanAtCenterPos{
    CGPoint pos = ccp(4, 28);
    [kuosan ShootAt:pos withTarget:nil];
}

-(void) JiaoChaDanEmitterAtOutSidePos{
    CGPoint pos1 = ccp(-36, -90);
    CGPoint pos2 = ccp(44, -90);
    [lianxuOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) JiaoChaDanEmitterAtInSidePos{
    CGPoint pos1 = ccp(-20, -86);
    CGPoint pos2 = ccp(28, -86);
    [lianxuOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) ShuangTongDaoEmitterAtMidPos{
    CGPoint pos1 = ccp(-36, -90);
    CGPoint pos2 = ccp(44, -90);
    CGPoint pos3 = ccp(-20, -86);
    CGPoint pos4 = ccp(28, -86);
    [tongdaoOne ShootAt:pos1 withTarget:nil];
    [tongdaoTwo ShootAt:pos2 withTarget:nil];
    [tongdaoThree ShootAt:pos3 withTarget:nil];
    [tongdaoFour ShootAt:pos4 withTarget:nil];
}

-(void) XuanZhuanDanEmitterArCenterPos{
    CGPoint pos = ccp(4, 28);
    xuanzhuan.leftOrRight = arc4random() %2;
    [xuanzhuan ShootAt:pos withTarget:nil];
}

@end


@implementation BigBossThree

- (id)init
{
    self = [super init];
    if (self) {
        healthMax = BigBoss3HealthMax;
        shootIntervalMax = 2.0f;
        health = healthMax;
        shootIndex = 0;
//        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss03_" AnimateCacheName:@"bigBossThree"];
        
    }
    return self;
}
-(void)runIdleAction{
    id idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss03_" AnimateCacheName:@"bigBossThree"];
    [self runAction:[CCRepeatForever actionWithAction:idle_Action]];
}

-(CGRect) getRectOne{
    return CGRectMake(self.position.x - 70, self.position.y - 37,130 ,75);
}

-(CGRect) getRectTwo{
    return CGRectMake(self.position.x - 75, self.position.y - 60,11 ,60);
}

-(CGRect) getRectThree{
    return CGRectMake(self.position.x + 65, self.position.y - 60,11 ,60);
}

-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self getRectOne]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectTwo]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectThree])) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}
-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self getRectOne],pt) ||
        CGRectContainsPoint([self getRectTwo],pt) ||
        CGRectContainsPoint([self getRectThree],pt)) {
        return true;
    }
    return false;
}
-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self getRectOne], rect) ||
        CGRectIntersectsRect([self getRectTwo], rect) ||
        CGRectIntersectsRect([self getRectThree], rect)) {
        return true;
    }
    return false;
}

-(void) NormalEffectEnd{
    effectspriteO.visible = NO;
    effectspriteT.visible = NO;
}

-(void)loadEmitter{
//    JiGuangBulletEmitter * jiguang;
    CCSprite * spriteF = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss03_1.png"];
    CGPoint posInChild = ccp(spriteF.textureRect.size.width/2, spriteF.textureRect.size.height/2);

    //effectsprite
    
    effectspriteO = [CCSprite spriteWithSpriteFrameName:@"010007.png"];
    effectspriteO.visible = NO;
    [self addChild:effectspriteO];
    
    effectspriteT = [CCSprite spriteWithSpriteFrameName:@"010007.png"];
    effectspriteT.visible = NO;
    [self addChild:effectspriteT];
    
    CCBlink * blink = [CCBlink actionWithDuration:0.1 blinks:2];
    CCCallFunc * callfun = [CCCallFunc actionWithTarget:self selector:@selector(NormalEffectEnd)];
    effect_Sequence_Action = [CCSequence actionOne:blink two:callfun];
    [effect_Sequence_Action retain];
    
    // loadEmitters
    jiguang = [JiGuangBulletEmitter node];
    
    jiguang.position = posInChild;
    [self addChild:jiguang];
//    ShaoSheBulletEmitter * shaosheOne;
    shaosheOne = [ShaoSheBulletEmitter node];
    shaosheOne.position = posInChild;
    [self addChild:shaosheOne];
//    ShaoSheBulletEmitter * shaosheTwo;
    shaosheTwo = [ShaoSheBulletEmitter node];
    shaosheTwo.position = posInChild;
    [self addChild:shaosheTwo];
//    QianFangDuoDianBulletEmitter * duodianOne;
    duodianOne = [QianFangDuoDianBulletEmitter node];
    duodianOne.position = posInChild;
    duodianOne.times = 1;
    duodianOne.shootCountMax = 6;
    [self addChild:duodianOne];
//    QianFangDuoDianBulletEmitter * duodianTwo;
    duodianTwo = [QianFangDuoDianBulletEmitter node];
    duodianTwo.position = posInChild;
    duodianTwo.times = 1;
    duodianTwo.shootCountMax = 6;
    [self addChild:duodianTwo];
}

-(void)shoot{
    switch (shootIndex) {
        case 0:
            [self QianFangDuodianOne];
            [self QianFangDuodianTwo];
            shootIntervalMax = 5.0;
            break;
        case 1:
            [self topLeftShoot];
            shootIntervalMax = 3;
            break;
        case 2:
            [self topRightShoot];
            shootIntervalMax = 3;
            break;
        case 3:
            [self MainShoot];
            shootIntervalMax = 7.0;
            break;
        case 4:
            [self FaSheHouKuoSanOne];
            shootIntervalMax = 5.0;
            break;
        case 5:
            [self FaSheHouKuoSanTwo];
            shootIntervalMax = 6.0;
            break;
        case 6:
            [self topLeftShoot];
            [self topRightShoot];
            shootIntervalMax = 3.0;
            break;
        default:
            break;
    }
    shootIndex ++;
    if(shootIndex>=7){
        shootIndex = 0;
    }
}

-(void) MainShoot{
    CGPoint pos = ccp(0, -30);
    [jiguang ShootAt:pos withTarget:nil];
}

-(void) topLeftShoot{
    CGPoint pos = ccp(-16, 11);
    [shaosheOne ShootAt:pos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) topRightShoot{
    CGPoint pos = ccp(22, 11);
    [shaosheTwo ShootAt:pos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) QianFangDuodianOne{
    CGPoint pos = ccp(-36, -36);
    [duodianOne ShootAt:pos withTarget:nil];
}

-(void) QianFangDuodianTwo{
    CGPoint pos = ccp(36, -36);
    [duodianTwo ShootAt:pos withTarget:nil];
}

-(void) FaSheHouKuoSanOne{
    
    CGPoint pos = ccp(-69, -61);
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    
    
    effectspriteO.position = ccp(20, 12);
    effectspriteO.visible = YES;
    [effectspriteO runAction:effect_Sequence_Action];
    
    
    [bulletCache shootBulletAt:ccpAdd(self.position, pos) velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];
//    [kuosanDanmu shootBulletAt:pos velocity:ccp(0, -1) frameName:@"dl_pe_b_061.png" isPlayerBullet:NO Damage:1];
}

-(void) FaSheHouKuoSanTwo{
    CGPoint pos = ccp(69, -61);
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    
    
    effectspriteT.position = ccp(160, 12);
    effectspriteT.visible = YES;
    [effectspriteT runAction:effect_Sequence_Action];
    
    
    [bulletCache shootBulletAt:ccpAdd(self.position, pos) velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];
//    [kuosanDanmu shootBulletAt:pos velocity:ccp(0, -1) frameName:@"dl_pe_b_061.png" isPlayerBullet:NO Damage:1];
}

- (void)dealloc
{
    if (effect_Sequence_Action) {
        [effect_Sequence_Action release];
        effect_Sequence_Action = nil;
    }
    [super dealloc];
}

@end


@implementation BigBossFour

- (id)init
{
    self = [super init];
    if (self) {
        healthMax = BigBoss4HealthMax;
        shootIntervalMax = 2.0f;
        health = healthMax;
        shootIndex = 0;
//        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss04_" AnimateCacheName:@"bigBossThree"];
    }
    return self;
}

-(void)runIdleAction{
    id idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss04_" AnimateCacheName:@"bigBossThree"];
    [self runAction:[CCRepeatForever actionWithAction:idle_Action]];
}

-(CGRect) getRectOne{
    return CGRectMake(self.position.x - 98, self.position.y,187 ,23);
}
-(CGRect) getRectTwo{
    return CGRectMake(self.position.x - 40, self.position.y - 29,80,20);
}

-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self getRectOne], pt) ||
        CGRectContainsPoint([self getRectTwo], pt)) {
        return true;
    }
    return false;
}
-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self getRectOne], rect) ||
        CGRectIntersectsRect([self getRectTwo], rect)) {
        return true;
    }
    return false;
}
-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self getRectOne]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectTwo])) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}

-(void)loadEmitter{
    CCSprite * spriteF = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss04_1.png"];
    CGPoint pos = ccp(spriteF.textureRect.size.width/2, spriteF.textureRect.size.height/2);
//    JiGuangBulletEmitter    * jiguangOne;
    jiguangOne = [JiGuangBulletEmitter node];
    jiguangOne.times = 2;
    jiguangOne.position = pos;
    [self addChild:jiguangOne];
//    JiGuangBulletEmitter    * jiguangTwo;
    jiguangTwo = [JiGuangBulletEmitter node];
    jiguangTwo.times = 2;
    jiguangTwo.position = pos;
    [self addChild:jiguangTwo];
//    JiGuangBulletEmitter    * jiguangThree;
    jiguangThree = [JiGuangBulletEmitter node];
    jiguangThree.times = 2;
    jiguangThree.position = pos;
    [self addChild:jiguangThree];
//    JiGuangBulletEmitter    * jiguangFour;
    jiguangFour = [JiGuangBulletEmitter node];
    jiguangFour.times = 2;
    jiguangFour.position = pos;
    [self addChild:jiguangFour];
//    
//    DuoGeBulletEmitter      * duogeBullet;
    duogeOne = [DuoGeBulletEmitter node];
    duogeOne.position = pos;
    duogeOne.shootCountMax = 8;
    [self addChild:duogeOne];
    duogeTwo = [DuoGeBulletEmitter node];
    duogeTwo.position = pos;
    duogeTwo.shootCountMax = 8;
    [self addChild:duogeTwo];
//
//    LianXuBulletEmitter     * lianxuOne;
    lianxuOne = [LianXuBulletEmitter node];
    lianxuOne.position = pos;
    lianxuOne.shootCountMax = 10;
    [self addChild:lianxuOne];
//    LianXuBulletEmitter     * lianxuTwo;
    lianxuTwo = [LianXuBulletEmitter node];
    lianxuTwo.position = pos;
    lianxuTwo.shootCountMax = 10;
    [self addChild:lianxuTwo];
//    
//    ShaoSheBulletEmitter    * shaoShe;
    shaoShe  = [ShaoSheBulletEmitter node];
    shaoShe.position = pos;
    shaoShe.shootCountMax = 15;
    [self addChild:shaoShe];
//    
//    QianFangDuoDianBulletEmitter * qianFangOne;
    qianFangOne = [QianFangDuoDianBulletEmitter node];
    qianFangOne.position = pos;
    qianFangOne.shootCountMax = 6;
    qianFangOne.times = 3;
    [self addChild:qianFangOne];
//    QianFangDuoDianBulletEmitter * qianFangTwo;
    qianFangTwo = [QianFangDuoDianBulletEmitter node];
    qianFangTwo.position = pos;
    qianFangTwo.shootCountMax = 6;
    qianFangTwo.times = 3;
    [self addChild:qianFangTwo];
}

-(void)shoot{
    switch (shootIndex) {
        case 0:
            [self JiGuangOne];
            shootIntervalMax = 1.0f;
            break;
        case 1:
            [self JiGuangTwo];
            shootIntervalMax = 1.0f;
            break;
        case 2:
            [self JiGuangThree];
            shootIntervalMax = 1.0f;
            break;
        case 3:
            [self JiGuangFour];
            shootIntervalMax = 2.0f;
            break;
        case 4:
            [self DuoGeBullet];
            shootIntervalMax = 4.0f;
            break;
        case 5:
            [self JiaoChaDanMu];
            shootIntervalMax = 3.0f;
            break;
        case 6:
            [self QianFangDuodianOne];
            shootIntervalMax = 3.0f;
            break;
        case 7:
            [self QianFangDuodianTwo];
            shootIntervalMax = 3.0f;
            break;
        case 8:
            [self JiQiangShaoShe];
            shootIntervalMax = 2.0f;
            break;
        case 9:
            [self JiaoChaDanMu];
            shootIntervalMax = 2.0f;
            break;
        case 10:
            [self JiQiangShaoShe];
            shootIntervalMax = 3.0f;
            break;
        case 11:
            [self QianFangDuodianOne];
            [self QianFangDuodianTwo];
            shootIntervalMax = 5.0;
            break;
        case 12:
            [self JiGuangOne];
            [self JiGuangFour];
            shootIntervalMax = 2.0f;
            break;
        case 13:
            [self JiGuangTwo];
            [self JiGuangThree];
            shootIntervalMax = 2.0f;
            break;
        default:
            break;
    }
    shootIndex++;
    if (shootIndex >13) {
        shootIndex = 0;
    }
}

-(void) JiGuangOne{
    CGPoint pos = ccp(-75.5, -20.5);
    [jiguangOne ShootAt:pos withTarget:nil];
}

-(void) JiGuangTwo{
    CGPoint pos = ccp(-37, -43);
    [jiguangTwo ShootAt:pos withTarget:nil];
}

-(void) JiGuangThree{
    CGPoint pos = ccp(41, -43);
    [jiguangThree ShootAt:pos withTarget:nil];
}

-(void) JiGuangFour{
    CGPoint pos = ccp(79.5, -20.5);
    [jiguangFour ShootAt:pos withTarget:nil];
}

-(void) DuoGeBullet{
    CGPoint pos1 = ccp(57, 10);
    CGPoint pos2 = ccp(-53, 10);
    [duogeOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [duogeTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) JiaoChaDanMu{
    CGPoint pos1 = ccp(100, -10);
    CGPoint pos2 = ccp(-92, -10);
    [lianxuOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) JiQiangShaoShe{
    CGPoint pos = ccp(6, -44);
    [shaoShe ShootAt:pos withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) QianFangDuodianOne{
    CGPoint pos = ccp(33, -36);
    [qianFangOne ShootAt:pos withTarget:nil];
}

-(void) QianFangDuodianTwo{
    CGPoint pos = ccp(-21, -36);
    [qianFangTwo ShootAt:pos withTarget:nil];
}


@end


@implementation BigBossFive

- (id)init
{
    self = [super init];
    if (self) {
        healthMax = BigBoss5HealthMax;
        shootIntervalMax = 2.0f;
        health = healthMax;
        shootIndex = 0;
//        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss05_" AnimateCacheName:@"bigBossThree"];
    }
    return self;
}

-(void)runIdleAction{
    id idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_enemy_bigboss05_" AnimateCacheName:@"bigBossThree"];
    [self runAction:[CCRepeatForever actionWithAction:idle_Action]];
}

-(CGRect) getRectOne{
    return CGRectMake(self.position.x - 91, self.position.y,186 ,35);
}
-(CGRect) getRectTwo{
    return CGRectMake(self.position.x - 78, self.position.y - 32,158,20);
}

-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self getRectOne], pt) ||
        CGRectContainsPoint([self getRectTwo], pt)) {
        return true;
    }
    return false;
}
-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self getRectOne], rect) ||
        CGRectIntersectsRect([self getRectTwo], rect)) {
        return true;
    }
    return false;
}
-(void)checkCollisionWithPlayer{
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
        if (CGRectIntersectsRect([player GetDamageRect], [self getRectOne]) ||
            CGRectIntersectsRect([player GetDamageRect], [self getRectTwo])) {
            //            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}
-(void)loadEmitter{
    CCSprite * spriteF = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss05_1.png"];
    CGPoint pos = ccp(spriteF.textureRect.size.width/2, spriteF.textureRect.size.height/2);
    paoguan = [CCSprite spriteWithSpriteFrameName:@"dl_enemy_bigboss05_3.png"];
    paoguan.anchorPoint = ccp(0.5, 0.7);
    paoguan.position = ccp(pos.x+5, pos.y - 21);
    [self addChild:paoguan];
    
    effectSprite = [CCSprite node];
    effectSprite.position = ccp(20,0);
    [paoguan addChild:effectSprite];
    
    id actionE = [self LoadAnimationActionEndFrame:4 StartFram:1 Delta:0.2 AnimateName:@"01000" AnimateCacheName:nil];
    CCCallFunc * effectFEnd = [CCCallFunc actionWithTarget:self selector:@selector(EffectEnd)];
    self.effect_Action = [CCSequence actionOne:actionE two:effectFEnd];
    
//    LianXuBulletEmitter * lianxuOne;
    lianxuOne = [LianXuBulletEmitter node];
    lianxuOne.position = pos;
    lianxuOne.shootCountMax = 10;
    [self addChild:lianxuOne];
//    LianXuBulletEmitter * lianxuTwo;
    lianxuTwo = [LianXuBulletEmitter node];
    lianxuTwo.position = pos;
    lianxuTwo.shootCountMax = 10;
    [self addChild:lianxuTwo];
//    LianXuBulletEmitter * lianxuThree;
    lianxuThree = [LianXuBulletEmitter node];
    lianxuThree.position = pos;
    lianxuThree.shootCountMax = 10;
    [self addChild:lianxuThree];
//    LianXuBulletEmitter * lianxuFour;
    lianxuFour = [LianXuBulletEmitter node];
    lianxuFour.position = pos;
    lianxuFour.shootCountMax = 10;
    [self addChild:lianxuFour];
//    
//    TongDaoBulletEmitter * tongdaoOne;
    tongdaoOne = [TongDaoBulletEmitter node];
    tongdaoOne.position = pos;
    tongdaoOne.shootCountMax = 10;
    [self addChild:tongdaoOne];
//    TongDaoBulletEmitter * tongdaoTwo;
    tongdaoTwo = [TongDaoBulletEmitter node];
    tongdaoTwo.position = pos;
    tongdaoTwo.shootCountMax = 10;
    [self addChild:tongdaoTwo];
//    TongDaoBulletEmitter * tongdaoThree;
    tongdaoThree = [TongDaoBulletEmitter node];
    tongdaoThree.position = pos;
    tongdaoThree.shootCountMax = 10;
    [self addChild:tongdaoThree];
//    TongDaoBulletEmitter * tongdaoFour;
    tongdaoFour = [TongDaoBulletEmitter node];
    tongdaoFour.position = pos;
    tongdaoFour.shootCountMax = 10;
    [self addChild:tongdaoFour];
//    
//    ShaoSheBulletEmitter * shaoSheOne;
    shaoSheOne = [ShaoSheBulletEmitter node];
    shaoSheOne.position = pos;
    shaoSheOne.times = 15;
    [self addChild:shaoSheOne];
//    ShaoSheBulletEmitter * shaoSheTwo;
    shaoSheTwo = [ShaoSheBulletEmitter node];
    shaoSheTwo.position = pos;
    shaoSheTwo.times = 15;
    [self addChild:shaoSheTwo];
    
//    QianFangDuoDianBulletEmitter * duodianOne;
    duodianOne = [QianFangDuoDianBulletEmitter node];
    duodianOne.position = pos;
    duodianOne.shootCountMax = 6;
    duodianOne.times = 3;
    [self addChild:duodianOne];
//    QianFangDuoDianBulletEmitter * duodianTwo;
    duodianTwo = [QianFangDuoDianBulletEmitter node];
    duodianTwo.position = pos;
    duodianTwo.shootCountMax = 6;
    duodianTwo.times = 3;
    [self addChild:duodianTwo];
//    
//    XuanZhuanBulletEmitter * xuanzhuanOne;
    xuanzhuanOne = [XuanZhuanBulletEmitter node];
    xuanzhuanOne.position = pos;
    xuanzhuanOne.leftOrRight = NO;
    xuanzhuanOne.shootCountMax = 12 * 5;
    [self addChild:xuanzhuanOne];
//    XuanZhuanBulletEmitter * xuanzhuanTwo;
    xuanzhuanTwo = [XuanZhuanBulletEmitter node];
    xuanzhuanTwo.position = pos;
    xuanzhuanTwo.leftOrRight = YES;
    xuanzhuanTwo.shootCountMax = 12 * 5;
    [self addChild:xuanzhuanTwo];
}

-(void)takeDamage:(CGFloat)damage{
    [super takeDamage:damage];
    
    if (isDeath) {
        paoguan.visible = NO;
        return;
    }
    
    if (paoguan && paoguan.numberOfRunningActions == 0 ) {
//        [paoguan stopAllActions];
        CCTintTo * tint = [CCTintTo actionWithDuration:0.08 red:255 green:0 blue:0];
        CCTintTo * tintback = [CCTintTo actionWithDuration:0.08 red:255 green:255 blue:255];
        CCSequence * seq = [CCSequence actions:tint,tintback,nil ];
        [paoguan runAction:seq];
    }
}

-(void)TintEnd{
    [super TintEnd];
//    [paoguan stopAllActions];
}

-(void)shoot{
    switch (shootIndex) {
        case 0:
            [self JiGuangMain];
            shootIntervalMax = 7.0;
            break;
        case 1:
            [self JiaoChaDanMu];
            shootIntervalMax = 3.0;
            break;
        case 2:
            [self ShuangXuanZhuanDanMu];
            shootIntervalMax = 5.0;
            break;
        case 3:
            canMove = NO;
            [self ShuangTongDaoDanMu];
            shootIntervalMax = 3.0;
            break;
        case 4:
            [self FaSheHouKuoSanZero];
            shootIntervalMax = 5.0;
            break;
        case 5:
            [self JiGuangMain];
            shootIntervalMax = 5.0;
            break;
        case 6:
            [self JiQiangShaoShe];
            shootIntervalMax = 5.0;
            break;
        case 7:
            [self FaSheHouKuoSanOne];
            [self FaSheHouKuoSanTwo];
            shootIntervalMax = 5.0;
            break;
        case 8:
            [self JiaoChaDanMu];
            shootIntervalMax = 4.0;
            break;
        case 9:
            canMove = NO;
            [self QianFangDuoDian];
            [self ShuangTongDaoDanMu];
            shootIntervalMax = 3.0;
            break;
        default:
            break;
    }
    shootIndex ++;
    if (shootIndex>9) {
        shootIndex =0;
    }
}

-(void) JiGuangMain{
    if (!target) {
        target = (CCNode *)[[PlayingScene SharedPlayingScene] getPlayer];
    }
    rotateIndex = 0;
    effectEnd = NO;
    canMove = NO;
    effectSprite.visible = YES;
    jiguangInterval = 0;
    
    CGPoint veloc = ccpSub(target.position, ccpAdd(self.position,ccp(5, -21) ));
    CGFloat ang = ccpToAngle(veloc);
    CGFloat degree =CC_RADIANS_TO_DEGREES(3.14/2 * 3 - ang);
    CCRotateTo * rotate = [CCRotateTo actionWithDuration:0.5 angle:degree];
    CCCallFunc * funcRotate = [CCCallFunc actionWithTarget:self selector:@selector(rotateEnd)];
    CCSequence * seq = [CCSequence actionOne:rotate two:funcRotate];
    [paoguan runAction:seq];
    
}
-(void) EffectEnd{
    effectEnd = YES;
    effectSprite.visible = NO;
}
-(CGPoint) getJiGuangShootLocation{
    CGPoint pos =[paoguan convertToWorldSpace:effectSprite.position];
    pos.x +=4;
    return pos;
}

-(void) JiGuangShoot:(ccTime) delta{
    jiguangInterval += delta;
    if (jiguangInterval>2) {
        [self unschedule:@selector(JiGuangShoot:)];
        CCRotateTo * rotate = [CCRotateTo actionWithDuration:0.5 angle:0];
        [paoguan runAction:rotate];
        canMove = YES;
    }
    if (effectEnd) {
        CGFloat radiues = CC_DEGREES_TO_RADIANS(paoguan.rotation - 180);
        CGPoint vel = ccp(sinf(radiues), cosf(radiues));
        BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
        Bullet * bullet = [Bullet bullet];
        [bulletCache shootBulletAt:[self getJiGuangShootLocation] velocity:ccpMult(vel,25) FrameName:@"dl_pe_b_081.png" isPlayerBullet:NO Bullet:bullet Damage:1.0];
    }
}

-(void) rotateEnd{
    [self unschedule:@selector(JiGuangShoot:)];
    [self schedule:@selector(JiGuangShoot:)];
    [effectSprite runAction:self.effect_Action];
}

#pragma mark - others shoot

-(void) FaSheHouKuoSanZero{
    CGPoint pos = [self getJiGuangShootLocation];
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:pos velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];

}
-(void) FaSheHouKuoSanOne{
    CGPoint pos = ccp(-70, -20);
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:ccpAdd(self.position, pos) velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];

}
-(void) FaSheHouKuoSanTwo{
    CGPoint pos = ccp(78, -20);
    KuoSanDanMu * kuosanDanmu = [KuoSanDanMu bullet];
    kuosanDanmu.visible = YES;
    BulletCache * bulletCache = [[PlayingScene SharedPlayingScene] getBulletCache];
    [bulletCache shootBulletAt:ccpAdd(self.position, pos) velocity:ccp(0, -1) FrameName:@"dl_pe_b_061.png" isPlayerBullet:NO Bullet:kuosanDanmu Damage:1];

}

-(void) JiaoChaDanMu{
    CGPoint pos1 = ccp(94, 0);
    CGPoint pos2 = ccp(-86, 0);
    CGPoint pos3 = ccp(47, -54);
    CGPoint pos4 = ccp(-41, -54);
    [lianxuOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuThree ShootAt:pos3 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [lianxuFour ShootAt:pos4 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) ShuangTongDaoDanMu{
    CGPoint pos1 = ccp(94, 0);
    CGPoint pos2 = ccp(-86, 0);
    CGPoint pos3 = ccp(47, -54);
    CGPoint pos4 = ccp(-41, -54);
    [tongdaoOne ShootAt:pos1 withTarget:nil];
    [tongdaoTwo ShootAt:pos2 withTarget:nil];
    [tongdaoThree ShootAt:pos3 withTarget:nil];
    [tongdaoFour ShootAt:pos4 withTarget:nil];

}

-(void) JiQiangShaoShe{
    CGPoint pos1 = ccp(47, -54);
    CGPoint pos2 = ccp(-41, -54);
    [shaoSheOne ShootAt:pos1 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
    [shaoSheTwo ShootAt:pos2 withTarget:[[PlayingScene SharedPlayingScene] getPlayer]];
}

-(void) QianFangDuoDian{
    CGPoint pos1 = ccp(47, -54);
    CGPoint pos2 = ccp(-41, -54);
    [duodianOne ShootAt:pos1 withTarget:nil];
    [duodianTwo ShootAt:pos2 withTarget:nil];
}

-(void) ShuangXuanZhuanDanMu{
    CGPoint pos1 = ccp(94, 0);
    CGPoint pos2 = ccp(-86, 0);
    [xuanzhuanOne ShootAt:pos1 withTarget:nil];
    [xuanzhuanTwo ShootAt:pos2 withTarget:nil];
}


- (void)dealloc
{
    target = nil;
    if (self.effect_Action) {
        [self.effect_Action release];
        self.effect_Action = nil;
    }
    [super dealloc];
}
@end