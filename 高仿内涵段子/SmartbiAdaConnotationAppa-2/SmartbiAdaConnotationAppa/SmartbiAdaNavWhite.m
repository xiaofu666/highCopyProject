//
//  adaNav.m
//  dfasg
//
//  Created by 蒋宝 on 16/4/22.
//  Copyright © 2016年 Smartbi. All rights reserved.
//

#import "SmartbiAdaNavWhite.h"
#import "UIImage+DPTransparent.h"


@interface SmartbiAdaNavWhite ()

@end

@implementation SmartbiAdaNavWhite

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *transparentImage=[UIImage transparentImage];
    [self.navigationBar setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:transparentImage];
    
    
}

#pragma mark - Croping the Image

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
