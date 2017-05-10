//
//  UIImageToDataTransformer.m
//  QQ
//
//  Created by weida on 16/1/22.
//  Copyright © 2016年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "UIImageToDataTransformer.h"
#import "UIImage+Utils.h"

@implementation UIImageToDataTransformer

+(BOOL)allowsReverseTransformation
{
    return YES;
}

+(Class)transformedValueClass
{
    return [NSData class];
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    return [[UIImage alloc]initWithData:value];
}

@end
