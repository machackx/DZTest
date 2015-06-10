//
//  DZRImageCache.m
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRImageCache.h"

@implementation DZRImageCache

+(DZRImageCache *)sharedImageCache{
    static DZRImageCache *_dzrImageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dzrImageCache = [[DZRImageCache alloc] init];
        
        //Add notification when received memory warning
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [_dzrImageCache removeAllObjects];
        }];
        
    });
    return _dzrImageCache;
}

- (UIImage *)cacheImageForKey: (NSString *)requestString{
    return [self objectForKey:requestString];
}

- (void)cacheImage:(UIImage *)image forRequestString: (NSString *)requestString;
{
    if (image && requestString) {
        [self setObject:image forKey:requestString];
    }
}

@end
