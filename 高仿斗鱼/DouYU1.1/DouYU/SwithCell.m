//
//  SwithCell.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "SwithCell.h"

@implementation SwithCell

+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
  
    static NSString *swithCell=@"SwithCell";
    
    SwithCell *cell=[tableView dequeueReusableCellWithIdentifier:swithCell];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SwithCell" owner:nil options:nil] firstObject];
        
    }
    
    return cell;
}


@end
