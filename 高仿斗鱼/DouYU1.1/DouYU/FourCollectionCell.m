//
//  FourCollectionCell.m
//  DouYU
//
//  Created by admin on 15/11/1.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "FourCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface FourCollectionCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *Name;

@property (strong, nonatomic) IBOutlet UILabel *onlinePeople;

@property (strong, nonatomic) IBOutlet UILabel *Title;
@end

@implementation FourCollectionCell


-(void)setOnlineData:(OnlineModel *)onlineData
{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[onlineData.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    self.Name.text=onlineData.nickname;
    
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[onlineData.online doubleValue]/10000];
    self.Title.text=onlineData.room_name;
}

-(void)setChaneldata:(ChanelData *)chaneldata
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[chaneldata.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    self.Name.text=chaneldata.nickname;
    
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[chaneldata.online doubleValue]/10000];
    self.Title.text=chaneldata.room_name;

}
@end
