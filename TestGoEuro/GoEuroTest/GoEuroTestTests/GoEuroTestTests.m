//
//  GoEuroTestTests.m
//  GoEuroTestTests
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURLSessionHelper.h"

@interface GoEuroTestTests : XCTestCase

@end

@implementation GoEuroTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


- (void)testAirlineService
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionHelper *help = [NSURLSessionHelper sharedHelper];
    
    NSString *urlstring = [NSString stringWithFormat:@"https://api.myjson.com/bins/w60i"];
    [help fetchDataFromURL:urlstring completion:^(NSData *data) {
        NSError* error;
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        XCTAssertNil(error, @"dataTaskWithURL error %@", error);
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
        }
        
        XCTAssert(data, @"data nil");
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, signal the semaphore
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    long rc = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC));
    XCTAssertEqual(rc, 0, @"network request timed out");
}
- (void)testBusService
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionHelper *help = [NSURLSessionHelper sharedHelper];
    
    NSString *urlstring = [NSString stringWithFormat:@"https://api.myjson.com/bins/3zmcy"];
    [help fetchDataFromURL:urlstring completion:^(NSData *data) {
        NSError* error;
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        XCTAssertNil(error, @"dataTaskWithURL error %@", error);
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
        }
        
        XCTAssert(data, @"data nil");
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, signal the semaphore
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    long rc = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC));
    XCTAssertEqual(rc, 0, @"network request timed out");
}
- (void)testTrainService
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionHelper *help = [NSURLSessionHelper sharedHelper];
    
    NSString *urlstring = [NSString stringWithFormat:@"https://api.myjson.com/bins/37yzm"];
    [help fetchDataFromURL:urlstring completion:^(NSData *data) {
        NSError* error;
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        XCTAssertNil(error, @"dataTaskWithURL error %@", error);
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
        }
        
        XCTAssert(data, @"data nil");
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, signal the semaphore
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    long rc = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC));
    XCTAssertEqual(rc, 0, @"network request timed out");
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
