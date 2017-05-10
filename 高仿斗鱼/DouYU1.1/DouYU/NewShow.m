//
//  NewShow.m
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "NewShow.h"


@interface NewShow ()



@end

@implementation NewShow

-(id)init
{

    self=[[[NSBundle mainBundle]loadNibNamed:@"NewShow" owner:nil options:nil] firstObject];


    if (self) {
        
        self.HeadView.layer.cornerRadius=self.HeadView.frame.size.width/2;
        self.HeadView.layer.masksToBounds=YES;
        
    }
    
    return self;
}

@end
