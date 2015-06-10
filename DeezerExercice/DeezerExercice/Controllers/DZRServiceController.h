//
//  DZRServiceController.h
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRServiceController : NSObject

+(void)searchArtistWithQuery:(NSString *)query compeletion:(void (^)(id responseObject, NSError *error)) compeletion;
+(void)searchArtistWithName:(NSString *)artistName compeletion:(void (^)(id responseObject, NSError *error)) block;
+(void)searchArtistWithName:(NSString *)artistName index:(NSUInteger)index compeletion:(void (^)(id responseObject, NSError *error)) block;

@end
