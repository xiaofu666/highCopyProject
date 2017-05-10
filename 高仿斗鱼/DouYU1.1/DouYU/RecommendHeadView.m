//
//  RecommendHeadView.m
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "RecommendHeadView.h"

@interface RecommendHeadView ()



@property (strong, nonatomic) IBOutlet UIImageView *LineView;

@end

@implementation RecommendHeadView

-(id)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHeadView" owner:nil options:nil] firstObject];
    
    if (self) {
        
       self.LineView.layer.cornerRadius=5;
       self.LineView.layer.masksToBounds=YES;
        self.Title.text=@"新秀推荐";
        
    }
    
    return self;
}

@end
