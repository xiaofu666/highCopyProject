//
//  XyGiftTableViewCell.m
//  presents
//
//  Created by Xy on 16/1/9.
//  Copyright © 2016年 Xy. All rights reserved.
//

#import "XyLinkageTableViewCell.h"

@implementation XyLinkageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.viewColor = [[UIView alloc] init];
        self.views = [[UIView alloc] init];
        self.viewss = [[UIView alloc] init];

        self.name = [[UILabel alloc] init];
        [self addSubview:self.viewColor];
        [self.viewColor addSubview:self.name];
        [self.viewColor addSubview:self.viewss];
        //选中后的Cell选中后的view是selectedBackgroundView
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.selectedBackgroundView addSubview:self.views];
        

    }
    return self;
}

- (void)setTitleName:(NSString *)titleName {
    if (_titleName != titleName) {
        _titleName = titleName;
    }
    self.name.text = titleName;
    self.views.backgroundColor = [UIColor redColor];
    self.viewss.backgroundColor = [UIColor colorWithRed:0.8847 green:0.8847 blue:0.8847 alpha:1.0];
    self.name.font = [UIFont systemFontOfSize:12];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.highlightedTextColor = [UIColor redColor];
    self.viewColor.backgroundColor = [UIColor colorWithRed:0.8847 green:0.8847 blue:0.8847 alpha:1.0];
    
}



-(void)layoutSubviews {
    [super layoutSubviews];
    self.viewColor.frame = self.bounds;
    self.selectedBackgroundView.frame = self.bounds;

    self.views.frame = CGRectMake(0, 0, 2, self.height);
    self.viewss.frame = CGRectMake(0, 0, 2, self.height);

    self.name.frame = CGRectMake(0, 2, self.width - 2, self.height);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
