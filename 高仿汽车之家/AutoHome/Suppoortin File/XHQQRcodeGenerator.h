//
//  QFQRcodeGenerator.h
//  Demo-CustomQRCore
//
//  Created by csl on 16/3/25.
//  Copyright © 2016年 yourtion. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XHQQRcodeGenerator : NSObject
/*
 @abstract：根据传入的字符串生成二维码
 @para:  text 要生成二维码的文字；
         size 指定分辨率
 @return: 返回二维码的图片
*/
+(UIImage*) generateQRCode:(NSString*)text size:(CGFloat)size;

//给二维码染色，背景透明
+(UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
@end
