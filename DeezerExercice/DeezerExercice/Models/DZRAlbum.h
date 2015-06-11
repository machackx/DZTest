//
//  DZRAlbum.h
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRAlbum : NSObject

@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *albumCover;
@property (nonatomic, strong) NSString *albumTrackList;
@property (nonatomic, strong) NSString *albumType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
