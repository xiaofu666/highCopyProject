//
//  ClearCacheSettingCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClearCacheSettingCell : UITableViewCell

@property (nonatomic ,copy ) NSString *titleStr;//标题内容字符串

@property (nonatomic ,copy ) NSString *detailStr;//详情内容字符串

@property (nonatomic , assign ) BOOL isClear;//是否清空 (YES为清空 NO为不清空)

@end
