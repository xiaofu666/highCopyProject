//
//  DanMuModel.m
//  Day09_1_XmlParse
//
//  Created by apple-jd44 on 15/11/12.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "DanMuModel.h"

@implementation DanMuModel
+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text{
    NSArray* strArr = [parameter componentsSeparatedByString:@","];
    DanMuModel* model = [[DanMuModel alloc] init];
    model.sendTime = @([strArr[0] doubleValue]);
    model.style = @([strArr[1] intValue]);
    model.fontSize = @([strArr[2] floatValue]/1.5);
    model.textColor = @([strArr[3] doubleValue]);
    model.text = text;
    return model;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com