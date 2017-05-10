//
//  Enemy.m
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

#import "DropArticleCache.h"
#import "PlayingScene.h"

@implementation Enemy
//
//-(void)SpawnWithEnemyType:(EnemyType)ET At:(CGPoint)spawnPos WithMoveType:(EnemyMoveType)MT HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
//    isEliteFly = isElite;
//    isDeath = NO;
//    [self setModel:ET];
//}

-(void)SpawnAt:(CGPoint)sp WithMoveType:(EnemyMoveType)mt HasArticle:(NSInteger)whichArt AndShootIntervalMax:(ccTime)SIM isElite:(BOOL)isElite{
//    startPos = sp;
//    self.position = sp;
//    moveType = mt;
//    artType = whichArt;
    isEliteFly = isElite;
}

-(void)SpawnAt:(CGPoint)spawnPos{
    self.position = spawnPos;
    self.visible = YES;
    isDeath = NO;
}

-(void)SpawnArtAt:(CGPoint)selfPos{
    DropArticleCache * dropcache = [[PlayingScene SharedPlayingScene] getDropActicleCache];
    if (isEliteFly) {
//
        NSInteger rand = arc4random() %2;
        [dropcache spawnArticleAt:self.position which:rand];
        return;
    }else if(artType == -1){
//
        NSInteger rand = arc4random() %3;
        [dropcache spawnArticleAt:self.position which:rand];
        return;
    }
//
    [dropcache spawnArticleAt:self.position which:3];
}

-(void)takeDamage:(CGFloat)damage{
    if (isDeath) {   return;    }
    
//    damageCount++;
    
    health -= damage;
    if (health<=0) {
//        NSLog(@"Be attrack Count:%d",damageCount);
        isDeath = YES;
        velocity = ccpMult(velocity, 0.3);
        [self stopAllActions];
        
        if (![self runDeathAction]) {
            [self Death];
        }
        [[PlayingScene SharedPlayingScene] setPoint:point];
        [[PlayingScene SharedPlayingScene] setDamageEnemyCount];
    }
}

-(BOOL)runDeathAction{
    return NO;
}

-(void) checkCollisionWithPlayer{
    
    Player * player = [[PlayingScene SharedPlayingScene] getPlayer];
    if (player!=nil) {
//        CGFloat width = self.boundingBox.size.width;
//        CGFloat height = self.boundingBox.size.height;
//        return CGRectMake(self.position.x - width/3, self.position.y - height/3, width/3*2, height/3*2);
        CGRect rect = CGRectMake(self.position.x -3, self.position.y - 3, 6, 6);
        if (CGRectIntersectsRect([player GetDamageRect], rect)) {
//            [self takeDamage:100];
            [player takeDamage:1];
        }
    }
}

-(BOOL)checkCollisionWithPoint:(CGPoint)pt{
    if (CGRectContainsPoint([self GetDamageRect], pt)) {
        return YES;
    }
    return NO;
}

-(BOOL)checkCollisionWithRect:(CGRect)rect{
    if (CGRectIntersectsRect([self GetDamageRect], rect)) {
        return YES;
    }
    return NO;
}

-(void)Death{
    [super Death];
    [self SpawnArtAt:self.position];
}

-(CGRect)GetDamageRect{
    if (!isDeath) {
        return self.boundingBox;
    }
    return CGRectZero;
}

-(BOOL)getDeath{
    return isDeath;
}

-(void)shoot{
    
}

-(void)canMove:(BOOL)cM{
    canMove = cM;
}


-(void)update:(ccTime)delta{
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        health = 1.0;
        point = 1;
        self.visible = NO;
        canMove = YES;
        velocity = ccp(0, 0);
        artType = 3;//默认掉了积分道具
        
    }
    return self;
}

- (void)dealloc
{

    [super dealloc];
}
@end
