//
//  DZRAlbum.m
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRAlbum.h"

@implementation DZRAlbum

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //unsigned identifier for artist
    self.albumId = [dictionary valueForKeyPath:@"id"];
    self.albumTitle = [dictionary valueForKeyPath:@"title"];
    self.albumCover = [dictionary valueForKeyPath:@"cover"];
    self.albumTrackList = [dictionary valueForKeyPath:@"tracklist"];
    
    return self;
}

@end
