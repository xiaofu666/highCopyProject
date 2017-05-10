#import "UIImge-GetSubImage.h"

@implementation UIImage(UIImageScale)  

//截取部分图像  
-(UIImage*)getSubImage:(CGRect)rect  
{  
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);  
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));  
	
    UIGraphicsBeginImageContext(smallBounds.size);  
    CGContextRef context = UIGraphicsGetCurrentContext();  
    CGContextDrawImage(context, smallBounds, subImageRef);  
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];  
    UIGraphicsEndImageContext(); 
    CGImageRelease(subImageRef);
	
    return smallImage;  
}

+ (UIImage *)createGrayCopy:(UIImage *)source
{
	int width = source.size.width;
	int height = source.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	
	CGContextRef context = CGBitmapContextCreate (nil,
												  width,
												  height,
												  8,      // bits per component
												  0,
												  colorSpace,
												  kCGImageAlphaNone);
	
	CGColorSpaceRelease(colorSpace);
	
	if (context == NULL) {
		return nil;
	}
	
	CGContextDrawImage(context,
					   CGRectMake(0, 0, width, height), source.CGImage);
	
    CGImageRef img = CGBitmapContextCreateImage(context);
	UIImage *grayImage = [UIImage imageWithCGImage:img];
	CGContextRelease(context);
    CGImageRelease(img);
    
	return grayImage;
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;      
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }      
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
#ifdef DEBUG_VERSION
        NSLog(@"could not scale image");
#endif
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end