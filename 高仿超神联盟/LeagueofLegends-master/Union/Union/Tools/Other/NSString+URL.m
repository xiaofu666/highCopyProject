//
//  NSString+URL.m
//  简书:http://www.jianshu.com/users/c1bb6aa0e422
//
//  Created by HarrisHan on 15/7/1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

//URL转Encoded

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8);
    return [encodedString autorelease];
}

@end
