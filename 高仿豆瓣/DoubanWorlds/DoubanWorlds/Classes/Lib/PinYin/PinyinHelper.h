//
//  
//
//  Created by kimziv on 13-9-14.
//

#ifndef _PinyinHelper_H_
#define _PinyinHelper_H_

@class HanyuPinyinOutputFormat;

@interface PinyinHelper : NSObject {
}

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                         withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat;
+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                                   withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat;
+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                                  withPinyinRomanizationType:(NSString *)targetPinyinSystem;
+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch;
+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch;
+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater;
+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat;
- (id)init;
@end

#endif // _PinyinHelper_H_
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com