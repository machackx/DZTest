//
//  DZRServiceController.h
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRServiceController : NSObject

// Search
+(void)searchArtistWithQuery:(NSString *)query completion:(void (^)(id responseObject, NSError *error)) compeletion;
+(void)searchArtistWithName:(NSString *)artistName completion:(void (^)(id responseObject, NSError *error)) block;
+(void)searchArtistWithName:(NSString *)artistName index:(NSUInteger)index completion:(void (^)(id responseObject, NSError *error)) block;

// Top trackList
+(void)fetchTopTrackListWithArtistId: (NSString *)identifier number:(NSUInteger)number completion:(void(^)(id responseObject, NSError *error)) completion;
@end
