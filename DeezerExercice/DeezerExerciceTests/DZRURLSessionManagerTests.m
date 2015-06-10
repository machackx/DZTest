//
//  DZRURLSessionManagerTests.m
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRURLSessionManagerTests.h"

@implementation DZRURLSessionManagerTests

-(void)setUp{
    [super setUp];
    self.manager = [[DZRURLSessionManager alloc] initWithBasicConfiguration];
}

-(void)tearDown{
    [super tearDown];
    self.manager = nil;
}

-(void)testConvertToJSONWithData{
    NSData *jsonData = [NSData dataWithContentsOfFile:@"searchRawResult.strings"];
}

@end
