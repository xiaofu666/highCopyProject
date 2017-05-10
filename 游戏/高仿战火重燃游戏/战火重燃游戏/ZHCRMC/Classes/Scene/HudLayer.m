//
//  HudLayer.m
//  ZHCRCB
//
//  Created by jiangyu on 12-12-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"
#import "CCBReader.h"

#import "DateHandle.h"
#import "Player.h"
#import "PlayingScene.h"

@implementation HudLayer

-(void) playerChickNuke:(CCMenuItemImage*)nukeMenu{
//    PlayerPlayingScene * mainScene = (PlayerPlayingScene *)self.parent;
    if (!gameOver) {
        [[PlayingScene SharedPlayingScene] shootNuke];
    }
}
-(void)resetNukeButtonImage:(NSInteger)index{
    NSString * stringS;
    if (!hudGetSceneFlyType) {
        stringS = @"dl_ui_c_a";
    }else{
        stringS = @"dl_ui_c_b";
    }
    NSString * string = [NSString stringWithFormat:@"%@%d.png",stringS,index+2];
    [nukeSprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:string]];
}

-(void) playerChickAddWeapon:(CCMenuItemImage*)addWeapon{
    if (![[[PlayingScene SharedPlayingScene] getPlayer] GetShootComponentAddWeaponLevel]) {
        return;
    }
    if (canCheckAddWeapon && !gameOver) {
        addSprite.visible = NO;
        [self addWeaponButtonEffect];
        [[PlayingScene SharedPlayingScene] shootAddWeapon];
    }
}

-(void) addWeaponButtonEffect{ //播放addweapon 的效果
        canCheckAddWeapon = NO;
        isInCooding = YES;
    
    addSprite.visible = NO;
    
    addWeaponTimer.percentage = 0;
    [self scheduleOnce:@selector(AddWeaponEnd) delay:20];
    CCProgressFromTo * timerTo = [CCProgressFromTo actionWithDuration:20 from:0 to:100];
    [addWeaponTimer runAction:timerTo];
    
}

-(void)resetAddWeaponSpritePercentage{
    [addWeaponTimer stopAllActions];
    [self unschedule:@selector(AddWeaponEnd)];

    addSprite.visible = NO;
    
    canCheckAddWeapon = NO;
    addWeaponTimer.percentage = 0;
    isInCooding = NO;
}

-(void) AddWeaponEnd{
    [self unschedule:@selector(AddWeaponEnd)];
    canCheckAddWeapon = YES;
    isInCooding = NO;
    
    addSprite.visible = YES;
    
    addWeaponTimer.percentage = 0;
}

-(void)resetBossHealthBar:(CGFloat)percentage{
    if (!healthSprite.visible) {
        healthSprite.visible = YES;
    }
    healthTimer.percentage = percentage;
}
-(void)hidHealthSprite{
    healthTimer.percentage = 0;
    healthSprite.visible = NO;
}


-(void)resetPoint:(NSInteger)point{
    [pointLabel setString:[NSString stringWithFormat:@"%d",point]];
}



-(void) drawPlayerLifeCount:(NSInteger)lifecount WithPlayerType:(NSInteger)playertype{
    [playerLifeSprite removeAllChildrenWithCleanup:YES];
    
    lifecount --;
    if (lifecount==0) {
        return;
    }
    
    NSString * frameName;
    if (playertype) {
        frameName = @"dl_role_02_1.png";
    }else{
        frameName = @"dl_role_01_1.png";
    }
    
    for (int i=0; i<lifecount; i++) {
        CCSprite * sprite = [CCSprite spriteWithSpriteFrameName:frameName];
        sprite.position = ccp(20*i,10);
        sprite.scale = 0.7;
        sprite.anchorPoint  = ccp(0.5, 0.5);
        [playerLifeSprite addChild:sprite];
    }
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Animations/UIHudAndDrop.plist"];
        canCheckAddWeapon = NO;//初始化时不能使用 addweapon
        size = [[CCDirector sharedDirector]winSize];
        
        hudGetSceneFlyType = [[PlayingScene SharedPlayingScene] getPlayerType];//getflytype
        NSString * stringS = nil;//= @"whichImage";  //选择模型名字
        NSString * stringM = nil;// menu name
        if (!hudGetSceneFlyType) {
            stringM = @"dl_ui_c_a1.png";
            stringS = @"dl_ui_c_a5.png";
        }else{
            stringM = @"dl_ui_c_b1.png";
            stringS = @"dl_ui_c_b5.png";
        }//添加nuke  menu sprite
        CCMenuItemImage * nukeMenu = [CCMenuItemImage itemWithTarget:self selector:@selector(playerChickNuke:)];
        [nukeMenu setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:stringM]];
        nukeMenu.position = ccp(size.width - 30 , 30);
        nukeSprite  = [[CCSprite alloc] initWithSpriteFrameName:stringS];
        nukeSprite.position = nukeMenu.position;
        [self addChild:nukeSprite]; // 添加nukesprite nukemenu把框体作为按钮
        
        if (!hudGetSceneFlyType) {
            stringS = @"dl_ui_c_04a.png";
            stringM = @"dl_ui_c_042.png";
        }else{
            stringS = @"dl_ui_c_04b.png";
            stringM = @"dl_ui_c_042.png";
        }// 添加addweapon sprite menu
        
        CCSprite * spriteAddweapenBackGround = [CCSprite spriteWithSpriteFrameName:stringS];
        spriteAddweapenBackGround.position = ccp(size.width - 80 , 30);
        [self addChild:spriteAddweapenBackGround];
        addSprite = [[CCSprite  alloc] initWithSpriteFrameName:@"dl_ui_c_044.png"]; //框体作为spirte
        CCMenuItemImage * addWeaponMenu = [CCMenuItemImage itemWithTarget:self selector:@selector(playerChickAddWeapon:)];
        [addWeaponMenu setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_c_042.png"]];
        addWeaponMenu.position = ccp(size.width - 80 , 30);
        addSprite.position = addWeaponMenu.position;
        
        CCSprite * addWeaponSprite = [CCSprite spriteWithSpriteFrameName:@"dl_ui_c_043.png"];
//        CCSprite * healthT = [CCSprite spriteWithSpriteFrameName:@"dl_ui_c_05b.png"];
//        healthTimer = [CCProgressTimer progressWithSprite:healthT];
        addWeaponTimer = [CCProgressTimer progressWithSprite:addWeaponSprite];
        addWeaponTimer.type = kCCProgressTimerTypeRadial;
        addWeaponTimer.percentage = 0;
        addWeaponTimer.position = addWeaponMenu.position;
        
        pauseMenuxxx = [CCMenuItemImage itemWithTarget:self selector:@selector(pauseGame:)];
        [pauseMenuxxx setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pause.png"]];
         [pauseMenuxxx setDisabledSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"start.png"]];
        pauseMenuxxx.position = ccp(20, size.height-20);
        
        [pauseMenuxxx retain];
        
        //add menus
        CCMenu * menu = [CCMenu menuWithItems:nukeMenu,addWeaponMenu,pauseMenuxxx, nil];
        menu.anchorPoint =ccp(0, 0);
        menu.position =ccp(0,0);
        [self addChild:menu];
        //添加在上面
        [self addChild:addWeaponTimer];
        addSprite.visible = NO;
        [self addChild:addSprite]; // 把 空白的框体 作为按钮
        [addWeaponSprite retain];
        
        //加载 分数sprite
        if (!hudGetSceneFlyType) {
            stringS = @"dl_ui_c_031.png";
//            stringM = @"dl_ui_c_04_2.png";
        }else{
            stringS = @"dl_ui_c_032.png";
//            stringM = @"dl_ui_c_04_2.png";
        }//
        CCSprite * pointScrite = [CCSprite spriteWithSpriteFrameName:stringS];
        pointScrite.position = ccp(size.width - 45, size.height-25);
        [self addChild:pointScrite];
        
        pointLabel = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:14];
        pointLabel.position = pointScrite.position;
        pointLabel.horizontalAlignment = kCCTextAlignmentRight;
        [self addChild:pointLabel];
        
        if (!hudGetSceneFlyType) {
            stringS = @"dl_ui_c_051.png";
            //            stringM = @"dl_ui_c_04_2.png";
        }else{
            stringS = @"dl_ui_c_052.png";
            //            stringM = @"dl_ui_c_04_2.png";
        }//
        healthSprite = [CCSprite spriteWithSpriteFrameName:stringS];
        healthSprite.position = ccp(150, size.height-25);
        healthSprite.visible = NO;
        [self addChild:healthSprite];
        CCSprite * healthT = [CCSprite spriteWithSpriteFrameName:@"dl_ui_c_05b.png"];
        healthTimer = [CCProgressTimer progressWithSprite:healthT];
        healthTimer.type = kCCProgressTimerTypeBar;
        healthTimer.midpoint = ccp(0, 0);
        //	Setup for a horizontal bar since the bar change rate is 0 for y meaning no vertical change
        healthTimer.barChangeRate = ccp(1,0);
        healthTimer.position = healthSprite.position;
        healthTimer.percentage = 0;
        [self addChild:healthTimer];
        
        gameOver = NO;
        
                
        playerLifeSprite = [CCSprite node];
        [self addChild:playerLifeSprite];
        playerLifeSprite.position = ccp(15, 10);
//        [self GameOverwithPlayerLife:0 DamageEnemyCount:0 GetPoint:0];
//        [self drawPlayerLifeCount:4];
        
        [self InitGameOverSprite];
        [self InitGamePassSprite];
        [self InitPassCurrentLevelSprite];
        [self InitPauseSprite];
    }
    return self;
}

//-(void) initNukeMenu{
//    nukeMenu = 
//}
//
//-(void) initAddMenu{
//    
//}
//
//-(void) initPauseMenu{
//    
//}
//
//-(void) initPointSprite{
//    
//}
//
//-(void) initHealthBarSprite{
//    
//}

-(void) InitPauseSprite{
    
    pauseSprite = [CCSprite spriteWithSpriteFrameName:@"dl_ui_a_07.png"];
    pauseSprite.position = ccp(size.width/2, size.height/2);
    pauseSprite.anchorPoint = ccp(0.5, 0.5);
    pauseSprite.visible = NO;
    [self addChild:pauseSprite];
    
    CCMenuItemImage * newGame = [CCMenuItemImage itemWithTarget:self selector:@selector(restartGame)];
    [newGame setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_08a.png"]];
    [newGame setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_08b.png"]];
    newGame.position = ccp(75, 45);
    newGame.scale = 0.8;
    CCMenuItemImage * continueGame = [CCMenuItemImage itemWithTarget:self selector:@selector(resumeGame) ];
    [continueGame setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03a.png"]];
    [continueGame setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03b.png"]];
    continueGame.position = ccp(230, 45);
    continueGame.scale = 0.8;
    CCMenu * pauseMenu =[CCMenu menuWithItems:newGame,continueGame, nil];
    pauseMenu.anchorPoint =ccp(0, 0);
    pauseMenu.position =ccp(0,0);
    
    [pauseSprite addChild:pauseMenu];
}


-(void) InitPassCurrentLevelSprite{
    passCurrentLevelSprite = [CCSprite spriteWithSpriteFrameName:@"dl_ui_a_05.png"];
    passCurrentLevelSprite.position = ccp(size.width/2, size.height/2);
    passCurrentLevelSprite.anchorPoint = ccp(0.5, 0.5);
    passCurrentLevelSprite.visible = NO;
    [self addChild:passCurrentLevelSprite];
#pragma mark - GameOverlabel
    
    CCLabelTTF * label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",0] fontName:@"DBLCDTempBlack" fontSize:20];
    label1.position = ccp(200, 175);
    [passCurrentLevelSprite addChild:label1 z:1 tag:GamePassCurrentHUDLayerDefineLifeLabel];
    CCLabelTTF * label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",0] fontName:@"DBLCDTempBlack" fontSize:20];
    label2.position = ccp(200, 130);
    [passCurrentLevelSprite addChild:label2 z:1 tag:GamePassCurrentHUDLayerDefineDamageCountLabel];
    CCLabelTTF * label3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",0] fontName:@"DBLCDTempBlack" fontSize:20];
    label3.position = ccp(200, 86);
    [passCurrentLevelSprite addChild:label3 z:1 tag:GamePassCurrentHUDLayerDefinePointLabel];
    
#pragma mark - GameOvermenu
    CCMenuItemImage * backToMain = [CCMenuItemImage itemWithTarget:self selector:@selector(backToMainMenu)];
    [backToMain setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_02a.png"]];
    [backToMain setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_02b.png"]];
    backToMain.position = ccp(78, 48);
    backToMain.scale = 0.8;
    CCMenuItemImage * nextGame = [CCMenuItemImage itemWithTarget:self selector:@selector(nextGame:)];
    [nextGame setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03a.png"]];
    [nextGame setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_03b.png"]];
    nextGame.position = ccp(227, 48);
    nextGame.scale = 0.8;
    CCMenu * menu = [CCMenu menuWithItems:backToMain,nextGame, nil];
    menu.anchorPoint =ccp(0, 0);
    menu.position =ccp(0,0);
    [passCurrentLevelSprite addChild:menu];
    
}
-(void) InitGamePassSprite{
    
    gamePassSprite = [CCSprite spriteWithSpriteFrameName:@"dl_ui_a_03.png"];
    gamePassSprite.position = ccp(size.width/2, size.height/2);
    gamePassSprite.anchorPoint = ccp(0.5, 0.5);
    gamePassSprite.visible = NO;
    [self addChild:gamePassSprite ];
    
    CCLabelTTF * label1 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label1.position = ccp(200, 175);
    [gamePassSprite addChild:label1 z:1 tag:GamePassHUDLayerDefineLifeLabel];
    CCLabelTTF * label2 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label2.position = ccp(200, 130);
    [gamePassSprite addChild:label2 z:1 tag:GamePassHUDLayerDefineDamageCountLabel];
    CCLabelTTF * label3 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label3.position = ccp(200, 86);
    [gamePassSprite addChild:label3 z:1 tag:GamePassHUDLayerDefinePointLabel];
    
    CCMenuItemImage * paiHangBang = [CCMenuItemImage itemWithTarget:self selector:@selector(PaiHangBang:)];
    [paiHangBang setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ld_03_005.png"]];
    [paiHangBang setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ld_03_006.png"]];
    paiHangBang.position = ccp(gamePassSprite.boundingBox.size.width/2, 45);
    paiHangBang.scale = 0.8;
    CCMenu * menu = [CCMenu menuWithItems:paiHangBang, nil];
    menu.anchorPoint =ccp(0, 0);
    menu.position =ccp(0,0);
    [gamePassSprite addChild:menu];
}

-(void) InitGameOverSprite{
    
    gameOverSprite = [CCSprite spriteWithSpriteFrameName:@"dl_ui_a_04.png"];
    gameOverSprite.position = ccp(size.width/2, size.height/2);
    gameOverSprite.anchorPoint = ccp(0.5, 0.5);
    gameOverSprite.visible = NO;
    [self addChild:gameOverSprite];
#pragma mark - GameOverlabel
    CCLabelTTF * label1 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label1.position = ccp(200, 175);
    [gameOverSprite addChild:label1 z:1 tag:GameOverHUDLayerDefineLifeLabel];
    CCLabelTTF * label2 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label2.position = ccp(200, 130);
    [gameOverSprite addChild:label2 z:1 tag:GameOverHUDLayerDefineDamageCountLabel];
    CCLabelTTF * label3 = [CCLabelTTF labelWithString:@"0" fontName:@"DBLCDTempBlack" fontSize:20];
    label3.position = ccp(200, 86);
    [gameOverSprite addChild:label3 z:1 tag:GameOverHUDLayerDefinePointLabel];
#pragma mark - GameOvermenu
    CCMenuItemImage * paiHangBang = [CCMenuItemImage itemWithTarget:self selector:@selector(PaiHangBang:)];
    [paiHangBang setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ld_03_005.png"]];
    [paiHangBang setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ld_03_006.png"]];
    paiHangBang.position = ccp(227, 50);
    paiHangBang.scaleX = 0.9;
    paiHangBang.scaleY = 0.8;
    //        restartGame.scaleY =
    CCMenuItemImage * mainMenu = [CCMenuItemImage itemWithTarget:self selector:@selector(backToMainMenu)];
    [mainMenu setNormalSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_02a.png"]];
    [mainMenu setSelectedSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dl_ui_b_02b.png"]];
    mainMenu.position = ccp(78, 50);
    mainMenu.scale = 0.8;
    CCMenu * menu = [CCMenu menuWithItems:paiHangBang,mainMenu, nil];
    menu.anchorPoint =ccp(0, 0);
    menu.position =ccp(0,0);
    [gameOverSprite addChild:menu];
}



-(void) GameOverwithPlayerLife:(NSInteger)playerLife DamageEnemyCount:(NSInteger)enemyCount GetPoint:(NSInteger)point{
    if (!gameOver) {
        gameOver = YES;
        gameOverSprite.visible = YES;
        CCNode *playerLifeNode = [gameOverSprite getChildByTag:GameOverHUDLayerDefineLifeLabel];
        if ([playerLifeNode isKindOfClass:[CCLabelTTF class]]) {
            CCLabelTTF * playerLifeT = (CCLabelTTF *)playerLifeNode;
            [playerLifeT setString:[NSString stringWithFormat:@"%d",playerLife]];
        }
        CCNode *playerEnemyNode = [gameOverSprite getChildByTag:GameOverHUDLayerDefineDamageCountLabel];
        if ([playerEnemyNode isKindOfClass:[CCLabelTTF class]]) {
            CCLabelTTF * playerEnemyT = (CCLabelTTF *)playerEnemyNode;
            [playerEnemyT setString:[NSString stringWithFormat:@"%d",enemyCount]];
        }
        CCNode *playerPointNode = [gameOverSprite getChildByTag:GameOverHUDLayerDefinePointLabel];
        if ([playerPointNode isKindOfClass:[CCLabelTTF class]]) {
            CCLabelTTF * playerPointT = (CCLabelTTF *)playerPointNode;
            [playerPointT setString:[NSString stringWithFormat:@"%d",point]];
        }
        
    }
}

-(void)drawCurrentGameEndwithPlayerLife:(NSInteger)playerLife DamageEnemyCount:(NSInteger)enemyCount GetPoint:(NSInteger)point{
    NSInteger currentGameLevel = [[PlayingScene SharedPlayingScene] getLevel];
    if (!gameOver) {
        gameOver = YES;
        if (currentGameLevel==6) {
            [self saveDateForPaiHangBang];
            gamePassSprite.visible = YES;
            CCNode *playerLifeNode = [gamePassSprite getChildByTag:GamePassHUDLayerDefineLifeLabel];
            if ([playerLifeNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerLifeT = (CCLabelTTF *)playerLifeNode;
                [playerLifeT setString:[NSString stringWithFormat:@"%d",playerLife]];
            }
            CCNode *playerEnemyNode = [gamePassSprite getChildByTag:GamePassHUDLayerDefineDamageCountLabel];
            if ([playerEnemyNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerEnemyT = (CCLabelTTF *)playerEnemyNode;
                [playerEnemyT setString:[NSString stringWithFormat:@"%d",enemyCount]];
            }
            CCNode *playerPointNode = [gamePassSprite getChildByTag:GamePassHUDLayerDefinePointLabel];
            if ([playerPointNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerPointT = (CCLabelTTF *)playerPointNode;
                [playerPointT setString:[NSString stringWithFormat:@"%d",point]];
            }
            
        }else{
            passCurrentLevelSprite.visible = YES;
            CCNode *playerLifeNode = [passCurrentLevelSprite getChildByTag:GamePassCurrentHUDLayerDefineLifeLabel];
            if ([playerLifeNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerLifeT = (CCLabelTTF *)playerLifeNode;
                [playerLifeT setString:[NSString stringWithFormat:@"%d",playerLife]];
            }
            CCNode *playerEnemyNode = [passCurrentLevelSprite getChildByTag:GamePassCurrentHUDLayerDefineDamageCountLabel];
            if ([playerEnemyNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerEnemyT = (CCLabelTTF *)playerEnemyNode;
                [playerEnemyT setString:[NSString stringWithFormat:@"%d",enemyCount]];
            }
            CCNode *playerPointNode = [passCurrentLevelSprite getChildByTag:GamePassCurrentHUDLayerDefinePointLabel];
            if ([playerPointNode isKindOfClass:[CCLabelTTF class]]) {
                CCLabelTTF * playerPointT = (CCLabelTTF *)playerPointNode;
                [playerPointT setString:[NSString stringWithFormat:@"%d",point]];
            }
        }
    }

}

-(void) saveDateForPaiHangBang{
    NSString * flyName;
    if ([[PlayingScene SharedPlayingScene] getPlayerType]) {
        flyName = @"dl_role_02_1.png";
    }else{
        flyName = @"dl_role_01_1.png";
    }
    
    NSInteger point = [[PlayingScene SharedPlayingScene] getPlayerPoint];
    [[DateHandle SharedDateHandle] insertDateWithScore:[NSNumber numberWithInteger:point] FlyName:flyName];
}

-(void)PaiHangBang:(id)sender{
    
    [self saveDateForPaiHangBang];
    
    [[DateHandle SharedDateHandle]clearnSaveDate];
    
    
    CCScene * paiHangBang = [CCBReader sceneWithNodeGraphFromFile:@"RecordScene.ccbi"];
    [[CCDirector sharedDirector] replaceScene:paiHangBang];
}


-(void) nextGame:(CCMenuItemImage*)sender{
    if (isInCooding) {
        [self AddWeaponEnd]; //增强武器冷却
    }
    [self unscheduleAllSelectors];
    
    gamePassSprite.visible = NO;
    gameOverSprite.visible = NO;
    passCurrentLevelSprite.visible = NO;
    
    [self hidHealthSprite];
    
    gameOver = NO;
    
    [[PlayingScene SharedPlayingScene] startNextLevel];
}

-(void) restartGame{
    [[CCDirector sharedDirector] popScene];
//    CCScene * selectScene = [CCBReader sceneWithNodeGraphFromFile:@"PlayerSelectShip.ccbi"];
//    [[CCDirector sharedDirector] replaceScene:selectScene];
}
-(void) backToMainMenu{
//    CCScene * mainScene = [CCBReader sceneWithNodeGraphFromFile:@"GameMainScene.ccbi"];
//    [[CCDirector sharedDirector] replaceScene:mainScene];
    [[CCDirector sharedDirector]popScene];
}

-(void) pauseGame:(CCMenuItemImage*)sender{
//    CGSize size = [[CCDirector sharedDirector]winSize];
    [pauseMenuxxx setIsEnabled:NO];
    if (!pauseSprite.visible && !gameOver) {
        pauseSprite.visible = YES;
        gameOver = YES;
        [[CCDirector sharedDirector]pause];
    }
}
-(void) resumeGame{
    [pauseMenuxxx setIsEnabled:YES];
    gameOver = NO;
    pauseSprite.visible = NO;
    [[CCDirector sharedDirector]resume];
}

-(void)onEnter{
    [super onEnter];
    gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(doubleChick:)]autorelease];
    gesture.numberOfTapsRequired = 2;
    [[CCDirector sharedDirector].view addGestureRecognizer:gesture];
}

-(void) doubleChick:(id) sender{
//    NSLog(@"doubleChick!!!!");
    [self playerChickNuke:nil];
}

-(void)onExit{
    [super onExit];
    [[CCDirector sharedDirector].view removeGestureRecognizer:gesture];
}

- (void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
@end
