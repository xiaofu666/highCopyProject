//
//  NSLocalization.m
//  weiju-ios
//
//  Created by StarNet on 10/13/15.
//  Copyright © 2015 evideo. All rights reserved.
//

#import "NSLocalization.h"

@interface NSLocalization ()

@property (nonatomic, strong) NSBundle* bundle;

@end

NSString* const LocalizationBase = @"Base";
NSString* const LocalizationChinese = @"zh-Hans";
NSString* const LocalizationEnglish = @"en";

@implementation NSLocalization

+ (instancetype)defaultLocalization {
    static NSLocalization* localization;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localization = [[NSLocalization alloc] init];
        
    });
    return localization;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.localization = LocalizationBase;
}

- (void)setLocalization:(NSString *)localization {
    _localization = localization;
    NSString* path = [[ NSBundle mainBundle ] pathForResource:localization ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
}

- (NSString* )localizedStringForKey:(NSString* )key {
    return [_bundle localizedStringForKey:key value:nil table:nil];
}
@end
