//
//  UserInfoManager.h
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+ (UserInfoManager *)manager;

/**
 *  昵称
 */
- (NSString *)userName;

/**
 *  微信号
 */
- (NSString *)wxID;

/**
 *  用户头像url
 */
- (NSString *)avaterUrl;

/**
 *  性别 默认为男
 */
- (BOOL)sex;

/**
 *  个性签名
 */
- (NSString *)sign;

/**
 *  真正用于登录的id
 */
- (NSString *)mid;

/**
 *  密码
 */
- (NSString *)password;

/**
 *  是否已登录
 */
@property(nonatomic,assign)BOOL isLogin;

/**
 *  是否打开了会话环境
 */
@property(nonatomic,assign)BOOL isOpenIm;

/**
 *  缓存的头像
 */
- (UIImage *)avater;
/**
 *  保存img
 */
- (void)saveImgDataWithImg:(UIImage *)img;
@end
