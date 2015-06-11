//
//  DZRArtist.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtist.h"

@implementation DZRArtist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) {
        return nil;
    }
    //unsigned identifier for artist
    self.artistIdentifier = [dictionary valueForKeyPath:@"id"];
    self.artistLink = [dictionary valueForKeyPath:@"link"];
    self.artistName = [dictionary valueForKeyPath:@"name"];
    self.artistAlbumNumber = (NSUInteger)[[dictionary valueForKeyPath:@"nb_album"] integerValue];
    self.artistFanNumber =(NSUInteger)[[dictionary valueForKeyPath:@"nb_fan"] integerValue];
    self.artistPictureUrl = [dictionary valueForKeyPath:@"picture"];
    self.artistRadio = [[dictionary valueForKeyPath:@"radio"] integerValue];
    self.artistTrackList = [dictionary valueForKeyPath:@"tracklist"];
    self.artistType = [dictionary valueForKeyPath:@"type"];
    
    return self;
}
@end
