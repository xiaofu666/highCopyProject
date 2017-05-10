//
//  NSFileManager+Extension.h
//  YueduFM
//
//  Created by StarNet on 10/12/15.
//  Copyright © 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extension)

- (long long)fileSizeAtPath:(NSString*)path;

@end
