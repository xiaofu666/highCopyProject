//
//  DataCache.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DataCache.h"



@implementation DataCache



+(DataCache *)shareDataCache{
    
    static DataCache *dataCache = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dataCache = [[DataCache alloc]init];
        
    });
    
    return dataCache;
    
}

#pragma mark ---获取document路径

- (NSString *)documentPath{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return array.firstObject;
    
}

#pragma mark ---获取document下创建文件夹下的分类文件夹路径

- (NSString *)getDocumentFileManagerPathWithClassify:(NSString *)classifyName{
    
    // classifyName 文类名称
    
    //缓存目录结构: document/datacache/分类名文件夹/文件名文件夹/文件名.json
    
    NSString *documentPath = [self documentPath];
    
    //创建一个文件夹对象
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [[NSString stringWithFormat:@"%@/datacache",documentPath] stringByAppendingPathComponent:classifyName];
    
    //判断该文件夹是否存在
    
    if([fileManager fileExistsAtPath:filePath])
    {
        
        return filePath;
        
    } else {
        
        return nil;
        
    }

}


#pragma mark ---document下创建文件夹并获取文件夹路径

- (NSString *)documentFileManagerPathWithFileName:(NSString *)fileName Classify:(NSString *)classifyName{
    
    //fileName 文件名称  classifyName 文类名称
    
    //缓存目录结构: document/datacache/分类名文件夹/文件名文件夹/文件名.json
    
    NSString *documentPath = [self documentPath];
    
    //创建一个文件夹对象
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [[[NSString stringWithFormat:@"%@/datacache",documentPath] stringByAppendingPathComponent:classifyName] stringByAppendingPathComponent:fileName];
    
    //判断该文件夹是否存在
    
    if(![fileManager fileExistsAtPath:filePath])
    {
        
        //不存在创建文件夹 在document/datacache文件下
        
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    return filePath;

}

#pragma mark ---保存数据到Document下指定分类文件夹下

- (void)saveDataForDocumentWithData:(id)data DataName:(NSString *)dataName Classify:(NSString *)classifyName{
    
    //非空判断
    
    if (data != nil) {
        
        __block typeof(self) Self = self;
        
        dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(myQueue, ^{
           
            //将JSON数据转换成Data 存储指定分类文件夹下的指定文件夹
            
            NSData *tempData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
            
            [tempData writeToFile:[[Self documentFileManagerPathWithFileName:dataName Classify:classifyName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json" , dataName ]] atomically:YES];
            
        });

    }

}


#pragma mark ---在Document下指定分类文件夹下获取指定数据

- (id)getDataForDocumentWithDataName:(NSString *)dataName Classify:(NSString *)classifyName{
   
    NSData *tempData = [NSData dataWithContentsOfFile:[[self documentFileManagerPathWithFileName:dataName Classify:classifyName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json" , dataName ]]];
    
    //非空判断
    
    if (tempData != nil) {
        
        //从本地获取数据 并转化成JSON格式
        
        return [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:nil];
        
    } else {
        
        return nil;
        
    }
    
}


#pragma mark ---单个文件的大小

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    
    }
    
    return 0;

}

#pragma mark ---获取指定缓存路径的缓存大小

-(CGFloat)getCacheSizeWithCacheFilePath:(NSString *)cacheFilePath{
    
    long long folderSize = 0;
    
    //获取该分类目录下所有文件的路径 并循环遍历获取大小
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cacheFilePath] objectEnumerator];
    
    NSString* fileName;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [cacheFilePath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize;
    
}

#pragma mark ---获取指定分类缓存大小

- (CGFloat)getCacheSizeWithClassify:(NSString *)classifyName{
    
    //获取分类路径
    
    NSString *classifyPath = [self getDocumentFileManagerPathWithClassify:classifyName];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    //判断该分类路径是否存在
    
    if (![manager fileExistsAtPath:classifyPath]){
        
        return 0;
    }
    
    //获取该分类目录下所有文件的路径 并循环遍历获取大小
    
    long long folderSize = [self getCacheSizeWithCacheFilePath:classifyPath];

    return folderSize;
    
}

#pragma mark ---字节转换KB或者MB或者GB

- (NSString *)getKBorMBorGBWith:(CGFloat)folderSize{
    
    //判断KB MB GB 单位 返回相应的字符串
    
    if (folderSize == 0) {
        
        return [NSString stringWithFormat:@"0.00KB"];
        
    } else if (folderSize/(1024.0) < 1024.0) {
        
        return [NSString stringWithFormat:@"%.2fKB",folderSize/(1024.0)];
        
    } else if (folderSize/(1024.0) >= 1024.0 && folderSize/(1024.0 * 1024.0) < 1024.0) {
        
        return [NSString stringWithFormat:@"%.2fMB",folderSize/(1024.0 * 1024.0)];
        
    } else {
        
        return [NSString stringWithFormat:@"%.2fGB",folderSize/(1024.0 * 1024.0 * 1024.0)];
        
    }
    
}


#pragma mark ---删除指定分类文件夹

- (void)removeClassifyCacheWithClassify:(NSString *)classifyName{
    
    //获取分类路径
    
    NSString *classifyPath = [self getDocumentFileManagerPathWithClassify:classifyName];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    //判断该分类路径是否存在
    
    if ([manager fileExistsAtPath:classifyPath]){
        
        NSError *error = nil;
        
        [manager removeItemAtPath:classifyPath error:&error];
        
    }
    
}







@end
