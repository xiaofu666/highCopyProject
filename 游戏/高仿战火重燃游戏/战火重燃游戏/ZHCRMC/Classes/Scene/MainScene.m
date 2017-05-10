//
//  MainScene.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"

#import "CCBReader.h"
#import "AppDelegate.h"

#import "PlayingScene.h"
#import "DateHandle.h"

//#import "RJFViewController.h"

@implementation MainScene

-(void) didLoadFromCCB{
    ischeck= NO;
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addPVRImage:@"Animations/NukeEffect.pvr.ccz"];
    CCSprite * sprite = [CCSprite spriteWithTexture:texture];
    [self addChild:sprite];
    texture = [[CCTextureCache sharedTextureCache] addPVRImage:@"Animations/BigBossEffect.pvr.ccz"];
    CCSprite * sprite1 = [CCSprite spriteWithTexture:texture];
    [self addChild:sprite1];
    sprite.visible = NO;
    sprite1.visible = NO;
    texture = [[CCTextureCache sharedTextureCache] addPVRImage:@"Animations/BulletEffect.pvr.ccz"];
    CCSprite * sprite2 = [CCSprite spriteWithTexture:texture];
    [self addChild:sprite2];
    sprite2.visible = NO;
    
    spriteCountinue = [CCSprite spriteWithSpriteFrameName:@"dl_ui_a_07.png"];
    spriteCountinue.position = ccp(size.width/2, size.height/2);
    [self addChild:spriteCountinue];
    CCMenuItemImage * newGame = [CCMenuItemImage itemWithTarget:self selector:@selector(startNewGame)];
    [newGame setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_08a.png"]];
    [newGame setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_08b.png"]];
    newGame.position = ccp(75, 45);
    newGame.scale = 0.8;
    CCMenuItemImage * continueGame = [CCMenuItemImage itemWithTarget:self selector:@selector(continuesGame) ];
    [continueGame setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03a.png"]];
    [continueGame setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03b.png"]];
    continueGame.position = ccp(230, 45);
    continueGame.scale = 0.8;
    CCMenu * menu =[CCMenu menuWithItems:newGame,continueGame, nil];
    menu.anchorPoint =ccp(0, 0);
    menu.position =ccp(0,0);
    [spriteCountinue addChild:menu];
    
    spriteCountinue.visible = NO;
}

-(void) StartGame:(id) sender{
//    [self startNewGame];
    if (spriteCountinue.visible || ischeck) {
        return;
    }
    ischeck = YES;
    NSUserDefaults * defaultsDate = [NSUserDefaults standardUserDefaults];
    if ([defaultsDate boolForKey:@"HasSave"]) {
        spriteCountinue.visible = YES;
    }else
        [self startNewGame];
}

-(void) startNewGame{
    spriteCountinue.visible = NO;
    [[CCDirector sharedDirector] resume];
    CCScene * scene = [CCBReader sceneWithNodeGraphFromFile:@"PlayerSelect.ccbi"];
    [[CCDirector sharedDirector] pushScene:scene];
    ischeck = NO;
}

-(void) continuesGame{
    spriteCountinue.visible = NO;
    PlayerSaveDate date = [[DateHandle SharedDateHandle] ReadSaveDate];
    [[CCDirector sharedDirector] resume];
    PlayingScene * scene = [PlayingScene SharedPlayingScene];
    [scene startGameWithLevel:date.level PlayerType:date.flyType playerLifeCount:date.life PlayerPoint:date.point damageEnemyCount:date.enemyDamaged NukeCount:date.nukeCount AddWeaponLevel:date.addweaponLevel WeaponLevel:date.weaponLevel bulletType:date.weaponType];
    [[CCDirector sharedDirector] pushScene:scene];
    ischeck = NO;
}

-(void) Record:(id) sender{
    if (spriteCountinue.visible || ischeck) {
        return;
    }
    CCScene * scene = [CCBReader sceneWithNodeGraphFromFile:@"RecordScene.ccbi"];
    [[CCDirector sharedDirector] pushScene:scene];
}

-(void) MoreGame:(id) sender{
    if (spriteCountinue.visible || ischeck) {
        return;
    }
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    if (!CGRectContainsPoint(spriteCountinue.boundingBox, touchLocation)) {
        spriteCountinue.visible = NO;
        ischeck = NO;
    }
    return YES;
}

-(void)onEnter{
    [super onEnter];
    [[[CCDirector sharedDirector ]touchDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void)onExit{
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
}
@end
