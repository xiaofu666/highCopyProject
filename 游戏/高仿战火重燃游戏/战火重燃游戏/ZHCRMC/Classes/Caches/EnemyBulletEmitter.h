//
//  EnemyBulletEmitter.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
#import "Base.h"
@class Player;
@interface EnemyBulletEmitter : Base {
//    CGPoint velocity;
    CGPoint addPos;     // 相对位置
    CGPoint shootPos;   // 随飞机移动的发射位置
    CGPoint keepPos;    // 不随飞机移动的发射位置
    
    CGFloat angel;
    
    NSInteger shootCount;
    
    NSInteger timeCount;
    
    Player *target;
    
    CCSprite * normalEffect;
    
    CCSequence * normalEffect_action;
}
@property(nonatomic,assign) NSInteger shootCountMax;

@property(nonatomic,readwrite) NSInteger times;

@property(nonatomic,readwrite) BOOL canPlayNormalEffect;//是否播放effect

-(void) ShootAt:(CGPoint)sp withTarget:(Player*) targ;
-(void) Shoot:(ccTime)delta;

-(void) NormalEffectEnd;

@end


@interface LianXuBulletEmitter : EnemyBulletEmitter

@end

@interface TongDaoBulletEmitter : EnemyBulletEmitter{
}
    
@end

@interface SanDanBulletEmitter : EnemyBulletEmitter
@end

@interface KuoSanBulletEmitter : EnemyBulletEmitter
@end

@interface QianFangDuoDianBulletEmitter : EnemyBulletEmitter

@end

@interface QianFangDuoDianSingleBulletEmitter : EnemyBulletEmitter{
    CGPoint oldVeloc;
}

@end

@interface XuanZhuanBulletEmitter : EnemyBulletEmitter
@property(nonatomic,readwrite) BOOL leftOrRight;//向那边发
@end

@interface DuoGeBulletEmitter : EnemyBulletEmitter

@end

@interface ShaoSheBulletEmitter : EnemyBulletEmitter

@end

@interface JiGuangBulletEmitter : EnemyBulletEmitter{
    BOOL effectEnd;
    CGFloat shoorInterval;
    CCSprite * effectSprite;
}
@property(nonatomic,strong) id shootEffect_Action;
@end


@interface FaSheHouKuoSan : EnemyBulletEmitter

@end