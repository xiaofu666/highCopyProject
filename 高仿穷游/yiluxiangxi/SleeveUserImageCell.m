//
//  SleeveUserImageCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/6.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveUserImageCell.h"
#import "AppDelegate.h"
@implementation SleeveUserImageCell

- (void)awakeFromNib {
    // Initialization code
}
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
    //self.recImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:9 andY:0 andWidth:357 andHeight:200]];  100
    self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:9 andY:0 andWidth:100 andHeight:40]];
    //self.titleLabel.backgroundColor=[UIColor blueColor];
    self.titleLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.userImage=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:9 andY:40 andWidth:35 andHeight:35]];
    //self.userImage.backgroundColor=[UIColor purpleColor];
    self.userImage.layer.cornerRadius=35/2.f;
    self.userImage.layer.masksToBounds=YES;
    [self.contentView addSubview:self.userImage];
    
    self.userLaber=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:54 andY:40 andWidth:120 andHeight:15]];
    //self.userLaber.backgroundColor=[UIColor orangeColor];
    self.userLaber.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.userLaber];
    
    self.detailText=[[UITextView alloc]initWithFrame:[delegate createFrimeWithX:9 andY:80 andWidth:357 andHeight:110]];
    //self.detailText.backgroundColor=[UIColor redColor];
    self.detailText.editable=NO;
    self.detailText.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    [self.contentView addSubview:self.detailText];
    
    //self.contentView.backgroundColor=[UIColor yellowColor];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
