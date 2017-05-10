

#import "SmartbiAdaDatabaseManager.h"

@implementation SmartbiAdaDatabaseManager

// id 所有类型
// instancetype 当前类的类型，比id的优点就是有类型检查
+ (instancetype)shareManager
{
    static SmartbiAdaDatabaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SmartbiAdaDatabaseManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 数据库的沙盒路径
        // 如果启用了iCloud服务，会自动把沙盒下的Document文件夹里的内容上传到iCloud
        NSString *libDirPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [libDirPath stringByAppendingPathComponent:@"SmartbiAdaConnotationAppa.sqlite"];
        
        NSLog(@"数据库的沙盒路径： %@", dbPath);
        
        // 根据数据库的路径创建FMDatabaseQueue对象
        _databaseQueue = [[FMDatabaseQueue alloc] initWithPath:dbPath];
        if (_databaseQueue != nil)
        {
            NSLog(@"数据库初始化成功");
            
            [self createTables];
        }
        else
        {
            NSLog(@"数据库初始化失败");
        }
    }
    
    return self;
}

- (void)createTables
{
   
   //SmartbiAdaPerson表
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS t_person (nickname text PRIMARY KEY NOT NULL,figureurl_qq_1 text,gender text,access_token text,oauth_consumer_key text,openid text,city text,figureurl text,figureurl_1 text,figureurl_2 text,figureurl_qq_2 text,is_lost text,is_yellow_vip text,is_yellow_year_vip text,level text,msg text,province text,ret text,vip text,year text)";
    
    // FMDatabaseQueue 执行SQL的方法
    // FMDatabaseQueue 不需要手动open和close数据库
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        BOOL ret = [db executeUpdate:createSQL];
        if (ret == YES) {
            NSLog(@"t_person建表成功!");
        } else {
            NSLog(@"t_person建表失败!: %@", createSQL);
        }
    }];
    
    
    //SmartbiAdaHome表
    NSString *createHomeSQL = @"CREATE TABLE IF NOT EXISTS t_home (text text PRIMARY KEY NOT NULL,digg_count text,bury_count text,status_desc text,comment_count text,url_list text,share_count text,share_url text,category_name text,large_imageUrl_list text,avatar_url text,name text,followers text,followings text,contentSize text,pictureSize text,videoSize text,large_cover text,mp4_url text,video_height text,pictureWidth text)";
    
    // FMDatabaseQueue 执行SQL的方法
    // FMDatabaseQueue 不需要手动open和close数据库
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        BOOL ret = [db executeUpdate:createHomeSQL];
        if (ret == YES) {
            NSLog(@"t_home建表成功!");
        } else {
            NSLog(@"t_home建表失败!: %@", createSQL);
        }
    }];
    
    //SmartbiAdaHomeVideo表
    NSString *createHomeVideoSQL = @"CREATE TABLE IF NOT EXISTS t_home_video (text text PRIMARY KEY NOT NULL,digg_count text,bury_count text,status_desc text,comment_count text,url_list text,share_count text,share_url text,category_name text,large_imageUrl_list text,avatar_url text,name text,followers text,followings text,contentSize text,pictureSize text,videoSize text,large_cover text,mp4_url text,video_height text,video_width text)";
    
    // FMDatabaseQueue 执行SQL的方法
    // FMDatabaseQueue 不需要手动open和close数据库
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        BOOL ret = [db executeUpdate:createHomeVideoSQL];
        if (ret == YES) {
            NSLog(@"t_home_video建表成功!");
        } else {
            NSLog(@"t_home_video建表失败!: %@", createSQL);
        }
    }];
    
    //SmartbiAdaFind表
    NSString *createFindSQL = @"CREATE TABLE IF NOT EXISTS t_find (name text PRIMARY KEY NOT NULL,icon text,intro text,subscribe_count text,total_updates text,category_id text)";
    
    // FMDatabaseQueue 执行SQL的方法
    // FMDatabaseQueue 不需要手动open和close数据库
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        BOOL ret = [db executeUpdate:createFindSQL];
        if (ret == YES) {
            NSLog(@"t_find建表成功!");
        } else {
            NSLog(@"t_find建表失败!: %@", createSQL);
        }
    }];


}

@end
