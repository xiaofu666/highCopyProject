//
//  Hero_Details_Details_BaseCell.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/11.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCH.h"

#import "UIView+Shadow.h"

#import "NSString+GetWidthHeight.h"

typedef void (^ChangeCellHeight)(NSIndexPath *indexpath , CGFloat height);

@interface Hero_Details_Details_BaseCell : UITableViewCell

@property (nonatomic , retain ) UIView *rootView;//背景视图

@property (nonatomic , retain ) UIView *titleView;//标题前视图

@property (nonatomic , retain ) UILabel *titleLabel;//标题

@property (nonatomic , copy ) NSString *title;//标题

@property (nonatomic , retain ) NSIndexPath *indexpath;//cell的位置

@property (nonatomic , copy ) ChangeCellHeight changeCellHeight;

@end
