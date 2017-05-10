//
//  Player.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

#import "HudLayer.h"
#import "DropArticleCache.h"
#import "PlayingScene.h"
#import "PlayerMoveComponent.h"
#import "PlayerShootComponent.h"

@implementation Player

-(void)update:(ccTime)delta{
    self.position  = ccpAdd(self.position, velocity);
    if (!isdeath) {
        [self stateDe];
    }
}

-(void) stateDe{
    switch (currentState) {
        case shipState_idle:
            [self idle_fun];
            break;
        case shipState_move:
            [self move_fun];
            break;
        default:
            break;
    }
}
-(void) idle_fun{
    if (self.numberOfRunningActions==0) {
        [self runAction:self.idle_Action];
    }
}
-(void) move_fun{
    if (self.numberOfRunningActions==0) {
        [self runAction:self.move_Action];
    }
}
-(void) ChangeWeapon:(NSInteger) weaponType{
    [shootComponent setShootType:weaponType];
}
-(void) setTemporityAddWeapon{
    if (shootComponent) {
        [shootComponent temporaryAddAddWeapon];
    }
}
-(void) playShootEffect:(PlayerShootType)effectType{
    
}
-(void)takeDamage:(CGFloat)damage{
    if (!isdeath) {
        [self unscheduleUpdate];
        lifeCount --;
        isdeath = YES;
        canEatArt = NO;
        [[PlayingScene SharedPlayingScene] resetNukeCount:3];
        
        shootEffect.visible = NO;
        [shootComponent SetIsShoot:NO];
        
        [self OTArticle];//自己掉了物品
        [shootComponent resetShootComponent];//重置玩家shootcomponent
        [[[PlayingScene SharedPlayingScene] getHudlayer] resetAddWeaponSpritePercentage]; //addweapon 按钮设置为0
        [[PlayingScene SharedPlayingScene] drawPlayerlife:lifeCount];
        CCCallFunc *deathActionEnd = [CCCallFunc actionWithTarget:self  selector:@selector(Death)];
        id sequence = [CCSequence actionOne:self.death_Action two:deathActionEnd];
        [self runAction:sequence];
    }
}

-(void) spawn{
    self.visible = YES;
    isdeath = YES;
    canEatArt= YES;
    self.position = ccp(160, 30);
    
    [self unscheduleAllSelectors];
    [self scheduleUpdate];
//    currentState = shipState_idle;
    
    [shootComponent SetIsShoot:YES];
    
    id blink = [CCBlink actionWithDuration:2.0 blinks:5];
    id spawn = [CCSpawn actionOne:self.idle_Action two:blink];
    CCCallFunc * func = [CCCallFunc actionWithTarget:self selector:@selector(BlinkEnd)];
    id sequece = [CCSequence actionOne:spawn two:func];
    [self runAction:sequece];
}

-(void) OTArticle{
    NSInteger bulletLevel = [shootComponent getBulletLevel];
    if (bulletLevel>1) {
        for (int i=0; i<bulletLevel-2; i++) {
            [[[PlayingScene SharedPlayingScene] getDropActicleCache] spawnArticleAt:ccp(self.position.x+15*i, self.position.y+15*i) which:1 ];
        }
    }
    NSInteger addBulletLevel = [shootComponent getAddBulletLevel];
    if (addBulletLevel>1) {
        for (int i=0; i<addBulletLevel-1; i++) {
            [[[PlayingScene SharedPlayingScene] getDropActicleCache]spawnArticleAt:ccp(self.position.x+15*i, self.position.y+15*i) which:0 ];
        }
    }
}

#pragma  mark - @selectors

-(void)Death{
    if (lifeCount>0) {
        [self spawn];
    }else{
        [[PlayingScene SharedPlayingScene] gameOver];
    }
}

-(void) BlinkEnd{
    isdeath = NO;
}

#pragma mark - set

-(void)addPlayerLife{
    lifeCount ++;
    if (lifeMax) {
        lifeMax ++;
    }
    [[PlayingScene SharedPlayingScene] drawPlayerlife:lifeCount];
}

-(void) setPlayerLife:(NSInteger)life{
    if(lifeMax !=life)
        lifeMax = life;
    lifeCount = life;
}
-(void) setVelocity:(CGPoint)veloc{
    velocity = veloc;
}

-(void)setPlayerWeaponLevel:(NSInteger)weaponLevel WeaponType:(NSInteger)weaponType AddWeaponLevel:(NSInteger)addWeaponLevel{
    if (!shootComponent) {
        shootComponent = [PlayerShootComponent node];
        [self addChild:shootComponent];
    }
    
    [self ChangeWeapon:weaponType ];
    [shootComponent setBulletLevel:weaponLevel];
    [self setAddWeaponLevelAdd:addWeaponLevel];
}

-(void)setAddWeaponLevelAdd:(NSInteger) level{
    NSInteger addlevel = [shootComponent getAddBulletLevel];
    
    if (!addlevel && level) {
        [[[PlayingScene SharedPlayingScene] getHudlayer] addWeaponButtonEffect];
    }
    addlevel +=level;
    [shootComponent setAddWeaponLevel:addlevel];
}

#pragma mark - get

-(NSInteger)GetLifeMax{
    return lifeMax;
}

-(NSInteger)GetLifeCount{
    return lifeCount;
}

-(CGRect)GetDamageRect{
    if (!isdeath) {
        return CGRectMake(self.position.x-10,self.position.y -10, 20, 20);
    }
    return CGRectZero;
}
-(CGRect)GetEatArtRect{
    if (canEatArt) {
        return CGRectMake(self.position.x-10,self.position.y -10, 20, 20);
    }
    return CGRectZero;
}
-(CGPoint)GetShootPos{
    return CGPointMake(self.position.x, self.position.y+5);
}
-(CGPoint)GetLeftShootPosition{
    return CGPointZero;
}
-(CGPoint)GetRightShootPosition{
    return CGPointZero;
}

-(NSInteger)GetShootComponentAddWeaponLevel{
    if (shootComponent) {
        return [shootComponent getAddBulletLevel];
    }
    return 0;
}
-(NSInteger)GetWeaponLevel{
    if (shootComponent) {
        return [shootComponent getBulletLevel];
    }
    return 1;
}
-(NSInteger) GetWeaponType{
    if (shootComponent) {
        return [shootComponent getBulletType];
    }
    return 0;
}

#pragma mark - init 

-(void)setPosition:(CGPoint)pos{
    if (fabs(velocity.x)>0.1) {
        if (velocity.x>0.1) {
            self.flipX = YES;
        }else{
            self.flipX = NO;
        }
        currentState = shipState_move;
    }else{
        currentState = shipState_idle;
    }
    if ([self isOutsideScreenArea])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float halfWidth = self.contentSize.width * 0.5f;
		float halfHeight = self.contentSize.height * 0.5f;
		
		// Cap the position so the Ship's sprite stays on the screen
		if (pos.x < halfWidth)
		{
			pos.x = halfWidth;
		}
		else if (pos.x > (screenSize.width - halfWidth))
		{
			pos.x = screenSize.width - halfWidth;
		}
		
		if (pos.y < halfHeight)
		{
			pos.y = halfHeight;
		}
		else if (pos.y > (screenSize.height - halfHeight))
		{
			pos.y = screenSize.height - halfHeight;
		}
	}
    //	velocity = CGPointZero;
    [super setPosition:pos];
}

-(BOOL) isOutsideScreenArea{
	return (CGRectContainsRect(screenRect, [self boundingBox]));
}

- (id)init
{
    self = [super init];
    if (self) {
        self.visible = NO;
        isdeath = NO;
        velocity = ccp(0, 0);
        currentState = shipState_death;
        
         self.death_Action = [self LoadAnimationActionEndFrame:8 StartFram:1 Delta:0.1 AnimateName:@"dl_pe_a_01" AnimateCacheName:@"playerDeath"];
        
        shootEffect = [CCSprite node];
        [self addChild:shootEffect z:-1];
        shootEffect.visible = NO;
        
        moveComponent = [PlayerMoveComponent node];
        moveComponent.componentParent = self;
        [self addChild:moveComponent];
        shootComponent = [PlayerShootComponent node];
        shootComponent.player = self;
        [self addChild:shootComponent];
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

@end

#pragma mark -  playerssssssssssssssss

@implementation PlayerOne


-(CGPoint)GetLeftShootPosition{
    return CGPointMake(self.position.x - 20, self.position.y);
}
-(CGPoint)GetRightShootPosition{
    return CGPointMake(self.position.x + 20, self.position.y);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_role_01_"  AnimateCacheName:@"roleOne_idle"];
        self.move_Action = [self LoadAnimationActionEndFrame:4 StartFram:4 Delta:0.01 AnimateName:@"dl_role_01_" AnimateCacheName:@"roleOne_move"];
        
        shootEffect.position = ccp(22.7, 40);
    }
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

@end

@implementation PlayerTwo

-(CGPoint)GetLeftShootPosition{
    return CGPointMake(self.position.x - 20, self.position.y);
}
-(CGPoint)GetRightShootPosition{
    return CGPointMake(self.position.x + 20, self.position.y);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.idle_Action = [self LoadAnimationActionEndFrame:2 StartFram:1 Delta:0.05 AnimateName:@"dl_role_02_"  AnimateCacheName:@"roletwo_idle"];
        self.move_Action = [self LoadAnimationActionEndFrame:4 StartFram:4 Delta:0.01 AnimateName:@"dl_role_02_" AnimateCacheName:@"roletwo_move"];
        
        shootEffect.position = ccp(20.5, 40);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
