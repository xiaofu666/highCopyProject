//
//  RjfDownPicImageView.m
//  Texas-pokes
//
//  Created by ran on 12-10-23.
//
//

#import "RjfDownPicImageView.h"
#import "publicDefine.h"


@implementation RjfDownPicImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

-(void)StartDownPic:(NSString *)strName requestID:(NSInteger)request fileServer:(NSString *)fileServer port:(unsigned int)port
{
    UIImage  *image = [RJFUpAndDown getLocalImage:strName];
    if (image != nil)
    {
        self.image = image;
    }else
    {
       
        upAnddown = [[RJFUpAndDown alloc] initWithHost:fileServer
                                                             Port:port
                                                         Delagate:self
                                                              tag:0];
        [upAnddown setDelegate:self];
        [upAnddown SendDownRequest:strName requestID:request];
    }
    
}

-(void)DownLoadSuOrFail:(UIImage *)image ISSuc:(BOOL)bSUc
{
    self.image = image;
    [upAnddown release];
    upAnddown = nil;
}
@end
