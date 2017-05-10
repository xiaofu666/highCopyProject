//
//  WSRollCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSRollCell.h"
#import "UIImageView+WebCache.h"
#import "WSAds.h"
#import "WSImageView.h"

@interface WSRollCell ()

@property (weak, nonatomic) IBOutlet WSImageView *imageView;

@end

@implementation WSRollCell


- (void)setAd:(WSAds *)ad{
    
    _ad = ad;
    
    self.imageView.contentMode = UIViewContentModeCenter;
   [self.imageView sd_setImageWithURL:[NSURL URLWithString:ad.imgsrc] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];

}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com