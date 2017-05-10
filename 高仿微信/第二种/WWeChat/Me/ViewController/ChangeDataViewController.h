//
//  ChangeDataViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/2/15.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeDataViewController : BaseViewController

typedef NS_ENUM(NSInteger,ChangeType)
{
    ChangeAvater,
    ChangeNickName,
    ChangeAddress,
    ChangeSex,
    ChangePath,
    ChangeSign
};

@property(nonatomic,strong)UIImageView * avaterView;

@property(nonatomic,weak)void(^avaterBlock)(UIImage * img);

- (instancetype)initWithType:(ChangeType)type;

@end
