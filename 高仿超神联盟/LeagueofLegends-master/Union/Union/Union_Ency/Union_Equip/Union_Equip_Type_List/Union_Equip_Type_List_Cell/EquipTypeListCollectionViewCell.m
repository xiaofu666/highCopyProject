//
//  EquipTypeListCollectionViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "EquipTypeListCollectionViewCell.h"

@interface EquipTypeListCollectionViewCell ()

@property (nonatomic , retain ) UILabel *titleLabel;

@end

@implementation EquipTypeListCollectionViewCell


-(void)dealloc{
    
    [_model release];
    
    [_titleLabel release];
    
    [super dealloc];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"HoneycombBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        backgroundImageView.tintColor = MAINCOLOER;
        
        backgroundImageView.frame = self.frame;
        
        self.backgroundView = backgroundImageView;
        
        [backgroundImageView release];
        
        //初始化标题Label
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame))];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_titleLabel];
 
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    
}

-(void)setModel:(EquipTypeListModel *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
        
    }
    
    //添加数据
    
    self.titleLabel.text = model.text;

}

-(void)setItemSize:(CGFloat)itemSize{
    
    [super setItemSize:itemSize];
    
    //设置cell蜂窝样式
    
//    [self settingCellHoneycombStyle];
    
}


@end
