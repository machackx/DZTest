//
//  DZRTrack.m
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRTrack.h"

@implementation DZRTrack

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //unsigned identifier for artist
    self.trackId = [dictionary valueForKeyPath:@"id"];
    self.trackTitle = [dictionary valueForKeyPath:@"title"];
    self.trackLink = [dictionary valueForKeyPath:@"link"];
    self.trackDuration = (NSUInteger)[[dictionary valueForKeyPath:@"duration"] integerValue];
    self.trackPreview = [dictionary valueForKeyPath:@"preview"];
    
    NSDictionary *album = [dictionary objectForKey:@"album"];
    self.trackAlbum = [[DZRAlbum alloc] initWithDictionary:album];
    
    return self;
}

@end
