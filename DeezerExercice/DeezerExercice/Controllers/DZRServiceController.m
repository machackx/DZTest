//
//  DZRServiceController.m
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRServiceController.h"
#import "DZRURLSessionManager.h"

@implementation DZRServiceController

+(void)searchArtistWithName:(NSString *)artistName compeletion:(void (^)(NSArray *artistList, NSError *error)) block{
    NSString *requestString = [NSString stringWithFormat:@"search/artist?q=%@", artistName];
    [[DZRURLSessionManager sharedManager] GET:requestString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *artistList = [responseObject valueForKey:@"data"];
        //Parse the raw JSON data
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
