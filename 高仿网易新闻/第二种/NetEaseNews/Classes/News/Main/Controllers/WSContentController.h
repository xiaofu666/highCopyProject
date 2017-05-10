//
//  WSContentController.h
//  网易新闻
//
//  Created by WackoSix on 15/12/30.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContentController : UIViewController

/**新闻内容标识*/
@property (copy, nonatomic) NSString *docid;

+ (instancetype)contentControllerWithID:(NSString *)docID;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com