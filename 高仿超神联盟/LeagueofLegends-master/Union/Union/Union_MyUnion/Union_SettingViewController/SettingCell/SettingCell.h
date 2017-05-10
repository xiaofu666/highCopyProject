//
//  SettingCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SettingCellStyle) {
    
    SettingCellStyleLabel,
    
    SettingCellStyleSwitch,
    
};

@interface SettingCell : UITableViewCell

@property (nonatomic ,copy ) NSString *titleStr;

@property (nonatomic ,copy ) NSString *detailStr;

@property (nonatomic , assign ) SettingCellStyle style;//cell样式(枚举)

@property (nonatomic , assign ) BOOL isOpen;//是否打开

@end
