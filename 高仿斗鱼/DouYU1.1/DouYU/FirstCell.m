//
//  FirstCell.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "FirstCell.h"

@interface FirstCell ()
@property (strong, nonatomic) IBOutlet UIImageView *HeadView;

@end

@implementation FirstCell

+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *identfire=@"FirstCell";
    
    FirstCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FirstCell" owner:nil options:nil] firstObject];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.HeadView.layer.cornerRadius=65/2;
        cell.HeadView.layer.masksToBounds=YES;
    }
    
    return cell;
}


@end
