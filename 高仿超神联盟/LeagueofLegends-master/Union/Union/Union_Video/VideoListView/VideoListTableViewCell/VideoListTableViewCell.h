//
//  NewTableViewCell.h
//  Union
//
//  Created by lanou3g on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoListModel.h"

@interface VideoListTableViewCell : UITableViewCell

@property (nonatomic ,retain) UIImageView *cover_url;//图片

@property (nonatomic ,retain) UILabel *titleLable;//标题

@property (nonatomic ,retain) UILabel *video_length;//时长

@property (nonatomic ,retain) UILabel *upload_time;//更新时间

@property (nonatomic ,retain) UIButton *download;//下载按钮

@property (nonatomic ,retain) VideoListModel *Model;//数据模型

@end
