//
//  DZRArtist.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRArtist : NSObject

@property (nonatomic, assign) NSString *artistIdentifier;
@property (nonatomic, strong) NSString *artistLink;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, assign) NSUInteger artistAlbumNumber;
@property (nonatomic, assign) NSUInteger artistFanNumber;
@property (nonatomic, strong) NSString *artistPictureUrl;
@property (nonatomic, assign) NSInteger artistRadio;
@property (nonatomic, strong) NSString *artistTrackList;
@property (nonatomic, strong) NSString *artistType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
