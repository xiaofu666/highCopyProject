//
//  SortCollectionReusableView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VideoSearchBlock)(NSString *videoName);

@interface SortCollectionReusableView : UICollectionReusableView<UITextFieldDelegate>

@property (nonatomic ,retain) UILabel *myHeader;

@property (nonatomic ,retain) UITextField *textField;

@property (nonatomic ,retain) UIButton *button;

@property (nonatomic ,copy) VideoSearchBlock videoSearchBlock;//视频搜索block


@end
