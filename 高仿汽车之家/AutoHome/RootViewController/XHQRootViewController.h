//
//  XHQRootViewController.h
//  AutoHome
//
//  Created by qianfeng on 16/3/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHQAuxiliary.h"
#import "XHQNetRequest.h"
@interface XHQRootViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *dataSource;



- (void)request:(NSString *)method url:(NSString *)urlString para:(NSDictionary *)dict;




- (void)showHub:(BOOL)show;

-(void) parserData:(id)data;

- (void)pushNextWithType:(NSString *)type Subtype:(NSString *)subtype Viewcontroller:(UIViewController *)viewController;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com