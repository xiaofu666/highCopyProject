//
//  Hero_Details_Details_TipsCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/10.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "Hero_Details_Details_TipsCell.h"


@interface Hero_Details_Details_TipsCell ()

@property (nonatomic , retain ) UILabel *contentLabel;//内容

@end

@implementation Hero_Details_Details_TipsCell

-(void)dealloc{
    
    [_contentLabel release];
    
    [_content release];
    
    [super dealloc];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //初始化内容
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 50, CGRectGetWidth(self.rootView.frame) - 20 , 20)];
        
        _contentLabel.textColor = [UIColor blackColor];
        
        _contentLabel.font = [UIFont systemFontOfSize:16];
        
        _contentLabel.numberOfLines = 0;
        
        [self.rootView addSubview:_contentLabel];
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

#pragma mark ---获取数据



-(void)setContent:(NSString *)content{
    
    if (_content != content) {
        
        [_content release];
        
        _content = [content retain];
        
        //添加内容
        
        _contentLabel.text = content;
        
        //计算所需高度
        
        CGFloat contentLabelHeight = [NSString getHeightWithstring:content Width:CGRectGetWidth(_contentLabel.frame) FontSize:16];
        
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, CGRectGetWidth(_contentLabel.frame), contentLabelHeight);
        
        //设置cell高度
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CGRectGetWidth(self.frame), _contentLabel.frame.origin.y + CGRectGetHeight(_contentLabel.frame) + 40);
        
    }
    
}


@end
