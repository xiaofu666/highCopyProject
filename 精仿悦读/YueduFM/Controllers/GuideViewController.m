//
//  GuideViewController.m
//  YueduFM
//
//  Created by StarNet on 10/13/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import "GuideViewController.h"
#import "EAIntroView.h"

@interface GuideViewController () <EAIntroDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSString* )adapterImageName:(NSString* )name {
    name = name.stringByDeletingPathExtension;
    CGSize size = [[UIScreen mainScreen] bounds].size;
    if (size.width >= 414) {
        return [NSString stringWithFormat:@"%@~5.5@2x", name];
    } else if (size.width >= 375) {
        return [NSString stringWithFormat:@"%@~4.7@2x", name];
    } else if (size.height > 480) {
        return [NSString stringWithFormat:@"%@~4@2x", name];
    } else {
        return [NSString stringWithFormat:@"%@~3.5@2x", name];
    }
}

- (void)show {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"点击播放";
    page1.desc = @"点击图片区域，可以播放相应的文章.";
    page1.bgColor = kThemeColor;
    NSString* path1 = [[NSBundle mainBundle] pathForResource:[self adapterImageName:@"guide1"] ofType:@"png"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path1]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"选时播放";
    page2.desc = @"播放栏上方会显示当前播放进度\n在播放栏上左右滑动，可进行选时播放.";
    page2.bgColor = kThemeColor;
    NSString* path2 = [[NSBundle mainBundle] pathForResource:[self adapterImageName:@"guide2"] ofType:@"png"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path2]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"下载";
    page3.desc = @"点击图片区域，可以暂停/恢复下载.";
    page3.bgColor = kThemeColor;
    NSString* path3 = [[NSBundle mainBundle] pathForResource:[self adapterImageName:@"guide3"] ofType:@"png"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path3]];

    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1, page2, page3]];
    
    intro.skipButton.alpha = 0.f;
    intro.delegate = self;
    [intro showInView:self.view animateDuration:0.3];
}

- (void)introDidFinish:(EAIntroView *)introView {
    if (self.guideDidFinished) {
        self.guideDidFinished();
    }
}
@end
