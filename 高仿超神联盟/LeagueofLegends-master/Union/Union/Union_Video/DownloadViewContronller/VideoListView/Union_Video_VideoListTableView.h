//
//  Union_Video_NewCollectionView.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-19.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedVideoBlock)(NSMutableArray *videoArray , NSString *videoTitle);

@interface Union_Video_VideoListTableView : UITableView


@property (nonatomic , copy ) NSString *urlStr;//URL字符串

@property (nonatomic , copy ) SelectedVideoBlock selectedVideoBlock;//选中视频cellBlock

@property (nonatomic , retain ) UIViewController *rootVC;//父视图控制器

@property (nonatomic , assign ) BOOL isShowLoadingView;//是否显示加载视图

//请求视频详情数据

- (void)netWorkingGetVideoDetailsWithVID:(NSString *)vid Title:(NSString *)title;

@end
