//
//  XHQFoundTableViewCell.m
//  
//
//  Created by qianfeng on 16/3/21.
//
//

#import "XHQFoundTableViewCell.h"

#import "XHQAuxiliary.h"
@interface XHQFoundTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *floor;

@property (weak, nonatomic) IBOutlet UIImageView *userface;
@property (weak, nonatomic) IBOutlet UILabel *nickname;

@end


@implementation XHQFoundTableViewCell

- (void)setModel:(XHQFoundModel *)model
{
    _model = model;
    NSDictionary *dict = model.author;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.title.text = model.title;
    
    NSString *floor = [NSString stringWithFormat:@"%@回/%@读",model.floor,model.view];
    
    self.floor.text = floor;
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
  // NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.lastpostAt];
   // self.pubDate. text = [formatter stringFromDate:date];

    
    [self.userface sd_setImageWithURL:[NSURL URLWithString:dict[@"userface"]]];
    [XHQAuxiliary layerCornerRadius:self.userface.layer radius:30 width:0 color:[UIColor yellowColor]    ];
    
    
    
    self.nickname.text = dict[@"nickname"];
    
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com