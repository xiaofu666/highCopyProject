//
//  Union_News_PrettyPictures_View.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/21.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCH.h"

typedef void (^PrettyPicturesBlock)(NSString *string);

@interface Union_News_PrettyPictures_View : UIView

@property (nonatomic, copy) PrettyPicturesBlock prettyPicturesBlock;

@property (nonatomic, copy) NSString *urlString;

@end
