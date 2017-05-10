//
//  UserLoginView.h
//  ygcr
//
//  Created by 黄治华(Tony Wong) on 15/06/21.
//  Copyright © 2015年 黄治华. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>

@protocol UserLoginViewDelegate <NSObject>

- (void)doClickLoginBtnWithMobile:(NSString *)mobile password:(NSString *)password;

- (void)doClickForgetBtn;

- (void)doClickRegisterBtn;

@end


@interface UserLoginView : UIView

@property (nonatomic, weak) id<UserLoginViewDelegate> delegate;

@end
