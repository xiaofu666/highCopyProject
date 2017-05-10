//
//  NZCHotCarouselTableViewCell.m
//  presents
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "NZCHotCarouselTableViewCell.h"

@implementation NZCHotCarouselTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.carousel = [[Carousel alloc] init];
        [self addSubview:self.carousel];
        
        self.titleStr = [[UILabel alloc] init];
        [self addSubview:self.titleStr];
        
        self.info = [[UILabel alloc] init];
        self.info.numberOfLines = 0;
        self.info.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.info];
        
        self.priceString = [[UILabel alloc] init];
        self.priceString.textColor = [UIColor redColor];
        [self addSubview:self.priceString];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.carousel.frame = CGRectMake(0, 0, self.width, self.height * 3 / 5);
    [self.carousel setArray:self.array withTitArray:nil];
    self.titleStr.frame = CGRectMake(15, _carousel.bottom + 5, self.width - 30, 50);
    self.priceString.frame = CGRectMake(15, _titleStr.bottom - 15, 80, 30);
    self.info.frame = CGRectMake(15, _priceString.bottom, self.width - 30, self.info.height);
}



- (void)setArray:(NSArray *)array {
    if (_array != array) {
        _array = array;
    }
}

- (void)setHotModel:(HotModel *)hotModel {
    if (_hotModel != hotModel) {
        _hotModel = hotModel;
    }
    self.titleStr.text = hotModel.name;
    self.priceString.text = [NSString stringWithFormat:@"￥%@", hotModel.price];
    self.info.text = hotModel.descriptions;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    //    通过字典计算高度和宽度
    CGRect rect = [self.info.text boundingRectWithSize:CGSizeMake(self.width - 30, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    //    保持原本坐标不变，只更改高度
    self.info.frame = CGRectMake(self.info.frame.origin.x, self.info.frame.origin.y, self.info.frame.size.width, rect.size.height);
    NSLog(@"高度为:高度为:高度为:%f", _info.height);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
