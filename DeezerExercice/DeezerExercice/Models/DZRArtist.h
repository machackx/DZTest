//
//  DZRArtist.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRArtist : NSObject

@property (nonatomic, assign) NSUInteger artistIdentifier;
@property (nonatomic, strong) NSString *artistLink;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, assign) NSInteger artistAlbumNumber;
@property (nonatomic, assign) NSInteger artistFanNumber;
@property (nonatomic, assign) NSInteger artistRadio;
@property (nonatomic, strong) NSString *artistTrackList;
@property (nonatomic, strong) NSString *artistType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
