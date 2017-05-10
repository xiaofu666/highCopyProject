//
//  RecordScene.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "RecordScene.h"
#import "DateHandle.h"

@implementation RecordScene

-(void) didLoadFromCCB{
    [self LoadPaiHangBang];
}

-(void) BackToMainMenu:(id) sender{
    [[CCDirector sharedDirector] popScene];
}


-(void) LoadPaiHangBang{
    DateHandle * dateHandle = [DateHandle SharedDateHandle];
    [dateHandle LoadDate];
    NSArray * scoreArray = [dateHandle getScoreArray];
    NSArray * timeArray =  [dateHandle getFlyArray];
    NSInteger paihang = 1;
    
    CCNode * node = [self getChildByTag:1];
    
    if (scoreArray.count==0) {

        CCLabelTTF * label = [CCLabelTTF labelWithString:@"大神你还没开始玩呢 - -!" fontName:@"DBLCDTempBlack" fontSize:20];
        label.position = ccp(node.boundingBox.size.width/2, node.boundingBox.size.height/2);
        [node addChild:label];
        return;
    }

    CCLabelTTF * labelpai = [CCLabelTTF labelWithString:@"排名" fontName:@"DBLCDTempBlack" fontSize:20];
    CCLabelTTF * labelfen = [CCLabelTTF labelWithString:@"分数" fontName:@"DBLCDTempBlack" fontSize:20];
    CCLabelTTF * labelmoxing = [CCLabelTTF labelWithString:@"飞机类型" fontName:@"DBLCDTempBlack" fontSize:20];
    labelpai.position  = ccp(90, 350);
    labelfen.position  = ccp(160, 350);
    labelmoxing.position = ccp(230, 350);
    [node addChild:labelpai];
    [node addChild:labelfen];
    [node addChild:labelmoxing];
    for (int i=scoreArray.count -1; i>=0; i--) {
        NSNumber *score = [scoreArray objectAtIndex:i];
        CCSprite * sprite = [self pangHangSprite:paihang Score:[score integerValue] Time:[timeArray objectAtIndex:i]];
        paihang ++;
        [node addChild:sprite];
    }
}

-(CCSprite *) pangHangSprite:(NSInteger)paiHang Score:(NSInteger)score Time:(NSString*)time{
    CCSprite * sprite = [CCSprite node];
    sprite.position = ccp(90, 350 - 25*paiHang);
    
    CCLabelTTF * paiHangL = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",paiHang] fontName:@"DBLCDTempBlack" fontSize:20];
    paiHangL.position = ccp(0, 0);
    
    CCLabelTTF * scoreL = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"DBLCDTempBlack" fontSize:20];
    scoreL.position = ccp(70, 0);
    
    CCSprite * fly = [CCSprite spriteWithSpriteFrameName:time];
    fly.scale = 0.5;
    fly.position = ccp(140, 0);
    
    [sprite addChild:paiHangL];
    [sprite addChild:scoreL];
    [sprite addChild:fly];
    
    return sprite;
}
@end
