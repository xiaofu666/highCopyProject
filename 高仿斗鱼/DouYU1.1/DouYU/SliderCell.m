//
//  SliderCell.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "SliderCell.h"

@implementation SliderCell

+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    
    static NSString *sliderCell=@"SliderCell";
    
    SliderCell *cell=[tableView dequeueReusableCellWithIdentifier:sliderCell];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SliderCell" owner:nil options:nil] firstObject];
        
    }
    
    return cell;
}

@end
