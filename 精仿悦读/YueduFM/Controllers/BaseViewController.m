//
//  BaseViewController.m
//  YueduFM
//
//  Created by StarNet on 9/19/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, assign) BOOL dragging;
@property (nonatomic, assign) CGFloat scrollY;
@property (nonatomic, strong) UILabel* emptyView;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupEmptyView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SRV(StreamerService).isPlaying = SRV(StreamerService).isPlaying;
}

- (void)setupEmptyView {
    UIView* container = [self emptyContainer];
    self.emptyView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, container.width, 20)];
    self.emptyView.center = CGPointMake(container.width/2, (container.height-120)/2);
    self.emptyView.textColor = [UIColor lightGrayColor];
    self.emptyView.textAlignment = NSTextAlignmentCenter;
    self.emptyView.text = self.emptyString;
    self.emptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    self.emptyView.font = [UIFont systemFontOfSize:15];
    self.isEmpty = NO;
    [container addSubview:self.emptyView];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    UILabel* label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void)setEmptyString:(NSString *)emptyString {
    _emptyString = emptyString;
    self.emptyView.text = emptyString;
}

- (void)setIsEmpty:(BOOL)isEmpty {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.emptyView.hidden = !isEmpty;        
    });
}

- (UIView* )emptyContainer {
    return self.view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragging = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.dragging = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    self.dragging = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat diffY = self.scrollY - scrollView.contentOffset.y;
    self.scrollY = scrollView.contentOffset.y;
    
    if (!self.dragging || (scrollView.contentOffset.y < -70)) return;
    
    if (diffY > 0) { //上滑
        [PlayerBar show];
    } else if (diffY < 0) { //下滑
        [PlayerBar hide];
    }
}

- (void)dealloc {
    NSLog(@"DEALLOC====>%@", self);
}

@end
