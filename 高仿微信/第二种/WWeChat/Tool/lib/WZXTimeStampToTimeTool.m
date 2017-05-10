//
//  WZXTimeStampToTimeTool.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXTimeStampToTimeTool.h"
@interface WZXTimeStampToTimeTool()

@property(nonatomic,copy)NSDateFormatter * formatter;

@end
@implementation WZXTimeStampToTimeTool

+ (WZXTimeStampToTimeTool *)tool
{
    static WZXTimeStampToTimeTool * tool = nil;
    if (tool == nil)
    {
        tool = [[WZXTimeStampToTimeTool alloc]init];
    }
    return tool;
}

- (NSDictionary *)timeStampToTimeToolWithTimeStamp:(NSTimeInterval)timeStamp andScale:(NSInteger)scale
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp/pow(10, scale)];
    
//    NSDate *datenow = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//    NSDate   *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return [self strToDicWithStr:[self.formatter stringFromDate:confromTimesp]];
}

- (NSDictionary *)locationTime
{
    NSDate *datenow = [NSDate date];
    
    return [self strToDicWithStr:[self.formatter stringFromDate:datenow]];
}

- (NSDictionary *)strToDicWithStr:(NSString *)str
{
    NSMutableDictionary * muDic = [[NSMutableDictionary alloc]init];
    
    NSArray * arr = [str componentsSeparatedByString:@"-"];
    
    [muDic setObject:arr[0] forKey:@"year"];
    
    [muDic setObject:arr[1] forKey:@"month"];
    
    [muDic setObject:arr[2] forKey:@"day"];
    
    [muDic setObject:arr[3] forKey:@"hour"];
    
    [muDic setObject:arr[4] forKey:@"minute"];
    
    [muDic setObject:arr[5] forKey:@"second"];
    
    return [muDic copy];
}

- (NSDateFormatter *)formatter
{
    if (!_formatter)
    {
        _formatter = [[NSDateFormatter alloc]init];
        
        [_formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    }
    return _formatter;
}

- (NSString *)compareWithTimeDic:(NSDictionary *)timeDic
{
    
   NSDictionary * nowDic = [self locationTime];
    NSString * timeStr = @"";
    
    if([timeDic[@"year"]integerValue] < [nowDic[@"year"] integerValue])
    {
        timeStr = [NSString stringWithFormat:@"%ld年前",[nowDic[@"year"] integerValue] - [timeDic[@"year"]integerValue]];
    }
    else if([timeDic[@"year"]integerValue] == [nowDic[@"year"] integerValue])
    {
        if ([timeDic[@"month"]integerValue] < [nowDic[@"month"]integerValue])
        {
            timeStr = [NSString stringWithFormat:@"%ld个月前",[nowDic[@"month"] integerValue] - [timeDic[@"month"]integerValue]];
        }
        else if([timeDic[@"month"]integerValue] == [nowDic[@"month"]integerValue])
        {
            if([timeDic[@"day"]integerValue] < [nowDic[@"day"]integerValue])
            {
                timeStr = [NSString stringWithFormat:@"%ld天前",[nowDic[@"day"] integerValue] - [timeDic[@"day"]integerValue]];
                if ([timeStr isEqualToString:@"一天前"])
                {
                    timeStr = @"昨天";
                }
                if ([timeStr isEqualToString:@"两天前"])
                {
                    timeStr = @"前天";
                }
            }
            else if([timeDic[@"day"]integerValue] == [nowDic[@"day"]integerValue])
            {
               if([timeDic[@"hour"]integerValue] == [nowDic[@"hour"]integerValue]&&
                  [timeDic[@"minute"]integerValue] == [nowDic[@"minute"]integerValue]
                  &&
                  [timeDic[@"second"]integerValue] == [nowDic[@"second"]integerValue])
               {
                   //显示time
                   timeStr = [NSString stringWithFormat:@"%@:%@",timeDic[@"hour"],timeDic[@"minute"]];
               }
                else
                {
                    //显示time
                    timeStr = [NSString stringWithFormat:@"%@:%@",timeDic[@"hour"],timeDic[@"minute"]];
                }
            }
        }

    }
    return timeStr;
}

@end
