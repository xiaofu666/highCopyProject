//
//  WRTwoCell.m
//  yiluxiangxi2
//
//  Created by dota2slark on 15/11/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRTwoCell.h"
#import "AppDelegate.h"


@interface WRTwoCell()
@property (nonatomic,strong) UILabel* ennameLabel;
@end
@implementation WRTwoCell

{
    UILabel* _cnnameLabel;
//    UILabel* _ennameLabel;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _cnnameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:15 andWidth:100 andHeight:44]];
    _cnnameLabel.textColor = [UIColor blackColor];
    _cnnameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_cnnameLabel];
    _ennameLabel = [[UILabel alloc]initWithFrame:[delegate createFrimeWithX:110 andY:17 andWidth:100 andHeight:44]];
    _ennameLabel.textColor = [UIColor lightGrayColor];
    _ennameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_ennameLabel];
    UIView* view = [[UIView alloc]initWithFrame:[delegate createFrimeWithX:10 andY:44 andWidth:375 + 20 andHeight:1]];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.5;
    [self.contentView addSubview:view];
}
- (void)awakeFromNib {

}
-(void)showAppModel:(WRDestinationAppModel *)appModel andIndexpath:(NSIndexPath *)indexpath{
    /*
     UILabel* _cnnameLabel;
     UILabel* _ennameLabel;
     */
    UIApplication* application = [UIApplication sharedApplication];
    AppDelegate* delegate = application.delegate;
    _cnnameLabel.text = appModel.country[indexpath.row][@"cnname"];
    [_cnnameLabel sizeToFit];
    CGRect frame = _cnnameLabel.frame;
    _ennameLabel.text = appModel.country[indexpath.row][@"enname"];
    _ennameLabel.frame = [delegate createFrimeWithX:frame.size.width + 30 andY:17 andWidth:100 andHeight:44];
    [_ennameLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
