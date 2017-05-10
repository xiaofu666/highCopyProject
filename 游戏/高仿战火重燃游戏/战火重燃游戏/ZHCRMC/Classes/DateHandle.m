//
//  DateHandle.m
//  ZHCRC
//
//  Created by jiangyu on 13-1-8.
//
//

#import "DateHandle.h"

@implementation DateHandle

static DateHandle * sharedDateHandle;

+(id) SharedDateHandle{
    if (!sharedDateHandle) {
        sharedDateHandle = [[self alloc]init];
    }
    return sharedDateHandle;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        if (!documentsDirectory) {
            NSLog(@"没找到");
        }
        dateDictionary = nil;
        scoreArray = nil;
        flyArray = nil;
        file = [[documentsDirectory stringByAppendingPathComponent:DateplistName] retain];//DateplistName 保存数据的 .plist名字
        if([[NSFileManager defaultManager] fileExistsAtPath:file]){
            dateDictionary = [NSDictionary dictionaryWithContentsOfFile:file];
        } else{
            dateDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:DateName ofType:@"plist"]];//DateName 无.plist 的保存数据文件名
        }
    
        [self LoadDate];
        enemySpawnDictionary = nil;
        [self initEnemySpawnDict];
//        NSLog(@"%@",file);
    }
    return self;
}

-(NSArray *)getScoreArray{
    return scoreArray;
}
-(NSArray *)getFlyArray{
    return flyArray;
}

-(void) LoadDate{
    scoreArray = nil;
    flyArray = nil;
    dateDictionary = [NSDictionary dictionaryWithContentsOfFile:file];
    scoreArray = [dateDictionary objectForKey:SCOREA];
    flyArray = [dateDictionary objectForKey:TimeA];
}

-(BOOL)SaveDateWithScoreArray:(NSArray *)scoreA AndTimeArray:(NSArray *)timeA{
    
    NSDictionary * dictDate = [NSDictionary dictionaryWithObjectsAndKeys:scoreA,SCOREA,timeA,TimeA, nil];
    return ([dictDate writeToFile:file atomically:YES]);
}

-(NSString * )getTime{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * time = [dateformat stringFromDate:newDate];
    return time;
}

static inline NSInteger Compare(id num1, id num2, void *context)
{
    int value1 = [num1 intValue];
    int value2 = [num2 intValue];
    
    if (value1 < value2)
        return NSOrderedAscending;
    else  if (value1 > value2)
        return NSOrderedDescending;
    else return NSOrderedSame;
}

-(BOOL)insertDateWithScore:(NSNumber *)score FlyName:(NSString*)flyName{
    [self LoadDate];
    NSMutableArray * scoreA = [NSMutableArray arrayWithArray:[self getScoreArray]];
    NSMutableArray * flyA = [NSMutableArray arrayWithArray:[self getFlyArray]];
    
    [scoreA addObject:score];
    [scoreA sortUsingFunction:Compare context:nil]; //排序  降序排列的
    
    NSInteger index = [scoreA indexOfObject:score]; // 在相同位置的fly数组里面插入FlyName
    [flyA insertObject:flyName atIndex:index];
    
    if (scoreA.count>10) { //如果保存数据过10个 删除最前面的 因为是降序排列的
        [scoreA removeObjectAtIndex:0];
        [flyA removeObjectAtIndex:0];
    }
    
    return [self SaveDateWithScoreArray:scoreA AndTimeArray:flyA];
}

#pragma mark -  savePassDate

-(void)SaveCurrentLevelPassedDateWithStruct:(PlayerSaveDate)date{
    
    NSUserDefaults * defaultsDate = [NSUserDefaults standardUserDefaults];
    
    [defaultsDate setInteger:date.level forKey:@"level"];
    [defaultsDate setInteger:date.flyType forKey:@"flyType"];
    [defaultsDate setInteger:date.life forKey:@"life"];
    [defaultsDate setInteger:date.point forKey:@"point"];
    [defaultsDate setInteger:date.enemyDamaged forKey:@"enemyDamaged"];
    [defaultsDate setInteger:date.nukeCount forKey:@"nukeCount"];
    [defaultsDate setInteger:date.addweaponLevel forKey:@"addweaponLevel"];
    [defaultsDate setInteger:date.weaponType forKey:@"weaponType"];
    [defaultsDate setInteger:date.weaponLevel forKey:@"weaponLevel"];
    
    [defaultsDate setBool:YES forKey:@"HasSave"];
    [defaultsDate synchronize];
}

-(PlayerSaveDate)ReadSaveDate{
    NSUserDefaults * defaultsDate = [NSUserDefaults standardUserDefaults];
    PlayerSaveDate date;
    date.level          = [defaultsDate integerForKey:@"level"];
    date.flyType        = [defaultsDate integerForKey:@"flyType"];
    date.life           = [defaultsDate integerForKey:@"life"];
    date.point          = [defaultsDate integerForKey:@"point"];
    date.enemyDamaged   = [defaultsDate integerForKey:@"enemyDamaged"];
    date.nukeCount      = [defaultsDate integerForKey:@"nukeCount"];
    date.addweaponLevel = [defaultsDate integerForKey:@"addweaponLevel"];
    date.weaponType     = [defaultsDate integerForKey:@"weaponType"];
    date.weaponLevel    = [defaultsDate integerForKey:@"weaponLevel"];
    
    return date;
}

-(void) clearnSaveDate{
     NSUserDefaults * defaultsDate = [NSUserDefaults standardUserDefaults];
    [defaultsDate setBool:NO forKey:@"HasSave"];
    [defaultsDate synchronize];
}

#pragma mark - initEnemySpawnArray

-(void)initEnemySpawnDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        NSLog(@"没找到");
    }
    enemyFile = [[documentsDirectory stringByAppendingPathComponent:@"LevelEnemyLoad.plist"] retain];//LevelEnemyLoad.plist 保存数据的 .plist名字
//    if([[NSFileManager defaultManager] fileExistsAtPath:enemyFile]){
//        enemySpawnDictionary = [NSDictionary dictionaryWithContentsOfFile:enemyFile];
//    } else{
//        enemySpawnDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LevelEnemyLoad" ofType:@"plist"]];//DateName 无.plist 的保存数据文件名
//    } 
//    
    timeControllArray = nil;
    enemySpawnArray = nil;
}
-(void)loadWhichLevelDate:(NSString *)levelName{
    
    if([[NSFileManager defaultManager] fileExistsAtPath:enemyFile]){
        enemySpawnDictionary = [NSDictionary dictionaryWithContentsOfFile:enemyFile];
    } else{
        enemySpawnDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LevelEnemyLoad" ofType:@"plist"]];//DateName 无.plist 的保存数据文件名
    }
    
    NSDictionary * dict = [enemySpawnDictionary objectForKey:levelName];
    
    NSArray * arrayT = [dict objectForKey:@"TimeArray"];
    NSArray * arrayE = [dict objectForKey:@"EnemyProperty"];
    
    if(timeControllArray){
        [timeControllArray release];
        timeControllArray = nil;
    }
    if (enemySpawnArray) {
        [enemySpawnArray release];
        enemySpawnArray = nil;
    }
    timeControllArray = [[NSArray arrayWithArray:arrayT] retain];
    enemySpawnArray = [[NSArray arrayWithArray:arrayE] retain];
}

-(NSArray *)getTimeArray{
    return timeControllArray;
}
-(NSArray *)getEnemyArray{
    return enemySpawnArray;
}



- (void)dealloc
{
    if (file) {
        [file release];
        file = nil;
    }
    
    if (enemyFile) {
        [enemyFile release];
        enemyFile = nil;
    }
    if (timeControllArray) {
        [timeControllArray release]; timeControllArray = nil;
    }
    if (enemySpawnArray) {
        [enemySpawnArray release]; enemySpawnArray = nil;
    }
    sharedDateHandle = nil;
    [super dealloc];
}



@end
