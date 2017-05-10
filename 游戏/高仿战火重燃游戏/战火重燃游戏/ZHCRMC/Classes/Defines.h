//
//  Defines.h
//  ZHCRMC
//
//  Created by jiangyu on 13-1-14.
//
//

#ifndef ZHCRMC_Defines_h
#define ZHCRMC_Defines_h

#define ARC4RANDOM_MAX 0x100000000

#define DateName @"SaveDateList"
#define DateplistName @"SaveDateList.plist"
#define SCOREA @"ScoreArray"
#define TimeA @"TimeArray"


#define GameOverHUDLayerDefinePointLabel 10
#define GameOverHUDLayerDefineLifeLabel 11
#define GameOverHUDLayerDefineDamageCountLabel 12

#define GamePassCurrentHUDLayerDefinePointLabel 13
#define GamePassCurrentHUDLayerDefineLifeLabel 14
#define GamePassCurrentHUDLayerDefineDamageCountLabel 15

#define GamePassHUDLayerDefinePointLabel 16
#define GamePassHUDLayerDefineLifeLabel 17
#define GamePassHUDLayerDefineDamageCountLabel 18



#define EnemyBulletSpeed 2.3


#define BigBoss1HealthMax 40000.0
#define BigBoss2HealthMax 40000.0
#define BigBoss3HealthMax 45000.0
#define BigBoss4HealthMax 45000.0
#define BigBoss5HealthMax 50000.0

typedef enum _PlayerShipState{
    shipState_idle = 0,
    shipState_move,
    shipState_death
}PlayerShipState;

typedef enum _PlayerShootType{
    clusterBomb_Bullet = 0,
    pellet_Bullet,
    laser_Bullet
}PlayerShootType;


typedef enum _EnemyMoveType{
    EnemyMoveType_one = 1,
    EnemyMoveType_two,
    EnemyMoveType_three,
    EnemyMoveType_four,
    EnemyMoveType_five,
    EnemyMoveType_six,
    EnemyMoveType_seven,
    EnemyMoveType_eight,
    EnemyMoveType_nine,
    EnemyMoveType_ten,
    EnemyMoveType_eleven,
    EnemyMoveType_twelve
//    EnemyMoveType_thirteen
}EnemyMoveType;

typedef enum _EnemyType{
    EnemyType_one = 1,
    EnemyType_two,
    EnemyType_three,
    EnemyType_four,
    EnemyType_five,
    EnemyType_six,
    EnemyType_seven,
    EnemyType_eight,
    EnemyType_nine,
    EnemyType_ten
}EnemyType;
typedef enum _ShootType{
    ShootType_emitterRand = 0,
    ShootType_one,
    ShootType_two,
    ShootType_three
}ShootType;


typedef struct EnemySpawnDetail{
    NSInteger flyType;
    NSInteger moveType;
    CGFloat   startPos_X;// percentage
    CGFloat   startPos_Y;
    CGFloat   shootIntervalMax;
    NSInteger spawnType;
    NSInteger spawnCount;
    NSInteger dropArticle;
    BOOL      isEliteFly;
}EnemySpawnDetail;
//startGameWithLevel:(NSInteger)level PlayerType:(NSInteger)playerTypeT playerLifeCount:(NSInteger)life PlayerPoint:(NSInteger)point damageEnemyCount:(NSInteger) enemyCount NukeCount:(NSInteger) nukeCount AddWeaponLevel:(NSInteger)addweaponLevel WeaponLevel:(NSInteger) weaponLevel bulletType:(NSInteger) bulletType;
typedef struct _PlayerSaveDate{
    NSInteger level;
    NSInteger flyType;
    NSInteger life;
    NSInteger point;
    NSInteger enemyDamaged;
    NSInteger nukeCount;
    NSInteger addweaponLevel;
    NSInteger weaponType;
    NSInteger weaponLevel;
}PlayerSaveDate;
#endif
