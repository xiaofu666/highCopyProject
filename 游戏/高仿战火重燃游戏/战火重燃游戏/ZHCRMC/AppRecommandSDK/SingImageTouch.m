//
//  SingImageTouch.m
//  Doodle
//
//  Created by ran on 12-9-5.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "SingImageTouch.h"

#define MARGIN  2
@implementation SingImageTouch

@synthesize imagePath = imagepath;
@synthesize subImage;
@synthesize subImageView;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame  imagePath:(NSString *)path  image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.imagePath = path;
        self.image = [UIImage imageNamed:@"imagesquare.png"];
        
        subImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, self.frame.size.width-MARGIN*2, self.frame.size.height-MARGIN*2)];
        subImageView.userInteractionEnabled = YES;
        self.subImage = image;
        subImageView.image = self.subImage;
        [self addSubview:subImageView];
        [subImageView release];
        // Initialization code
    }

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (delegate &&
        [delegate respondsToSelector:@selector(TouchTheImageView:)])
    {
        [delegate TouchTheImageView:[NSDictionary dictionaryWithObjectsAndKeys:self.imagePath,@"PATH",subImageView.image,@"IMAGE",nil]];
        // NSLog(@"OK touch");
    }
   
    
}

@end
