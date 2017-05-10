#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(UIImageScale)  
- (UIImage*)getSubImage:(CGRect)rect;
+ (UIImage *)createGrayCopy:(UIImage *)source;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end  