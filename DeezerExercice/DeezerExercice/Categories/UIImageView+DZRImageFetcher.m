//
//  UIImageView+DZRImageFetcher.m
//  DeezerExercice
//
//  Created by Ce Yang on 09/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "UIImageView+DZRImageFetcher.h"
#import "DZRImageCache.h"
#import "DZRURLSessionManager.h"

@interface UIImageView (dzr_ImageFetcher)

@end

@implementation UIImageView (DZRImageFetcher)

- (void)setImageWithURL: (NSURL *)url
            placeholder:(UIImage *)placeholder
                success:(void(^)(NSHTTPURLResponse *response, UIImage *image))success
                failure:(void(^)(NSHTTPURLResponse *response, NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //Add image only header for request
    [request addValue:@"image/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    [self cancelCurrentImageOperation];
    
    //Check if image is cached
    UIImage *cachedImage = [[DZRImageCache sharedImageCache] cacheImageForKey:[url absoluteString]];
    if (cachedImage) {
        //Image is caches, returned directly
        if (success) {
            success(nil, cachedImage);
        } else {
            self.image = cachedImage;
        }
        
    } else {
        if (placeholder) {
            self.image = placeholder;
        }
        
        [[DZRURLSessionManager sharedManager] fetchImageWithURL:url completionHandler:^(UIImage *image, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    if (success) {
                        success(nil, image);
                    } else {
                        self.image = image;
                    }
                    [[DZRImageCache sharedImageCache] cacheImage:image forRequestString:request.URL.absoluteString];
                } else if (error != nil) {
                    failure(nil, error);
                }
            });
            
        }];
    }
    
    
    
}

#pragma mark - private methods
/**
 *  to avoid multiple operation for a imageview, we cancel the current operation
 */
- (void) cancelCurrentImageOperation{
    //[[DZRURLSessionManager sharedManager]cancelRuningTask];
}
@end
