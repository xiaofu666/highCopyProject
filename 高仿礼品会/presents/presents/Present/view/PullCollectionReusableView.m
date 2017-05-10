//
//  PullCollectionReusableView.m
//  presents
//
//  Created by dapeng on 16/1/12.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "PullCollectionReusableView.h"

@interface PullCollectionReusableView()
@property (nonatomic, copy)ClickBlock clickBlock;

@end

@implementation PullCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
    }
    return self;
}

-(void)confingSubViews{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, self.bounds.size.height)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = RGB(51, 51, 51, 1);
    [self addSubview:self.titleLabel];
    
    self.clickButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 100, 10, 60, 20)];
    self.clickButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.clickButton.backgroundColor = RGB(240, 240, 240, 1);
    self.clickButton.layer.masksToBounds = YES;
    self.clickButton.layer.cornerRadius = 5;
    self.clickButton.layer.borderColor = RGB(214, 39, 48, 1).CGColor;
    self.clickButton.layer.borderWidth = 0.7;
    [self.clickButton setTitle:@"排序删除" forState:UIControlStateNormal];
    [self.clickButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.clickButton setTitleColor:RGB(214, 39, 48, 1) forState:UIControlStateNormal];
    [self.clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickButton];
}
-(void)clickWithBlock:(ClickBlock)clickBlock{
    if (clickBlock) {
        self.clickBlock = clickBlock;
    }
}
-(void)clickAction:(UIButton *)sender{
    self.clickButton.selected = !self.clickButton.selected;
    if (sender.selected) {
        self.clickBlock(StateSortDelete);
    }else{
        self.clickBlock(StateComplish);
    }
    
}
#pragma mark ----------- set ---------------
-(void)setButtonHidden:(BOOL)buttonHidden{
    if (buttonHidden != _buttonHidden) {
        self.clickButton.hidden = buttonHidden;
        _buttonHidden = buttonHidden;
    }
}

@end
