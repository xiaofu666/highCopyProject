//
//  XyWholeTableViewCell.m
//  presents
//
//  Created by Xy on 16/1/13.
//  Copyright © 2016年 dapeng. All rights reserved.
//

#import "XyWholeTableViewCell.h"

@implementation XyWholeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.myImage.contentMode = UIViewContentModeScaleAspectFill;
    self.myImage.clipsToBounds = YES;//超越父视图边界以外不显示。
    self.sLable.textColor = [UIColor whiteColor];
    self.lables.textColor = [UIColor whiteColor];
    self.myView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
   
}

- (void)setModel:(WholeModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:nil options:SDWebImageContinueInBackground | SDWebImageTransformAnimatedImage];
    self.sLable.text = model.title;
    self.lables.text = model.subtitle;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
