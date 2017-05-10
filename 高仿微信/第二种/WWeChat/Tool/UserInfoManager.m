//
//  UserInfoManager.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+ (UserInfoManager *)manager
{
    static UserInfoManager * manager = nil;
    if (manager == nil)
    {
        manager = [[UserInfoManager alloc]init];
    }
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _isLogin = NO;
        _isOpenIm = NO;
    }
    return self;
}

- (NSString *)userName
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"nickName"];
}

- (NSString *)wxID
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"wxID"];
}

- (NSString *)avaterUrl
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"avaterUrl"];
}

- (BOOL)sex
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return [dic[@"sex"]boolValue];
}

- (NSString *)sign
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"sign"];
}

- (NSString *)mid
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"mid"];
}

- (NSString *)password
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"password"];
}

- (UIImage *)avater
{
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"avater"];
    
    return [UIImage imageWithData:data];
}

- (void)saveImgDataWithImg:(UIImage *)img
{
    NSData *imageData = UIImageJPEGRepresentation(img, 1);
    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"avater"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
