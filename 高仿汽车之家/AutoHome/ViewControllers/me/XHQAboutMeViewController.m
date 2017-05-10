//
//  XHQAboutMeViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQAboutMeViewController.h"


#import "XHQQRcodeGenerator.h"

#import "Masonry.h"


@interface XHQAboutMeViewController ()


@end

@implementation XHQAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    [self creatUIImageView];
        // Do any additional setup after loading the view.
}
- (void)creatUIImageView
{
    CGRect frame = CGRectMake(100, 150, 200, 200);
    UIImageView *qrcodeView = [XHQFactoryUI createImageViewWithFrame:frame imageName:nil];
    UIImage *qrcode = [XHQQRcodeGenerator generateQRCode:@"http://www.sohu.com" size:250];
    UIImage *customQrcode = [XHQQRcodeGenerator imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.f andBlue:89.f];
    
    qrcodeView.image = customQrcode;
    qrcodeView.layer.shadowOffset = CGSizeMake(0, 2);
    qrcodeView.layer.shadowRadius = 2;
    qrcodeView.layer.shadowColor = [UIColor blackColor].CGColor;
    qrcodeView.layer.shadowOpacity = 0.5;
    
    
//      [qrcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).width.offset(100);
//        make.left.equalTo(self.view.mas_left).with.offset(100);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
//        make.right.equalTo(self.view.mas_right).with.offset(-100);
//    }];
    
    [self.view addSubview:qrcodeView  ];
    

}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com