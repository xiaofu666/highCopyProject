//
//  NSString+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSURL* )url;
- (NSURL* )fileURL;

+ (NSString*)stringWithFileSize:(long long)size;

//00:00:00
+ (NSString* )fullStringWithSeconds:(int)seconds;

//12:12
+ (NSString* )stringWithSeconds:(int)seconds;

- (NSString *)sha1;
@end
