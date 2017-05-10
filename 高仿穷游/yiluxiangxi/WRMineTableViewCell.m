//
//  WRMineTableViewCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/10.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRMineTableViewCell.h"
#import "AppDelegate.h"
@implementation WRMineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//40

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    UIApplication* application=[UIApplication sharedApplication];
    AppDelegate* delegate=application.delegate;
    self.labelTitle=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:29 andY:0 andWidth:150 andHeight:40]];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelDetail=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:self.frame.size.width-80 andY:0 andWidth:150 andHeight:40]];
    self.labelDetail.font=[UIFont systemFontOfSize:13];
    self.labelDetail.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    [self.contentView addSubview:self.labelDetail];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
