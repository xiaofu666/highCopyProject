//
//  WRASIADestinationOneCell.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRASIADestinationOneCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation WRASIADestinationOneCell
{
    UILabel* _countryLabel;//显示cell上的城市名
    UIImageView* _imageView;//城市图
    UILabel* _cnnameLabel;//汉语名
    UILabel* _ennameLabel;//英文名
    UIControl* _control;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)createCell{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _countryLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:10 andWidth:120 andHeight:40]];
    [self.contentView addSubview:_countryLabel];
    _countryLabel.textColor = [UIColor lightGrayColor];
    UIView* view = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:55 andWidth:365 andHeight:1]];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.5;
    [self.contentView addSubview:view];
    for (int i = 0; i < self.imageArrCount; i ++) {
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:(10 + i % 2 * (172.5 + 10)) andY:70 + i / 2 * (100 + 10) andWidth:172.5 andHeight:100]];
        imageView.tag = 10 + i;
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        
        UIView* view = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:172.5 andHeight:100]];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.1;
        [imageView addSubview:view];
        _control = [[UIControl alloc]initWithFrame:[delegate createFrimeWithX:0 andY:0 andWidth:172.5 andHeight:100]];
        [_control addTarget:self action:@selector(pressControl:) forControlEvents:UIControlEventTouchUpInside];
        _control.tag = 40 + i;
        [imageView addSubview:_control];
        UILabel* citycnnameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:( i % 2 * (180 + 10)) andY:100 + i / 2 * (100 + 10) andWidth:172.5 andHeight:20]];
        citycnnameLabel.textColor = [UIColor whiteColor];
        citycnnameLabel.textAlignment = NSTextAlignmentCenter;
        citycnnameLabel.tag = 20 + i;
        [self.contentView addSubview:citycnnameLabel];
        UILabel* cityennameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:(i % 2 * (180 + 10)) andY:120 + i / 2 * (100 + 10) andWidth:172.5 andHeight:20]];
        cityennameLabel.textColor = [UIColor whiteColor];
        cityennameLabel.textAlignment = NSTextAlignmentCenter;
        cityennameLabel.tag = 30 + i;
        [self.contentView addSubview:cityennameLabel];
    }
}
-(void)pressControl:(id)sender{
  
    UIControl* control = (UIControl*)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendControl:)]) {
        [self.delegate sendControl:control];
    }else {
        NSLog(@"没有代理或未实现协议方法");
    }
}
-(void)showAppModel:(WRDestinationCountryAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath{
    /*
     UILabel* _countryLabel;//显示cell上的城市名
     UIImageView* _imageView;//城市图
     UILabel* _cnnameLabel;//汉语名
     UILabel* _ennameLabel;//英文名
     */
    NSArray *array = self.contentView.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
    [self createCell];
    _countryLabel.text = [NSString stringWithFormat:@"%@城市",appModel.cnname];
    for (int i = 0; i < [appModel.hot_city count];i ++){
        UIImageView* imageView = (UIImageView*)[self viewWithTag:10 + i];
        UILabel* citycnnameLabel = (UILabel*)[self viewWithTag:20 + i];
        UILabel* cityennameLabel = (UILabel*)[self viewWithTag:30 + i];
        
        [imageView setImageWithURL:[NSURL URLWithString:appModel.hot_city[i][ @"photo"]]];
      
        citycnnameLabel.text = appModel.hot_city[i][@"cnname"];
        cityennameLabel.text = appModel.hot_city[i][@"enname"];
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
