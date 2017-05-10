//
//  WNXRmndHeadView.m
//  WNXHuntForCity
//  github:    https://github.com/ZhongTaoTian/WNXHuntForCity
//  项目讲解博客:http://www.jianshu.com/p/8b0d694d1c69
//  Created by MacBook on 15/7/2.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  推荐tableView headView

#import "WNXRmndHeadView.h"
#import "UIColor+WNXColor.h"

@interface WNXRmndHeadView ()

//分类名
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//数量
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation WNXRmndHeadView

+ (instancetype)headViewWith:(WNXHomeModel *)headModel
{
    WNXRmndHeadView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    headView.headModel = headModel;
    
    return headView;
}

- (void)setHeadModel:(WNXHomeModel *)headModel
{
    _headMode = headModel;
    self.titleLabel.text = headModel.tag_name;
    self.subTitleLabel.text = headModel.section_count;
    self.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com