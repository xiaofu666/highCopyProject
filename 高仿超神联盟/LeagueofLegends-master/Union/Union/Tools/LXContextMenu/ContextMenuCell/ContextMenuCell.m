//
//  LXSideMenuCell.m
//  LXMenuAnimation
//
//  Created by HarrisHan on 15/8/4.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ContextMenuCell.h"

@interface ContextMenuCell ()

@end

@implementation ContextMenuCell

-(void)dealloc{
    
    [_menuTitleLabel release];
    
    [_menuImageView release];
    
    [super dealloc];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.layer.masksToBounds = YES;
    
    self.layer.shadowOffset = CGSizeMake(0, 2);
    
    self.layer.shadowColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    
    self.layer.shadowRadius = 5;
    
    self.layer.shadowOpacity = 0.5;
    
    self.tintColor = MAINCOLOER;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    

        
    }
    
    return self;
}

#pragma mark - LXContextMenuCell

- (UIView*)animatedIcon {
   
    return self.menuImageView;

}

- (UIView *)animatedContent {
    
    return self.menuTitleLabel;

}

@end
