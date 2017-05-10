//
//  XHQPictTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQPictTableViewCell.h"

@interface XHQPictTableViewCell  ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end


@implementation XHQPictTableViewCell

- (void)setModel:(XHQPictModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.name.text = model.name;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com