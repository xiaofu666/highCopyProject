//
//  HudLayer.h
//  ZHCRCB
//
//  Created by jiangyu on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


#define NUKESPRITE 1
#define ADDWEAPONSPRITE 2
#define POINTSPRITE 3
#define HEALTHBARSPRITE 4

@interface HudLayer : CCLayer {
    CGSize size;
    UITapGestureRecognizer * gesture;
    
    CCSprite * nukeSprite;
//    CCSprite * pauseS;
    CCSprite * healthSprite;
    CCSprite * addSprite;
    
    CCLabelTTF * pointLabel;
    CCProgressTimer * healthTimer;
    CCProgressTimer * addWeaponTimer;
    
    CCMenuItemImage * pauseMenuxxx;
//    CCMenuItemImage * nukeMenu;
//    CCMenuItemImage * addWeaponMenu;
//    
    
    
    CCSprite * playerLifeSprite;
    CCSprite * pauseSprite;
    CCSprite * passCurrentLevelSprite;
    CCSprite * gameOverSprite;
    CCSprite * gamePassSprite;
    
    BOOL canCheckAddWeapon;
    BOOL gameOver;
    BOOL isInCooding;
    
    NSInteger hudGetSceneFlyType;
}

-(void) resetPoint:(NSInteger)point;
-(void) resetNukeButtonImage:(NSInteger)index;
-(void) resetBossHealthBar:(CGFloat)percentage;
-(void) resetAddWeaponSpritePercentage;

-(void) hidHealthSprite;
-(void) addWeaponButtonEffect;

-(void) drawCurrentGameEndwithPlayerLife:(NSInteger)playerLife DamageEnemyCount:(NSInteger)enemyCount GetPoint:(NSInteger)point;


//-(void) GamePass;
-(void) GameOverwithPlayerLife:(NSInteger)playerLife DamageEnemyCount:(NSInteger)enemyCount GetPoint:(NSInteger)point;

-(void) drawPlayerLifeCount:(NSInteger)lifecount WithPlayerType:(NSInteger)playertype;


-(void) pauseGame:(CCMenuItemImage*)sender;
@end
