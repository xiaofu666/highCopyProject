//
//  WRCityTwoCell.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCityTwoCell.h"
#import "WRCityAppModel.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation WRCityTwoCell
{
    UIImageView* _photoImageView;
    UILabel* _titleLabel;
    UILabel* _priceoffLabel;
    UILabel* _priceLabel;
    UILabel* _priceLabel2;//元起
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}
-(void)createCell{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _photoImageView = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:10 andWidth:70 andHeight:60]];
    [self.contentView addSubview:_photoImageView];
    _titleLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:90 andY:10 andWidth:250 andHeight:40]];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    _priceoffLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:90 andY:50 andWidth:100 andHeight:20]];
    _priceoffLabel.font = [UIFont systemFontOfSize:13];
    _priceoffLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_priceoffLabel];
    _priceLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:280 andY:50 andWidth:50 andHeight:20]];
    _priceLabel.textColor = [UIColor purpleColor];
    
    [self.contentView addSubview:_priceLabel];
    _priceLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:330 andY:55 andWidth:40 andHeight:10]];
    _priceLabel2.font = [UIFont systemFontOfSize:12];
    _priceLabel2.textColor = [UIColor purpleColor];
    [self.contentView addSubview:_priceLabel2];
    UIView* view = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:5 andWidth:365 andHeight:1]];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.5;
    [self.contentView addSubview:view];
}
-(void)showAppModel:(WRCityAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath{
    /*
     UIImageView* _photoImageView;
     UILabel* _titleLabel;
     UILabel* _priceoffLabel;
     UILabel* _priceLabel;
     */
    [_photoImageView setImageWithURL:[NSURL URLWithString:appModel.New_discount[indexpath.row][@"photo"]]];
    _titleLabel.text = appModel.New_discount[indexpath.row][@"title"];
    //    _priceLabel.text = appModel.New_discount[indexpath.row][@"price"];
    NSString* string = appModel.New_discount[indexpath.row][@"price"];
    NSString* search = @"(>)(\\w+)(<)";
    NSRange range = [string rangeOfString:search options:NSRegularExpressionSearch];
    //    NSLog(@"%@",NSStringFromRange(range));
    if (range.location != NSNotFound) {
        UIApplication* application = [UIApplication sharedApplication];
        AppDelegate* delegate = application.delegate;
        _priceLabel.text = [string substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
        [_priceLabel sizeToFit];
        CGRect frame = _priceLabel.frame;
        _priceLabel2.text = @"元起";
         CGSize size = [UIScreen mainScreen].bounds.size;
        _priceLabel2.frame = [delegate createFrimeWithX:(frame.origin.x + frame.size.width + 5) * 375 /size.width andY:55 andWidth:40 andHeight:10];
        [_priceLabel2 sizeToFit];
    }
    _priceoffLabel.text = appModel.New_discount[indexpath.row][@"priceoff"];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
