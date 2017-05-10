//
//  BaseService.m
//  IntelliCommunity
//
//  Created by Diana on 12/15/14.
//  Copyright (c) 2014 evideo. All rights reserved.
//

#import "BaseService.h"
#import <objc/runtime.h>

@implementation BaseService

+ (ServiceLevel)level {
    return ServiceLevelLow;
}

+ (NSArray *) allSubclasses {
    static NSMutableArray *mySubclasses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class myClass = [self class];
        mySubclasses = [NSMutableArray array];
        unsigned int numOfClasses;
        Class *classes = objc_copyClassList(&numOfClasses);
        for (unsigned int ci = 0; ci < numOfClasses; ci++) {
            Class superClass = classes[ci];
            do {
                superClass = class_getSuperclass(superClass);
            } while (superClass && superClass != myClass);
            
            if (superClass)
                [mySubclasses addObject: classes[ci]];
        }
        free(classes);
    });
    
    return mySubclasses;
}

- (id)initWithServiceCenter:(ServiceCenter*)serviceCenter {
    self = [super init];
    if (self) {
        self.serviceCenter = serviceCenter;
    }
    return self;
}

- (void)start {
    //启动服务，子类实现
}

- (void)stop {
    //停止服务，子类实现
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    //app跳转，子类实现
    return NO;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    //app跳转带参数，子类实现
    return NO;
}
@end
