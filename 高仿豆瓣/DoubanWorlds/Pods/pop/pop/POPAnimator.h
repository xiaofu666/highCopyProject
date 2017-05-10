/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/NSObject.h>

@protocol POPAnimatorDelegate;

/**
 @abstract The animator class renders animations.
 */
@interface POPAnimator : NSObject

/**
 @abstract The shared animator instance.
 @discussion Consumers should generally use the shared instance in lieu of creating new instances.
 */
+ (instancetype)sharedAnimator;

/**
 @abstract The optional animator delegate.
 */
@property (weak, nonatomic) id<POPAnimatorDelegate> delegate;

@end

/**
 @abstract The animator delegate.
 */
@protocol POPAnimatorDelegate <NSObject>

/**
 @abstract Called on each frame before animation application.
 */
- (void)animatorWillAnimate:(POPAnimator *)animator;

/**
 @abstract Called on each frame after animation application.
 */
- (void)animatorDidAnimate:(POPAnimator *)animator;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com