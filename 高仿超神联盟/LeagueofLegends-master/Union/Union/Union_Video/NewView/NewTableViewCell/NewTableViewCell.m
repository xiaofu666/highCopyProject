//
//  NewTableViewCell.m
//  Union
//
//  Created by lanou3g on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NewTableViewCell.h"

#import "PCH.h"

#import "NSString+GetWidthHeight.h"
@implementation NewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//初始化控件
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cover_url = [[UIImageView alloc]init];
        
        [self addSubview:self.cover_url];
        
        
        self.titleLable = [[UILabel alloc]init];
        
        self.titleLable.numberOfLines = 0;
        
        self.titleLable.font = [UIFont systemFontOfSize:15];
        
        self.titleLable.textColor = [UIColor blackColor];
        
        [self addSubview:self.titleLable];
        
        
        self.video_length = [[UILabel alloc]init];
        
        self.video_length.textAlignment = NSTextAlignmentCenter;
        
        self.video_length.textColor = [UIColor grayColor];
        
        self.video_length.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.video_length];
        
        
        self.upload_time = [[UILabel alloc]init];
        
        self.upload_time.textAlignment = NSTextAlignmentCenter;
        
        self.upload_time.textColor = [UIColor grayColor];
        
        self.upload_time.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.upload_time];
        
        self.download = [UIButton buttonWithType:UIButtonTypeCustom];
    
//        self.download.backgroundColor = [UIColor redColor];
        
        self.download.tintColor = MAINCOLOER;
        
        self.download.imageView.image = [[UIImage imageNamed:@"iconfont-download"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [self.download setImage:self.download.imageView.image forState:UIControlStateNormal];
        
        [self addSubview:self.download];
        
        
    }

    return self;

}
//设置布局
-(void)layoutSubviews{

    [super layoutSubviews];

    self.cover_url.frame = CGRectMake(10, 10, 100, 70);

    self.titleLable.frame = CGRectMake(120, 10, self.frame.size.width - 140, self.frame.size.height - 40);

    self.video_length.frame = CGRectMake(self.frame.size.width - 105, self.frame.size.height - 30, 35, 20);

    self.upload_time.frame = CGRectMake(120, self.frame.size.height - 30, 35, 20);
    self.download.frame = CGRectMake(self.frame.size.width - 55, self.frame.size.height - 37, 25, 25);

}

//重写set方法
-(void)setModel:(NewModel *)Model{
    
    if (_Model != Model) {
        
        [_Model release];
        
        [Model retain];
        
        _Model = Model;
    }
//赋值
    _titleLable.text = Model.title;
    
    _video_length.text = Model.video_length;
    
    _upload_time.text = Model.upload_time;

}

-(void)dealloc{
    
    [_upload_time release];
    
    [_video_length release];
    
    [_cover_url release];
    
    [_titleLable release];
    
    [_Model release];
    
    [_download release];
    
    [super dealloc];

}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
