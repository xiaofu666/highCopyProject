//
//  NSURL+Extension.h
//  YueduFM
//
//  Created by StarNet on 9/20/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface NSURL (Extension) <DOUAudioFile>

- (NSURL *)audioFileURL;

@end
