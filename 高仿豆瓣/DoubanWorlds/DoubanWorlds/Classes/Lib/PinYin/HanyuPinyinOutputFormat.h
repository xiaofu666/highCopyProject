/**
 *	Created by kimziv on 13-9-14.
 */
#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_

typedef enum {
  ToneTypeWithToneNumber,
  ToneTypeWithoutTone,
  ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;


@interface HanyuPinyinOutputFormat : NSObject

@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;

- (id)init;
- (void)restoreDefault;
@end

#endif // _HanyuPinyinOutputFormat_H_
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com