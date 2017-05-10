//
//  DropArticleCache.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-18.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "DropArticleCache.h"

#import "DropArticle.h"

@implementation DropArticleCache

-(void)cleanAllDrop{
    [self removeAllChildrenWithCleanup:YES];
}

-(void)spawnArticleAt:(CGPoint)pos which:(NSInteger)which{
    switch (which) {
        case 0:{
            BulletLevelArct * bulletLevel = [BulletLevelArct node];
            [bulletLevel spawnAt: pos];
            [self addChild:bulletLevel];
        }
            break;
        case 1:{
            BulletTypeArct * typeBu = [BulletTypeArct node];
            [typeBu spawnAt:pos];
            [self addChild:typeBu];
        }
            break;
        case 2:{
            NukeArct * nuke = [NukeArct node];
            [nuke spawnAt:pos];
            [self addChild:nuke];
        }
            break;
        case 3:{
            PointArct * point = [PointArct node];
            [point spawnAt:pos];
            [self addChild:point];
        }
            break;
        default:
            break;
    }
    //    isPlayerArt = NO;
}
@end
