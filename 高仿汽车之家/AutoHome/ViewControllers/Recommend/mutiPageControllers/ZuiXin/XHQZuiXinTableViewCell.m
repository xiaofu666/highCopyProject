//
//  XHQZuiXinTableViewCell.m
//  AutoHome
//
//  Created by qianfeng on 16/3/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQZuiXinTableViewCell.h"

@interface XHQZuiXinTableViewCell  ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;

@end




@implementation XHQZuiXinTableViewCell

- (void)setModel:(XHQZuiXinModel *)model
{
    _model = model;
#pragma mark -- 真机奔溃
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    self.title.text = model.title;
    if([model.count isEqualToString:@"0"])
    {
       self.count.text = @"抢沙发";
    }else{
   
        self.count.text = [NSString stringWithFormat:@"%@评论",model.count];
    }
    self.pubDate.text = model.pubDate;

    
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com