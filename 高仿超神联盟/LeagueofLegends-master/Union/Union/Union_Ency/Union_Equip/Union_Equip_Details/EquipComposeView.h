//
//  EquipComposeView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/5.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedImageViewBlock)(NSInteger eid);

@interface EquipComposeView : UIView

@property (nonatomic , retain ) NSArray *equipIDArray;//装备ID数组

@property (nonatomic , copy ) NSString *title;//标题

@property (nonatomic , copy ) SelectedImageViewBlock selectedImageViewBlock;//选中图片视图Block 传递装备ID

@end
