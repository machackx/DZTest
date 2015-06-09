//
//  DZRServiceController.h
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRServiceController : NSObject

+(void)searchArtistWithName:(NSString *)artistName compeletion:(void (^)(NSArray *artists, NSError *error)) block;
@end
