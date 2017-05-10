//
//  DALabeledCircularProgressView.h
//  DACircularProgressExample
//
//  Created by Josh Sklar on 4/8/14.
//  Copyright (c) 2014 Shout Messenger. All rights reserved.
//

#import "DACircularProgressView.h"

/**
 @class DALabeledCircularProgressView
 
 @brief Subclass of DACircularProgressView that adds a UILabel.
 */
@interface DALabeledCircularProgressView : DACircularProgressView

/**
 UILabel placed right on the DACircularProgressView.
 */
@property (strong, nonatomic) UILabel *progressLabel;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com