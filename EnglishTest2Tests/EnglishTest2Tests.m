//
//  EnglishTest2Tests.m
//  EnglishTest2Tests
//
//  Created by 中山　貴仁 on 2014/11/22.
//  Copyright (c) 2014年 Nakayama Takahito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface EnglishTest2Tests : XCTestCase

@end

@implementation EnglishTest2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
