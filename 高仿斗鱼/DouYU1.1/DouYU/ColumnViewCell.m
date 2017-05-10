//
//  ColumnViewCell.m
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "ColumnViewCell.h"
#import "UIImageView+WebCache.h"

@interface ColumnViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *title;
@end

@implementation ColumnViewCell

-(void)setContentWith:(ColumnModel *)model
{


    [self.image sd_setImageWithURL:[NSURL URLWithString:[model.game_icon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Image_no_data.png"]];
    self.title.text=model.game_name;
    
}
@end
