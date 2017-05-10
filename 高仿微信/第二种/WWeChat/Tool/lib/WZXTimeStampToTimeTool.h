//
//  WZXTimeStampToTimeTool.h
//  WWeChat
//
//  Created by wordoor－z on 16/2/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXTimeStampToTimeTool : NSObject

+ (WZXTimeStampToTimeTool *)tool;

/**
 *  @method
 *  @abstract 用于时间戳转化成时间
 *  @discussion <#如何使用#>
 *  @param timeStamp 时间戳
 *  @param scale 和秒之间的倍数关系，如:毫秒则传入3
 *  @param <#参数#>
 *  @result 返回字典 year month day hour minute second
 */
- (NSDictionary *)timeStampToTimeToolWithTimeStamp:(NSTimeInterval)timeStamp andScale:(NSInteger)scale;

- (NSDictionary *)locationTime;

- (NSString *)compareWithTimeDic:(NSDictionary *)timeDic;
@end
