//
//  LHHeaderView.m
//  biUp
//
//  Created by snowimba on 15/12/24.
//  Copyright © 2015年 snowimba. All rights reserved.
//

#import "LHHeaderView.h"

@implementation LHHeaderView


- (IBAction)seleVidoe:(UIButton *)sender {
    
    if (self.btnClcike) {
        self.btnClcike();
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)headerView{
    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LHHeaderView" owner:nil options:nil] lastObject];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com