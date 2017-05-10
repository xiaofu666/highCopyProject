//
//  DateHandle.h
//  ZHCRC
//
//  Created by jiangyu on 13-1-8.
//
//

#import <Foundation/Foundation.h>
#import "Defines.h"

@interface DateHandle : NSObject{
    NSString * file;                //得到本地文件路径
    NSDictionary * dateDictionary; //存放文件内容的字典
    NSMutableArray * scoreArray; //分数数组
    NSMutableArray * flyArray;  //飞机类型数组
    
    
    NSString * enemyFile;
    NSDictionary * enemySpawnDictionary;
    NSMutableArray * timeControllArray;
    NSMutableArray * enemySpawnArray;
}

+(id) SharedDateHandle;
#pragma mark -
-(NSArray *)        getScoreArray;
-(NSArray *)        getFlyArray;
-(void)             LoadDate;//加载数据
-(BOOL)             SaveDateWithScoreArray:(NSArray *)scoreA AndTimeArray:(NSArray*)timeA;//保存数据
    
-(BOOL)             insertDateWithScore:(NSNumber *)score FlyName:(NSString*)flyName; //插入数据

#pragma mark -
-(void)             SaveCurrentLevelPassedDateWithStruct:(PlayerSaveDate)date;
-(PlayerSaveDate)   ReadSaveDate;
-(void)             clearnSaveDate;

#pragma mark - 
-(void)             initEnemySpawnDict;
-(void)             loadWhichLevelDate:(NSString*)levelName;
-(NSArray*)         getEnemyArray;
-(NSArray*)         getTimeArray;

@end
