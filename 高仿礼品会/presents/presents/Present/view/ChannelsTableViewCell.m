//
//  ChannelsTableViewCell.m
//  presents
//
//  Created by dapeng on 16/1/10.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "ChannelsTableViewCell.h"

@implementation ChannelsTableViewCell



- (void)layoutSubviews {
    [super layoutSubviews];
    int x = 15;
    int y = 10;
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    view.userInteractionEnabled = YES;
    for (int i = 0; i < self.channelsArr.count; i++) {
        self.titles = [[UILabel alloc] initWithFrame:CGRectMake(x, y, (self.width - 40) / 3, 30)];
        self.titles.font = [UIFont systemFontOfSize:15];
        self.titles.text = [self.channelsArr objectAtIndex:i];
        self.titles.tag = 700 + i;

        
        self.titles.textAlignment = NSTextAlignmentCenter;
        self.titles.backgroundColor = [UIColor whiteColor];
        self.titles.textColor = [UIColor colorWithWhite:0.155 alpha:1.000];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(labelAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.titles addGestureRecognizer:tap];
        self.titles.layer.borderColor = [UIColor colorWithWhite:0.712 alpha:1.000].CGColor;
        self.titles.layer.borderWidth = 1;
        self.titles.userInteractionEnabled = YES;
        self.titles.layer.cornerRadius = 3;
        x += (self.width - 40) / 3 + 10;
        
        if (self.titles.frame.origin.x > (self.width - 40) / 3 * 2) {
            x = 15;
            y += 40;

        }
        if (self.titles.tag == 700) {
            self.titles.backgroundColor = [UIColor redColor];
            self.titles.textColor = [UIColor whiteColor];
        }
        [view addSubview:self.titles];
        view.backgroundColor = [UIColor colorWithWhite:0.974 alpha:1.000];
        [self addSubview:view];
    }
    
    
}

- (void)labelAction:(UITapGestureRecognizer *)tap {
    NSInteger count = tap.view.tag - 700;
    UILabel *label = (UILabel *)[self viewWithTag:tap.view.tag];
    label.backgroundColor = [UIColor redColor];
    if (label.tag != tap.view.tag) {
        
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
    }
    [self.channelsDelegate passTag:count];

    
}
- (void)setChannelsArr:(NSMutableArray *)channelsArr {
    if (_channelsArr != channelsArr) {
        _channelsArr = channelsArr;
    }
    NSString *all = @"全部";
    [self.channelsArr insertObject:all atIndex:0];
   
}

- (CGFloat)getWidthWithText:(NSString *)text withFont:(CGFloat)font {
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
