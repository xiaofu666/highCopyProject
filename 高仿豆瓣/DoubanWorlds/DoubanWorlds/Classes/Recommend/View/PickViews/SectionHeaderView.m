//
//  SectionHeaderView.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//


#import "SectionHeaderView.h"

@interface SectionHeaderView ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation SectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
        self.backgroundColor = KColor(244, 244, 244);
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.frame = CGRectMake(15, 0, 200, 25);
    _headerLabel.textColor = [UIColor grayColor];
    _headerLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_headerLabel];
}


-(void)setText:(NSString *)text{
    _text = text;
    _headerLabel.text = text;
}

+(CGFloat)getSectionHeadHeight{
    return 25;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com