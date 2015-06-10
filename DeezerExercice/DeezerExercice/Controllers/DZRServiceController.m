//
//  DZRServiceController.m
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRServiceController.h"
#import "DZRURLSessionManager.h"
#import "DZRArtist.h"

@implementation DZRServiceController

+(void)searchArtistWithName:(NSString *)artistName compeletion:(void (^)(NSArray *artistList, NSError *error)) compeletion{
    NSString *requestString = [NSString stringWithFormat:@"search/artist?q=%@", artistName];
    //If user type quickly, we will have a lot of queries in the queue, we need to exacuted only one query at one time
    [[DZRURLSessionManager sharedManager] cancelRuningTask];
    [[DZRURLSessionManager sharedManager] GET:requestString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *artistList = [NSMutableArray new];
        NSArray *artistDictionary = [responseObject valueForKey:@"data"];
        //Parse the raw JSON data
        for (NSDictionary *artists in artistDictionary) {
            DZRArtist *artist = [[DZRArtist alloc] initWithDictionary:artists];
            [artistList addObject:artist];
        }
        
        if (nil != compeletion) {
            compeletion([artistList copy], nil);
        } else {
            compeletion(nil, [NSError errorWithDomain:@"DZR Parse Error" code:10000 userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        compeletion(nil, [NSError errorWithDomain:@"DZR Web service Error" code:10001 userInfo:nil]);
    }];
}

@end
