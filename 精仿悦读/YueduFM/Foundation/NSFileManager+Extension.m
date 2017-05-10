//
//  NSFileManager+Extension.m
//  YueduFM
//
//  Created by StarNet on 10/12/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "NSFileManager+Extension.h"

@implementation NSFileManager (Extension)

- (long long)singleFileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (long long)fileSizeAtPath:(NSString*)path{
    NSFileManager* manager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if (![manager fileExistsAtPath:path isDirectory:&isDirectory]) return 0;
    
    if (!isDirectory) {
        return [self singleFileSizeAtPath:path];
    } else {
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
        NSString* fileName;
        long long folderSize = 0;
        
        while ((fileName = [childFilesEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self singleFileSizeAtPath:fileAbsolutePath];
        }
        return folderSize;
    }
}

@end
