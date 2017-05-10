//
//  WRCommunityHuiDaCell.m
//  yiluxiangxi
//
//  Created by Spark on 15/11/5.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "WRCommunityHuiDaCell.h"
#import "AppDelegate.h"
@implementation WRCommunityHuiDaCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIApplication *application=[UIApplication sharedApplication];
        AppDelegate *delegate=application.delegate;
        self.titleLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:15 andWidth:345 andHeight:20 ]];
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines=0;
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:10 andY:40 andWidth:345 andHeight:30]];
        //self.detailLabel.backgroundColor=[UIColor redColor];
        self.detailLabel.font=[UIFont systemFontOfSize:11];
        self.detailLabel.numberOfLines=0;
        [self.contentView addSubview:self.detailLabel];
        
        self.dataLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:15 andY:70 andWidth:150 andHeight:20]];
        self.dataLabel.font=[UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.dataLabel];
        
        UILabel *readLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:210 andY:70 andWidth:30 andHeight:20]];
        readLabel.text=@"同问";
        readLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:readLabel];
        
        UILabel *commenLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:290 andY:70 andWidth:30 andHeight:20]];
        commenLabel.text=@"回答";
        commenLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:commenLabel];
        
        self.readLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:250 andY:70 andWidth:40 andHeight:20]];
        self.ReadLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.ReadLabel];
        
        self.commenLabel=[[UILabel alloc]initWithFrame:[delegate createFrimeWithX:330 andY:70 andWidth:30 andHeight:20]];
        self.commenLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.commenLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
