//
//  RjfDownPicImageView.h
//  Texas-pokes
//
//  Created by ran on 12-10-23.
//
//

#import <UIKit/UIKit.h>
#import "RJFUpAndDown.h"

@interface RjfDownPicImageView : UIImageView
{
    RJFUpAndDown  *upAnddown;
}
-(void)StartDownPic:(NSString *)strName requestID:(NSInteger)request fileServer:(NSString *)fileServer port:(unsigned int)port;
@end
