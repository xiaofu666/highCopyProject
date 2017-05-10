//
//  SingImageTouch.h
//  Doodle
//
//  Created by ran on 12-9-5.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TouchViewDelegate <NSObject>

- (void)TouchTheImageView:(NSDictionary *)dicInfo;

@end



@interface SingImageTouch : UIImageView
{
    NSString    *imagepath;
    UIImage    *subImage;
    UIImageView *subImageView;
    id<TouchViewDelegate>   delegate;
}

@property(nonatomic,copy)NSString  *imagePath;
@property(nonatomic,retain)UIImage  *subImage;
@property(nonatomic,retain)UIImageView  *subImageView;
@property(nonatomic,assign)id<TouchViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame  imagePath:(NSString *)path  image:(UIImage *)image;
@end
