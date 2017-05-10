//
//  VideoPlayerViewController.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController

@property (nonatomic , copy ) NSString *videoTitle;//视频标题

@property (nonatomic , retain ) NSMutableArray *videoArray;//视频数组 (包含标清 高清 超清 视频详情数据)

@end
