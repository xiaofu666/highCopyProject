//
//  XHQForumAllTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQForumAllTableViewCell.h"


@interface XHQForumAllTableViewCell  ()

@property (weak, nonatomic) IBOutlet UIImageView *userface;

@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *title;



@property (weak, nonatomic) IBOutlet UILabel *replyCount;


@property (weak, nonatomic) IBOutlet UIImageView *imageThree;

@property (weak, nonatomic) IBOutlet UIImageView *isBest;


@end
@implementation XHQForumAllTableViewCell

- (void)setModel:(XHQForumAllModel *)model
{
    _model = model;
    NSDictionary *dict = model.author;
    
    [self.userface sd_setImageWithURL:[NSURL URLWithString:dict[@"userface"]]];
    
    
    [XHQAuxiliary layerCornerRadius:self.userface.layer radius:30 width:0 color:[UIColor redColor]];
  [self.imageThree sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    self.nickname.text = dict[@"nickname"];
    
    self.title.text = model.title;
    
    self.replyCount.text = [NSString stringWithFormat:@"%@回/%@阅",model.replyCount,model.view];
    
    
    
    
    if(model.flag)
    {
        self.isBest.image = [UIImage imageNamed:@"a53.png"];
    }
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com