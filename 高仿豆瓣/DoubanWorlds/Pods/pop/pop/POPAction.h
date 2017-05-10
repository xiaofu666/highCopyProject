/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#ifndef POPACTION_H
#define POPACTION_H

#import <QuartzCore/CATransaction.h>
#import <pop/POPDefines.h>

#ifdef __cplusplus

namespace POP {
  
  /**
   @abstract Disables Core Animation actions using RAII.
   @discussion The disablement of actions is scoped to the current transaction.
   */
  class ActionDisabler
  {
    BOOL state;
    
  public:
    ActionDisabler() POP_NOTHROW
    {
      state = [CATransaction disableActions];
      [CATransaction setDisableActions:YES];
    }
    
    ~ActionDisabler()
    {
      [CATransaction setDisableActions:state];
    }
  };
  
  /**
   @abstract Enables Core Animation actions using RAII.
   @discussion The enablement of actions is scoped to the current transaction.
   */
  class ActionEnabler
  {
    BOOL state;
    
  public:
    ActionEnabler() POP_NOTHROW
    {
      state = [CATransaction disableActions];
      [CATransaction setDisableActions:NO];
    }
    
    ~ActionEnabler()
    {
      [CATransaction setDisableActions:state];
    }
  };

}

#endif /* __cplusplus */

#endif /* POPACTION_H */
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com