//
//  UserRegisterSuccessView.h
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

@protocol UserRegisterSuccessViewDelegate <NSObject>

- (void)doClickShoppingBtn;

@end


@interface UserRegisterSuccessView : UIView

@property (nonatomic, weak) id<UserRegisterSuccessViewDelegate> delegate;

- (void)fillContentWithLoginName:(NSString *)loginName password:(NSString *)password;

@end
