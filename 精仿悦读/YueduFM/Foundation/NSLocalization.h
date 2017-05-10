//
//  NSLocalization.h
//  weiju-ios
//
//  Created by StarNet on 10/13/15.
//  Copyright © 2015 evideo. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LOC(__key) [[NSLocalization defaultLocalization] localizedStringForKey:__key]

extern NSString* const LocalizationChinese;
extern NSString* const LocalizationEnglish;

@interface NSLocalization : NSObject

+ (instancetype)defaultLocalization;

@property (nonatomic, strong) NSString* localization;

- (NSString* )localizedStringForKey:(NSString* )key;

@end
