//
//  MovieDetailHeadView.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/7.
//  Copyright © 2016年 LYoung. All rights reserved.
//  电影详情页头部视图

#import <UIKit/UIKit.h>
@class MovieModel,DetailMovieModel;

@interface MovieDetailHeadView : UIView

@property (nonatomic ,strong) MovieModel *model;

@property (nonatomic ,strong) DetailMovieModel *infoModel;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com