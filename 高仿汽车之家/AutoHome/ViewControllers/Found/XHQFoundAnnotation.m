//
//  XHQFoundAnnotation.m
//  AutoHome
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFoundAnnotation.h"

@implementation XHQFoundAnnotation

// 重写实例化方法, 重新布局界面
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    
    UIImage *image = [UIImage imageNamed:@"marker_inside_pink"];
    
    // 缩小一张图片
    NSData *data = UIImagePNGRepresentation(image);
    
    // scale: 缩放比例
    image = [UIImage imageWithData:data scale:8];
    
    // 修改标记视图的图标
    self.image = image;
    
    // 是否显示气泡
    self.canShowCallout = YES;
    
    
    // 设置气泡右侧视图
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    self.rightCalloutAccessoryView = btn;
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com