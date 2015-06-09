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
    self.artistIdentifier = (NSUInteger)[[dictionary valueForKeyPath:@"id"] integerValue];
    self.artistLink = [dictionary valueForKeyPath:@"link"];
    
    return self;
}
@end
