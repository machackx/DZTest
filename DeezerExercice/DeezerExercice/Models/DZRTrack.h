//
//  DZRTrack.h
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRAlbum.h"

@interface DZRTrack : NSObject

@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *trackTitle;
@property (nonatomic, strong) NSString *trackLink;
@property (nonatomic, assign) NSUInteger trackDuration;
@property (nonatomic, strong) NSString *trackPreview;
@property (nonatomic, strong) DZRAlbum *trackAlbum;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
