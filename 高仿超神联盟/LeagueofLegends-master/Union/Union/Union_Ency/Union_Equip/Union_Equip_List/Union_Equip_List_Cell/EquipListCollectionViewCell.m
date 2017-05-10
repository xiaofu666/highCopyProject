//
//  EquipListCollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipListCollectionViewCell.h"

@interface EquipListCollectionViewCell ()

@property (nonatomic , retain ) UIImageView *picImageView;//装备图片

@property (nonatomic , retain ) UILabel *titleLabel;//装备标题

@end

@implementation EquipListCollectionViewCell

-(void)dealloc{
    
    [_picImageView release];
    
    [_titleLabel release];
    
    [_model release];
    
    [super dealloc];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化装备图标
        
        _picImageView = [[UIImageView alloc]init];
        
        _picImageView.layer.cornerRadius = 8.0f;
        
        _picImageView.clipsToBounds = YES;
        
        [self addSubview:_picImageView];
        
        //初始化装备标题
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
        
    }
    return self;

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _picImageView.frame = CGRectMake(0, 10, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
    
    _titleLabel.frame = CGRectMake(0, CGRectGetWidth(self.frame) +15, CGRectGetWidth(self.frame) , 20);
    
    
}


- (void)setModel:(EquipListModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }
    
    //非空判断
    
    if (model != nil) {
        
        //拼接装备图片url
        
        NSString *picURL = [NSString stringWithFormat:kUnion_Equip_ListImageURL , (long)model.eid];
        
        //SDWebImage 异步请求加载装备图片 <根据装备ID为参数>
        
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"poluoimage_gray"]];
        
        //添加装备标题
        
        _titleLabel.text = model.text;
        
        
    }

    
}



@end
