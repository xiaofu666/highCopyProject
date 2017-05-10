//
//  NormalFly.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
#import "Defines.h"


@interface NormalFly : Enemy {
    CGFloat outScrenTime;
    CGFloat moveInterval;//移动间隔时间
    CGFloat moveStopInterval;// 停顿时间
    CGFloat moveRadius; //弧线移动半径
    CGPoint lastPos; 
    
    BOOL isMoveStop;//是否停顿
    BOOL shootOnce;
    
    ShootType shootType;
    EnemyMoveType moveType;
    
//    EnemyType enemyType;
    
    NSInteger arcCount;//圈圈计数器
    
    
    NSMutableArray * emitterShootArray;
}

+(id) initWithEnemyType:(EnemyType) enemyType;

-(id) SpawnTintAction;
-(void) move:(const EnemyMoveType) mt;

-(void) moveTypeOneCalc;
-(void) moveTypeTwoCalc;
-(void) moveTypeThreeCalc;
-(void) moveTypeFourCalc;
-(void) moveTypeFiveCalc;
-(void) moveTypeSixCalc;
-(void) moveTypeSevenCalc;
-(void) moveTypeEightCalc;
-(void) moveTypeNineCalc;
-(void) moveTypeTenCalc;
-(void) moveTypeElevenCalc;

//-(void) moveTypeThirteenCalc;
@end

@interface NormalFlyOne : NormalFly

@end
@interface NormalFlyTwo : NormalFly

@end
@interface NormalFlyThree : NormalFly

@end
@class LianXuBulletEmitter;
@interface NormalFlyFour : NormalFly
{
    LianXuBulletEmitter * lianxu;
}
@end
@class DuoGeBulletEmitter;
@class QianFangDuoDianSingleBulletEmitter;
@interface NormalFlyFive : NormalFly
{
    QianFangDuoDianSingleBulletEmitter * duoge;
}
@end
@interface NormalFlySix : NormalFly
{
    DuoGeBulletEmitter * duoge;
}
@end
@interface NormalFlySeven : NormalFly

@end
@class XuanZhuanBulletEmitter;
@class TongDaoBulletEmitter;
@class DuoGeBulletEmitter;
@interface NormalFlyEight : NormalFly
{
    XuanZhuanBulletEmitter * xuanzhuan;
    TongDaoBulletEmitter * tongdaoo;
    TongDaoBulletEmitter * tongdaot;
    DuoGeBulletEmitter * duoge;
}

@end
@class QianFangDuoDianBulletEmitter;
@class QianFangDuoDianSingleBulletEmitter;
@interface NormalFlyNine : NormalFly{
    QianFangDuoDianBulletEmitter * duodianone;
    QianFangDuoDianSingleBulletEmitter * duodianS;
}

@end

@class ShaoSheBulletEmitter;
@interface NormalFlyTen : NormalFly{
    DuoGeBulletEmitter * duoge;
    QianFangDuoDianSingleBulletEmitter * duodianSO;
    QianFangDuoDianSingleBulletEmitter * duodianST;
    ShaoSheBulletEmitter    * shaoshe;
}

@end
