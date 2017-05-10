//
//  SearchTableViewCell.m
//  presents
//
//  Created by dapeng on 16/1/9.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    int x = 15;
    int y = 10;
    for (int i = 0; i < self.titleArr.count; i++) {
        self.titles = [[UILabel alloc] init];
        self.titles.textColor = [UIColor blackColor];
        self.titles.font = [UIFont systemFontOfSize:12];
        searchModel *model = [self.titleArr objectAtIndex:i];
        self.titles.text = model.hot_words;
        
        CGFloat labelWidth = [self getWidthWithText:self.titles.text withFont:12];
        self.titles.frame = CGRectMake(x, y, labelWidth + 40, 30);

        self.titles.textAlignment = NSTextAlignmentCenter;
        self.titles.backgroundColor = [UIColor whiteColor];
        self.titles.textColor = [UIColor colorWithWhite:0.155 alpha:1.000];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.titles addGestureRecognizer:tap];
        self.titles.layer.borderColor = [UIColor colorWithWhite:0.712 alpha:1.000].CGColor;
        self.titles.layer.borderWidth = 1;
        self.titles.userInteractionEnabled = YES;
        self.titles.layer.cornerRadius = 3;
        self.titles.tag = 10000 + i;
        x += labelWidth + 50;
        
        if (x + 60 + 15 >= self.contentView.width) {
            x = 15;
            y += 35;
        }
        [self.contentView addSubview:self.titles];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)[self.contentView viewWithTag:tap.view.tag];
    [self.searchDelegate passTitle:label.text];
}

- (void)setTitleArr:(NSMutableArray *)titleArr {
    if (_titleArr != titleArr) {
        _titleArr = titleArr;
    }
}

#pragma mark ------------自适应高度&&宽度方法--------------
- (CGFloat)getWidthWithText:(NSString *)text withFont:(CGFloat)font {
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}

- (CGFloat)getHeightWithText:(NSString *)text withFont:(CGFloat)font {
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
