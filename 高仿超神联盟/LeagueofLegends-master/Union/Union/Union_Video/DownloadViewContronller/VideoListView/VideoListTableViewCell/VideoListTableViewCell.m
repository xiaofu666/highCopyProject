//
//  NewTableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by Harris on 15-7-20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "VideoListTableViewCell.h"

#import "PCH.h"

#import "NSString+GetWidthHeight.h"

#import <UIImageView+WebCache.h>

#import <MobClick.h>

#import "DownloadDynamicEffectView.h"



@interface VideoListTableViewCell ()

@property (nonatomic ,retain) UIImageView *cover_url;//图片

@property (nonatomic ,retain) UILabel *titleLable;//标题

@property (nonatomic ,retain) UILabel *video_length;//时长

@property (nonatomic ,retain) UILabel *upload_time;//更新时间

@property (nonatomic , retain ) DownloadDynamicEffectView *downloadButtonView;//下载按钮视图

@end

@implementation VideoListTableViewCell

-(void)dealloc{
    
    [_upload_time release];
    
    [_video_length release];
    
    [_cover_url release];
    
    [_titleLable release];
    
    [_Model release];
    
    [_downloadButtonView release];
    
    [super dealloc];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    //初始化控件
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        self.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 90);
        
        
        _cover_url = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _cover_url.tintColor = [UIColor lightGrayColor];
        
        [self addSubview:_cover_url];
        
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.frame.size.width - 180, self.frame.size.height - 40)];
        
        _titleLable.numberOfLines = 0;
        
        _titleLable.font = [UIFont systemFontOfSize:14];
        
        _titleLable.textColor = [UIColor blackColor];
        
        [self addSubview:_titleLable];
        
        
        _video_length = [[UILabel alloc]init];
        
        _video_length.textAlignment = NSTextAlignmentRight;
        
        _video_length.textColor = [UIColor grayColor];
        
        _video_length.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_video_length];
        
        
        _upload_time = [[UILabel alloc]init];
        
        _upload_time.textAlignment = NSTextAlignmentCenter;
        
        _upload_time.textColor = [UIColor grayColor];
        
        _upload_time.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_upload_time];
        
        _downloadButtonView = [[DownloadDynamicEffectView alloc]initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _downloadButtonView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_downloadButtonView];

        
        
        //获取在线参数判断是否显示下载
        
        BOOL isShowDownLoad = [[MobClick getConfigParams:@"isShowDownLoad"] boolValue];
        
        if (isShowDownLoad) {
            
            //显示下载按钮
            
            _downloadButtonView.hidden = NO;
            
        } else {
            
            //隐藏下载按钮
            
            _downloadButtonView.hidden = YES;
            
        }
        
        
    }

    return self;

}

//设置布局

-(void)layoutSubviews{

    [super layoutSubviews];

    _cover_url.frame = CGRectMake(10, 10, 100, 70);

    _video_length.frame = CGRectMake(self.frame.size.width - 125, self.frame.size.height - 25, 50 , 15);

    _upload_time.frame = CGRectMake(120, self.frame.size.height - 25, 35, 15);

}

//重写set方法

-(void)setModel:(VideoListModel *)Model{
    
    if (_Model != Model) {
        
        [_Model release];
        
        [Model retain];
        
        _Model = Model;
        
    }
    
    //赋值
    
    NSURL *picUrl = [NSURL URLWithString:Model.cover_url];
    
    [_cover_url sd_setImageWithURL:picUrl placeholderImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    _titleLable.text = Model.title;
    
    _video_length.text = Model.video_length;
    
    _upload_time.text = Model.upload_time;
    
    //计算titleLable内容所需高度
    
    CGFloat titleLableHeight = [NSString getHeightWithstring:Model.title Width:self.frame.size.width - 180 FontSize:14];
    
    //设置高度
    
    _titleLable.frame = CGRectMake(_titleLable.frame.origin.x , _titleLable.frame.origin.y , _titleLable.frame.size.width , titleLableHeight);
     
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
