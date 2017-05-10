//
//  WRCityOneCell.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/9.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCityOneCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation WRCityOneCell
{
    UILabel* _oneCellLabel;
    UIImageView* _photoView;
    UILabel* _titleLabel;
    UILabel* _priceLabel1;
    UILabel* _priceLabel2;
    UILabel* _priceoffLabel;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 375, 667);
    }
    return self;

}
-(void)createCell{
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _oneCellLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:10 andWidth:100 andHeight:40]];
    _oneCellLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_oneCellLabel];
    for (int i = 0; i < self.imageArrCount; i ++) {
        _photoView = [[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:10 + i % 2 * (172.5 + 10) andY:70 + i / 2 * (180 + 10) andWidth:172.5 andHeight:100]];
        _photoView.backgroundColor = [UIColor lightGrayColor];
        _photoView.tag = 10 + i;
        [self.contentView addSubview:_photoView];
        UIControl* control = [[UIControl alloc]initWithFrame:[delegate createFrimeWithX:10 + i % 2 * (172.5 + 10) andY:70 + i / 2 * (180 + 10) andWidth:172.5 andHeight:185]];
        control.tag = 60 + i;
        [control addTarget:self action:@selector(pressCtr:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:control];
        UIView* view = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:60 andWidth:365 andHeight:1]];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.3;
        [self.contentView addSubview:view];
        _titleLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 + i % 2 * (172.5 + 10) andY:170 + i / 2 * (180 + 10) andWidth:172.5 andHeight:50]];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        _titleLabel.tag = 20 + i;
        [self.contentView addSubview:_titleLabel];
        _priceoffLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 + i % 2 * (172.5 + 10) andY:230 + i / 2 * (180 + 10) andWidth:100 andHeight:20]];
        _priceoffLabel.textColor = [UIColor lightGrayColor];
        _priceoffLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_priceoffLabel];
        _priceoffLabel.tag = 30 + i;
        _priceLabel1 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:120 + i % 2 * (172.5 + 10) andY: 230 + i / 2 * (180 + 10) andWidth:30 andHeight:20]];
        _priceLabel1.textColor = [UIColor redColor];
        _priceLabel1.tag = 40 + i;
        _priceLabel2 = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:150 + i % 2 * (172.5 + 10) andY: 235 + i / 2 * (180 + 10) andWidth:30 andHeight:20]];
        _priceLabel2.textColor = [UIColor redColor];
        _priceLabel2.font = [UIFont systemFontOfSize:13];
        _priceLabel2.tag = 50 + i;
        UIView* view1 = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:255 andWidth:365 andHeight:1]];
        view1.backgroundColor = [UIColor lightGrayColor];
        view1.alpha = 0.3;
        UIView* view2 = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:187.5 andY:70 andWidth:1 andHeight:380]];
        view2.backgroundColor = [UIColor lightGrayColor];
        view2.alpha = 0.3;
        [self.contentView addSubview:view2];
        [self.contentView addSubview:view1];
        [self.contentView addSubview:_priceLabel1];
        [self.contentView addSubview:_priceLabel2];
    }
}
-(void)pressCtr:(id)sender{
    UIControl* control = (UIControl*)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendControl:)]) {
        [self.delegate sendControl:control];
    }else {
        NSLog(@"没有代理或未实现协议方法");
    }

}
-(void)showAppModel:(WRCityAppModel *)appModel andIndexpath:(NSIndexPath*) indexpath{
    /*
     UILabel* _oneCellLabel;
     UIImageView* _photoView;
     UILabel* _titleLabel;
     UILabel* _priceLabel;
     UILabel* _priceoffLabel;
     */
    NSArray *array = self.contentView.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
    [self createCell];
    _oneCellLabel.text = @"精彩当地游";
    for (int i = 0; i < [appModel.local_discount count];i ++){
        UIImageView* imageView = (UIImageView*)[self viewWithTag:10 + i];
        UILabel* titleLabel = (UILabel*)[self viewWithTag:20 + i];
        UILabel* priceoffLabel = (UILabel*)[self viewWithTag:30 + i];
        UILabel* priceLabel = (UILabel*)[self viewWithTag:40 + i];
        UILabel* priceLabel2 = (UILabel*)[self viewWithTag:50 + i];
        NSString* string = appModel.local_discount[i][@"photo"];
        [imageView setImageWithURL:[NSURL URLWithString:string]];
        titleLabel.text = appModel.local_discount[i][@"title"];
        priceoffLabel.text = appModel.local_discount[i][@"priceoff"];
        
        
        NSString* string1 = appModel.local_discount[i][@"price"];
        NSString* search = @"(>)(\\w+)(<)";
        NSRange range = [string1 rangeOfString:search options:NSRegularExpressionSearch];
        //    NSLog(@"%@",NSStringFromRange(range));
        if (range.location != NSNotFound) {
            UIApplication* application = [UIApplication sharedApplication];
            AppDelegate* delegate = application.delegate;
            priceLabel.text = [string1 substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
            [priceLabel sizeToFit];
            CGRect frame = priceLabel.frame;
            priceLabel2.text = @"元起";
            CGSize size = [UIScreen mainScreen].bounds.size;
            priceLabel2.frame = [delegate createFrimeWithX:(frame.origin.x + frame.size.width + 5) * 375 /size.width andY:232.5 + i / 2 * (180 + 10) andWidth:30 andHeight:20];
            
            [priceLabel2 sizeToFit];
        }
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
