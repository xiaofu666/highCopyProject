//
//  BigBoss.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
#import "Defines.h"

@class TongDaoBulletEmitter;
@class XuanZhuanBulletEmitter;
@class QianFangDuoDianBulletEmitter;
@class LianXuBulletEmitter;
@class ShaoSheBulletEmitter;
@class KuoSanBulletEmitter;
@class JiGuangBulletEmitter;
@class DuoGeBulletEmitter;
@class QianFangDuoDianSingleBulletEmitter;

@interface BigBoss : Enemy {
    CGPoint lastPos;
    
    NSInteger shootIndex;
    
    
    BOOL  beTintTo;
    
    BOOL dontMove;
    
}
-(void) loadEmitter;
-(void) TintEnd;
-(void) runIdleAction;
@end


@interface BigBossOne : BigBoss{
    TongDaoBulletEmitter    * tongdao1;
    TongDaoBulletEmitter    * tongdao2;
    
    XuanZhuanBulletEmitter  * xuanzhuan0;
    XuanZhuanBulletEmitter  * xuanzhuan1;
    XuanZhuanBulletEmitter  * xuanzhuan2;
    
    LianXuBulletEmitter     * lianxu;
    
    QianFangDuoDianBulletEmitter * qianfang;
}

@end

@interface BigBossTwo : BigBoss{
    QianFangDuoDianSingleBulletEmitter    * duodiantop;
    QianFangDuoDianBulletEmitter    * duodianLeft;
    QianFangDuoDianBulletEmitter    * duodianRight;
    
    ShaoSheBulletEmitter            * shaosheLeft;
    ShaoSheBulletEmitter            * shaosheRight;
    
    KuoSanBulletEmitter             * kuosan;
    
    LianXuBulletEmitter             * lianxuOne;
    LianXuBulletEmitter             * lianxuTwo;
    
    TongDaoBulletEmitter            * tongdaoOne;
    TongDaoBulletEmitter            * tongdaoTwo;
    TongDaoBulletEmitter            * tongdaoThree;
    TongDaoBulletEmitter            * tongdaoFour;
    
    XuanZhuanBulletEmitter          * xuanzhuan;
}

@end

@interface BigBossThree : BigBoss  {
    JiGuangBulletEmitter * jiguang;
    ShaoSheBulletEmitter * shaosheOne;
    ShaoSheBulletEmitter * shaosheTwo;
    QianFangDuoDianBulletEmitter * duodianOne;
    QianFangDuoDianBulletEmitter * duodianTwo;
    
    
    // effect sprite
    CCSprite * effectspriteO;
    CCSprite * effectspriteT;
    
    CCSequence * effect_Sequence_Action;
}

@end

@interface BigBossFour : BigBoss{
    
    JiGuangBulletEmitter    * jiguangOne;
    JiGuangBulletEmitter    * jiguangTwo;
    JiGuangBulletEmitter    * jiguangThree;
    JiGuangBulletEmitter    * jiguangFour;
    
    DuoGeBulletEmitter      * duogeOne;
    DuoGeBulletEmitter      * duogeTwo;
    
    LianXuBulletEmitter     * lianxuOne;
    LianXuBulletEmitter     * lianxuTwo;
    
    ShaoSheBulletEmitter    * shaoShe;
    
    QianFangDuoDianBulletEmitter * qianFangOne;
    QianFangDuoDianBulletEmitter * qianFangTwo;
}

@end

@interface BigBossFive : BigBoss{
    CCSprite * paoguan;
    CCSprite * effectSprite;
    ccTime jiguangInterval;
    CCNode * target;
    NSInteger rotateIndex;
    
    BOOL effectEnd;
    
#pragma mark - shootEmitter
    
    LianXuBulletEmitter * lianxuOne;
    LianXuBulletEmitter * lianxuTwo;
    LianXuBulletEmitter * lianxuThree;
    LianXuBulletEmitter * lianxuFour;
    
    TongDaoBulletEmitter * tongdaoOne;
    TongDaoBulletEmitter * tongdaoTwo;
    TongDaoBulletEmitter * tongdaoThree;
    TongDaoBulletEmitter * tongdaoFour;
    
    ShaoSheBulletEmitter * shaoSheOne;
    ShaoSheBulletEmitter * shaoSheTwo;
    
    QianFangDuoDianBulletEmitter * duodianOne;
    QianFangDuoDianBulletEmitter * duodianTwo;
    
    XuanZhuanBulletEmitter * xuanzhuanOne;
    XuanZhuanBulletEmitter * xuanzhuanTwo;
}
@property(strong,nonatomic) id effect_Action;

@end
