//
//  UserEntityTest.m
//  ygcr
//
//  Created by tony on 16/3/13.
//  Copyright © 2016年 黄治华. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserEntity.h"

@interface UserEntityTest : XCTestCase

@end

@implementation UserEntityTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    UserEntity *user = [[UserEntity alloc] init];
    user.name = @"Tony";
    XCTAssertTrue([user.name isEqualToString:@"Tony"]);
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"id123",         @"id",
                          @"15889639895",   @"mobile", nil];
    UserEntity *user1 = [[UserEntity alloc] initWithDictionary:info];
    XCTAssertTrue([user1.id isEqualToString:@"id123"]);
    XCTAssertTrue([user1.mobile isEqualToString:@"15889639895"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
