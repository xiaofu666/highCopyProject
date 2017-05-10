//
//  SleeveCloseFirstCell.m
//  yiluxiangxi
//
//  Created by 唐僧 on 15/11/10.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "SleeveCloseFirstCell.h"
#import "AppDelegate.h"
@implementation SleeveCloseFirstCell

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
    //self.recImageView=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:9 andY:0 andWidth:357 andHeight:200]];  100  130
    
    UILabel* label=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:9 andY:0 andWidth:100 andHeight:30]];
    label.text=@"相关锦囊";
    label.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    [self.contentView addSubview:label];
    
    self.sleImage=[[UIImageView alloc]initWithFrame:[delegate createFrimeWithX:9 andY:40 andWidth:60 andHeight:80]];
    //self.sleImage.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.sleImage];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:79 andY:40 andWidth:200 andHeight:25]];
    //self.titleLabel.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.aireLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:79 andY:75 andWidth:100 andHeight:15]];
    //self.aireLabel.backgroundColor=[UIColor cyanColor];
    self.aireLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    self.aireLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.aireLabel];
    
    self.downlondLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:79 andY:90 andWidth:100 andHeight:15]];
    //self.downlondLabel.backgroundColor=[UIColor redColor];
    self.downlondLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    self.downlondLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.downlondLabel];
    
    self.updataLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:79 andY:115 andWidth:100 andHeight:15]];
    //self.updataLabel.backgroundColor=[UIColor grayColor];
    self.updataLabel.textColor=[UIColor colorWithWhite:0.5 alpha:1.f];
    self.updataLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.updataLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
