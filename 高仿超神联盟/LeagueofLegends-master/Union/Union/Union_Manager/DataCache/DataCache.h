//
//  DataCache.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface DataCache : NSObject


+(DataCache *)shareDataCache;


//保存数据到Document下指定文件夹下

- (void)saveDataForDocumentWithData:(id)data DataName:(NSString *)dataName Classify:(NSString *)classifyName;

//在Document下指定文件夹下获取指定数据

- (id)getDataForDocumentWithDataName:(NSString *)dataName Classify:(NSString *)classifyName;

//获取指定分类缓存的大小

- (CGFloat)getCacheSizeWithClassify:(NSString *)classifyName;

//删除指定分类文件夹

- (void)removeClassifyCacheWithClassify:(NSString *)classifyName;

//字节转换KB或者MB或者GB

- (NSString *)getKBorMBorGBWith:(CGFloat)folderSize;


@end
