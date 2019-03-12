//
//  MyPracticeViewControllerTests.m
//  MyPracticeViewControllerTests
//
//  Created by 杨飞 on 16/9/9.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MyPracticeViewControllerTests : XCTestCase

@end

@implementation MyPracticeViewControllerTests

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
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    int  a= 3;
//    XCTAssertTrue(a == 0,"a 不能等于 0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i<100; i++) {

            NSLog(@"dd");
        }
    }];
}

@end
