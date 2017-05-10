//
//  VideoDetailsModel.h
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailsModel : NSObject

@property (nonatomic , copy )NSString *vid;//视频ID

@property (nonatomic , copy )NSString *definition;//视频清晰度 350  1000  1300

@property (nonatomic , copy )NSString *transcode_id;//视频转码ID

@property (nonatomic , copy )NSString *video_name;//视频名

@property (nonatomic , copy )NSString *size;//视频大小

@property (nonatomic , copy )NSString *width;//视频宽

@property (nonatomic , copy )NSString *height;//视频高

@property (nonatomic , copy )NSString *duration;//视频时长

@property (nonatomic , copy )NSArray *urls;//视频URL

@property (nonatomic , copy )NSString *cover;//封面图URL



@end
