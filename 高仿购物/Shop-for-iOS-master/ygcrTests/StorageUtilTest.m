//
//  StorageUtilTest.m
//  ygcr
//
//  Created by tony on 16/3/13.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StorageUtil.h"

@interface StorageUtilTest : XCTestCase

@end

@implementation StorageUtilTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    [StorageUtil saveUserId:@"123456"];
    NSString *userId = [StorageUtil getUserId];
    XCTAssertTrue(([userId isEqualToString:@"123456"]));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
