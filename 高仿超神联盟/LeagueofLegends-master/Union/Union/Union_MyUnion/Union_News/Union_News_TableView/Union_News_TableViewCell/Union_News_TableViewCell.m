//
//  Union_News_Headlines_TableViewCell.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/23.
//  Copyright (c) 2015年 Lee. All rights reserved.
//
#import "Union_News_TableViewCell.h"

#import "NSString+GetWidthHeight.h"

#import <UIImageView+WebCache.h>

#import "PCH.h"

#import "NSString+SensitiveWords.h"

@interface Union_News_TableViewCell()



@end


@implementation Union_News_TableViewCell

-(void)dealloc {
    
    [_photoImageView release];
    
    [_whiteView release];
    
    [_titleLabel release];
    
    [_timeLabel release];
    
    [_readCountLabel release];
    
    [_readWordLabel release];
    
    [_photoVideoLabel release];
    
    [_contentLabel release];
    
    [_model release];
    
    [super dealloc];
}

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        
        //cell上面的底部白色视图
        
        _whiteView = [[UIView alloc]init];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_whiteView];
        
        //初始化图片
        
        _photoImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _photoImageView.tintColor = [UIColor lightGrayColor];
        
        [_whiteView addSubview:_photoImageView];
        
        //类型图标
        
        _photoVideoLabel = [[UILabel alloc]init];
        
        _photoVideoLabel.textColor = [UIColor whiteColor];
        
        _photoVideoLabel.font = [UIFont systemFontOfSize:12];
        
        _photoVideoLabel.textAlignment = NSTextAlignmentCenter;
        
        [_photoImageView addSubview:_photoVideoLabel];
        
        
        //初始化主标题
        
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [_whiteView addSubview:_titleLabel];
        
        //初始化内容
        
        _contentLabel = [[UILabel alloc]init];
        
        _contentLabel.frame = CGRectMake(80 + 10 , 16 , self.whiteView.frame.size.width - self.photoImageView.frame.size.width - 10 , 0);
        
        _contentLabel.font = [UIFont systemFontOfSize:12];
        
        _contentLabel.textColor = [UIColor grayColor];
        
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        [_whiteView addSubview:_contentLabel];
        
        //初始化阅读人数
        
        _readCountLabel = [[UILabel alloc]init];
        
        _readCountLabel.font = [UIFont systemFontOfSize:12];
        
        _readCountLabel.textColor = [UIColor lightGrayColor];
        
        _readCountLabel.textAlignment = NSTextAlignmentRight;
        
        [_whiteView addSubview:_readCountLabel];
        
        
        [_readCountLabel release];
        
        [_contentLabel release];
        
        [_titleLabel release];
        
        [_whiteView release];
        

        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //cell上面的底部白色视图
    
    self.whiteView.frame = CGRectMake(10, 10, self.frame.size.width - 20, 80 - 20);
    
    //图片
    
    self.photoImageView.frame = CGRectMake(0, 0, 80, 60);
    
    //图片上是否显示视频
    
    self.photoVideoLabel.frame = CGRectMake(self.photoImageView.frame.size.width - 27, self.photoImageView.frame.size.height - 15, 27, 15);
    
    //标题
    
    self.titleLabel.frame = CGRectMake(80 + 10 , 0, self.whiteView.frame.size.width - self.photoImageView.frame.size.width - 10 , 16);
    
    
    //内容

    self.contentLabel.frame = CGRectMake(80 + 10 , 16 , self.whiteView.frame.size.width - self.photoImageView.frame.size.width - 10 , CGRectGetHeight(self.contentLabel.frame));
    
    //阅读人数
    
    self.readCountLabel.frame = CGRectMake(self.whiteView.frame.size.width- 80 , self.whiteView.frame.size.height - 12  , 80, 14);
  

}


//重写set

- (void)setModel:(Union_News_TableView_Model *)model{
    
    if (_model != model) {
        
        [_model release];
        
        _model = [model retain];
    }
    
    _titleLabel.text = [_model.title removeSensitiveWordsWithArray:@[@"手机盒子",@"手机饭盒",@"多玩饭盒",@"多玩",@"饭盒",@"盒子"]];
    
    if ([model.readCount isEqualToString:@"0"]) {
        
        _readCountLabel.hidden = YES;
        
    } else {
        
        _readCountLabel.hidden = NO;
        
        _readCountLabel.text = [NSString stringWithFormat:@"%@阅读",_model.readCount];
        
    }
    
    
    //通过设置管理 获取是否允许加载图片
    
    if ([[SettingManager shareSettingManager]loadImageAccordingToTheSetType]) {
        
        //SDWebImage加载图片
        
        NSURL *url = [NSURL URLWithString:_model.photo];
        
        [self.photoImageView sd_setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
    } else {
        
        self.photoImageView.image = [[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
    }
    
    
    
    [self heightContentTitle:_model.content];
    
    [self judgeCellType];
    
}


//计算子标题的高度

- (void)heightContentTitle:(NSString *)textStr{
    
    //清除敏感字符串
    
    textStr = [textStr removeSensitiveWordsWithArray:@[@"手机盒子"]];
    
    //计算高度
    
    CGFloat height = [NSString getHeightWithstring:textStr Width:self.contentLabel.frame.size.width FontSize:12];
    
    //内容重置frame
    
    _contentLabel.frame = CGRectMake(80 + 10, 16, self.titleLabel.frame.size.width, height > 30 ? 30 : height);
    
    //自动换行
    
    _contentLabel.numberOfLines = 0;
    
    _contentLabel.text = textStr;
    
}


//判断内容类型

- (void)judgeCellType{
    
    
    if ([_model.type isEqualToString:@"topic"]) {
        
        self.photoVideoLabel.text = @"专题";
        
        self.photoVideoLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
        
        self.photoVideoLabel.hidden = NO;
        
        //隐藏阅读数
        
        self.readCountLabel.hidden = YES;
        
        //设置内高度
        
        self.contentLabel.frame = CGRectMake(80 + 10 , 20 , self.whiteView.frame.size.width - self.photoImageView.frame.size.width - 10 , 45);
        
        
    }
        
    if ([_model.type isEqualToString:@"news"]) {
        
        self.photoVideoLabel.hidden = YES;
        
        self.readCountLabel.hidden = NO;
        
    }
    
    if ( [_model.type isEqualToString:@"video"]) {
        
        self.photoVideoLabel.hidden = NO;
        
        self.photoVideoLabel.text = @"视频";
        
        self.photoVideoLabel.textColor = [UIColor whiteColor];
        
        self.photoVideoLabel.backgroundColor = [MAINCOLOER colorWithAlphaComponent:0.8];
        
        self.readCountLabel.hidden = NO;

    }
    
    
   }

//时间换成现在时间

- (void)timeTansform{
    
    //当前时间
    NSDate *currentDate = [NSDate date];
    
    //转换时间戳，以秒为单位
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    
    //当前的天数
    
    int currentDayNumbers = ((int)timeInterval)/(24*3600);
    
    //更新时间的天数
    
    NSTimeInterval modleTime = [_model.time doubleValue];
    
    int modleDayNumbers = ((int)modleTime) /(24*3600);
    
    int timeDay = currentDayNumbers - modleDayNumbers;
    
    int timeSeconds = ((int)timeInterval) - ((int)modleTime);
    
    //转化时间格式
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    
    [fomatter setDateStyle:NSDateFormatterShortStyle];
    
    [fomatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    NSDate *update = [NSDate dateWithTimeIntervalSince1970:modleTime];
    
    NSString *timeString = [[fomatter stringFromDate:update] autorelease];
    
    //判断更新时间的所在时间线位置
    
    if (timeDay == 0) {
        
        if (timeSeconds < 3600) {
            
            _timeLabel.text = [NSString stringWithFormat:@"%d分钟之前",timeSeconds / 60];
        }else{
            
            NSString *timeString1 = [timeString substringFromIndex:11];
            
            _timeLabel.text = [NSString stringWithFormat:@"今天%@",timeString1];
        }
        
    }
    
    if (timeDay == 1) {
        
        NSString *timeString1 = [timeString substringFromIndex:11];
        
        _timeLabel.text = [NSString stringWithFormat:@"昨天%@",timeString1];
    }
    
    if (timeDay == 2) {
        
        NSString *timeString1 = [timeString substringFromIndex:11];
        
        _timeLabel.text = [NSString stringWithFormat:@"前天%@",timeString1];
    }
    
    if (timeDay > 2) {
        
        _timeLabel.text = timeString;
    }
    
}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
