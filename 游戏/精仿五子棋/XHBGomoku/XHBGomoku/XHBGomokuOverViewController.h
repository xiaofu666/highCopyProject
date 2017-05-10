//
//  XHBGomokuOverViewController.h
//  XHBGomoku
//
//  Created by weqia on 14-9-4.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHBGomokuOverViewController : UIViewController
@property(nonatomic)BOOL success;
@property(nonatomic)NSInteger stepCount;
@property(nonatomic,strong)UIImage * backImage;
@property(nonatomic,copy)void(^callback)();
@end
