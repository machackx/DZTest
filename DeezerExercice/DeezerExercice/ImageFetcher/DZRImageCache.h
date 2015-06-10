//
//  DZRImageCache.h
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  Singleton class
 */
@interface DZRImageCache : NSCache

+(DZRImageCache *)sharedImageCache;

- (UIImage *)cacheImageForKey: (NSString *)requestString;
- (void)cacheImage:(UIImage *)image forRequestString: (NSString *)requestString;

@end
