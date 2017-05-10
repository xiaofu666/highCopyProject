//
//  TanLableCell.m
//  DouYU
//
//  Created by Alesary on 15/11/5.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "TanLableCell.h"

@implementation TanLableCell

+(instancetype)GetCellWithTableView:(UITableView *)tableView
{
    static NSString *TCell=@"TanLableCell";
    
    TanLableCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TanLableCell" owner:nil options:nil] firstObject];
        
    }
    
    return cell;
}
@end
