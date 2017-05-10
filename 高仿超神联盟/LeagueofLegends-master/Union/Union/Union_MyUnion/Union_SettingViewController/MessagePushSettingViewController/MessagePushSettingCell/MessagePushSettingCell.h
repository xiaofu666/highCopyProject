//
//  MessagePushSettingCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/22.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MessagePushSettingCellStyle) {
    
    MessagePushSettingCellStyleStateLabel,
    
    MessagePushSettingCellStyleStateSwitch,
    
};

@interface MessagePushSettingCell : UITableViewCell

@property (nonatomic ,copy ) NSString *titleStr;//标题字符串

@property (nonatomic , copy ) NSString *stateStr;//状态字符串

@property (nonatomic , assign ) MessagePushSettingCellStyle style;//cell样式(枚举)

@property (nonatomic , assign ) BOOL isOpen;//是否打开开关

@end
