//
//  MyUnion_TableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "MyUnion_TableViewCell.h"


@interface MyUnion_TableViewCell ()

@property (nonatomic , retain ) UILabel *titleLabel;

@property (nonatomic , retain ) UILabel *detailTitleLabel;

@end

@implementation MyUnion_TableViewCell

-(void)dealloc{
    
    [_titleStr release];
    
    [_titleLabel release];
    
    [_detailStr release];
    
    [_detailTitleLabel release];
    
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
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor grayColor];
        
        [self addSubview:_titleLabel];
        
        _detailTitleLabel = [[UILabel alloc]init];
        
        _detailTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _detailTitleLabel.font = [UIFont systemFontOfSize:14];
        
        _detailTitleLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_detailTitleLabel];
        
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20 , 0 , CGRectGetWidth(self.frame) - 10 - 100 - 30 , CGRectGetHeight(self.frame));
    
    _detailTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 20 - 100 - 30 , 0 , 100 , CGRectGetHeight(self.frame));
    
}

-(void)setTitleStr:(NSString *)titleStr{
    
    if (_titleStr != titleStr) {
        
        [_titleStr release];
        
        _titleStr = [titleStr retain];
        
    }
    
    _titleLabel.text = titleStr;
    
}

-(void)setDetailStr:(NSString *)detailStr{
    
    if (_detailStr != detailStr) {
        
        [_detailStr release];
        
        _detailStr = [detailStr retain];
        
    }
    
    _detailTitleLabel.text = detailStr;
    
}


@end
