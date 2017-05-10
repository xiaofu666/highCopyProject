//
//  SmartbiAdaFindTableViewCell.h
//  SmartbiAdaConnotationAppa
//
//  Created by 蒋宝 on 16/4/20.
//  Copyright © 2016年 SMARTBI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartbiAdaFind.h"

@interface SmartbiAdaFindTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (weak, nonatomic) IBOutlet UILabel *subscribe;
@property (weak, nonatomic) IBOutlet UILabel *total;



//@property (nonatomic,strong)NSString *icon;     //头像
//@property (nonatomic,strong)NSString *name;    //
//@property (nonatomic,strong)NSString *intro;      //介绍
//@property (nonatomic,strong)NSString *subscribe_count;   //订阅数
//@property (nonatomic,strong)NSString *total_updates;     //总帖数


-(void)refreshUI:(SmartbiAdaFind *)FindModel;
@end
