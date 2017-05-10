//
//  
//
//  Created by kimziv on 13-9-14.
//

#include "HanyuPinyinOutputFormat.h"

@implementation HanyuPinyinOutputFormat
@synthesize vCharType=_vCharType;
@synthesize caseType=_caseType;
@synthesize toneType=_toneType;

- (id)init {
  if (self = [super init]) {
    [self restoreDefault];
  }
  return self;
}

- (void)restoreDefault {
    _vCharType = VCharTypeWithUAndColon;
    _caseType = CaseTypeLowercase;
    _toneType = ToneTypeWithToneNumber;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com