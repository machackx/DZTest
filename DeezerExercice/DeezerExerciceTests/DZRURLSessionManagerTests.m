//
//  DZRURLSessionManagerTests.m
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRURLSessionManagerTests.h"

@implementation DZRURLSessionManagerTests

/**
 *  CYA: I did not do any test for async web service call, due to the requirements that no 3rd party library is allowed
 */

-(void)setUp{
    [super setUp];
    self.manager = [[DZRURLSessionManager alloc] initWithBasicConfiguration];
}

-(void)tearDown{
    [super tearDown];
    self.manager = nil;
}

-(void)testConvertToJSONWithData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SearchResult" ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];

    NSError *error = nil;
    id result = [self.manager convertToJSONWithData:jsonData ifError:&error];
    XCTAssertNotNil(result);
    XCTAssertNotNil([result objectForKey:@"data"]);
    XCTAssertEqual([[result objectForKey:@"data"] count], 25);
}


@end
