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

+(void)searchArtistWithName:(NSString *)artistName index:(NSUInteger)index compeletion:(void (^)(id responseObject, NSError *error)) compeletion;{
    NSString *query = [NSString stringWithFormat:@"search/artist?q=%@&index=%li", artistName, index];
    [self searchArtistWithQuery:query compeletion:compeletion];
}

+(void)searchArtistWithName:(NSString *)artistName compeletion:(void (^)(id responseObject, NSError *error)) compeletion{
    [self searchArtistWithQuery:[NSString stringWithFormat:@"search/artist?q=%@", artistName] compeletion:compeletion];
}

+ (void)searchArtistWithQuery:(NSString *)query compeletion:(void (^)(id responseObject, NSError *error)) compeletion;
{
    //If user type quickly, we will have a lot of queries in the queue, we need to exacuted only one query at one time
    [[DZRURLSessionManager sharedManager] cancelRuningTask];
    [[DZRURLSessionManager sharedManager] GET:query parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (nil != compeletion) {
            compeletion([responseObject copy], nil);
        } else {
            compeletion(nil, [NSError errorWithDomain:@"DZR Parse Error" code:10000 userInfo:nil]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        compeletion(nil, [NSError errorWithDomain:@"DZR Web service Error" code:10001 userInfo:nil]);
    }];
}

@end
