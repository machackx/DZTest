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

+(void)searchArtistWithName:(NSString *)artistName index:(NSUInteger)index completion:(void (^)(id responseObject, NSError *error)) completion;{
    NSString *query = [NSString stringWithFormat:@"search/artist?q=%@&index=%li", artistName, index];
    [self searchArtistWithQuery:query completion:completion];
}

+(void)searchArtistWithName:(NSString *)artistName completion:(void (^)(id responseObject, NSError *error)) completion{
    [self searchArtistWithQuery:[NSString stringWithFormat:@"search/artist?q=%@", artistName] completion:completion];
}

+ (void)searchArtistWithQuery:(NSString *)query completion:(void (^)(id responseObject, NSError *error)) completion;
{
    //If user type quickly, we will have a lot of queries in the queue, we need to exacuted only one query at one time
    [[DZRURLSessionManager sharedManager] cancelRuningTask];
    [[DZRURLSessionManager sharedManager] GET:query parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (nil != completion) {
            completion([responseObject copy], nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"DZR Parse Error" code:10000 userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, [NSError errorWithDomain:@"DZR Web service Error" code:10001 userInfo:nil]);
    }];
}

#pragma mark - top track method
+(void)fetchTopTrackListWithArtistId: (NSString *)identifier
                              number:(NSUInteger)number
                          completion:(void(^)(id responseObject, NSError *error)) completion;{
    NSString *query = [NSString stringWithFormat:@"artist/%@/top?limit=%li", identifier, number];
    [[DZRURLSessionManager sharedManager] cancelRuningTask];
    [[DZRURLSessionManager sharedManager] GET:query parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (nil != completion) {
            completion([responseObject copy], nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"DZR Parse Error" code:10000 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, [NSError errorWithDomain:@"DZR Web service Error" code:10001 userInfo:nil]);
    }];
}
@end
