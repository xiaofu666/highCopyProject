
#import <Foundation/Foundation.h>
#import "FMDB.h"

/**
 *  数据库管理类，单例
 */
@interface SmartbiAdaDatabaseManager : NSObject

// 线程安全：代码在多线程的情况下，也没有任何问题，就称为线程安全
// 非线程安全：代码在多线程的情况下，会出现问题，就称为非线程安全

// FMDatabase非线程安全
// @property (nonatomic, strong, readonly) FMDatabase *database;

// FMDatabaseQueue是线程安全的
@property (nonatomic, strong, readonly) FMDatabaseQueue *databaseQueue;


/**
 *  单例入口
 */
+ (instancetype)shareManager;


/**
 *  让数据库建表
 */
- (void)createTables;

@end
