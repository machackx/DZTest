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
#import <objc/runtime.h>

@interface UIImageView (dzr_ImageFetcher)

@property (nonatomic, strong, setter=dzr_setCurrentDownloadTask:) NSURLSessionDownloadTask *dzr_currentDownloadTask;

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
        self.image = nil;
        if (self.dzr_currentDownloadTask && self.dzr_currentDownloadTask.state == NSURLSessionTaskStateRunning) {
            [self.dzr_currentDownloadTask cancel];
            self.dzr_currentDownloadTask = nil;
        }
        
        self.dzr_currentDownloadTask = [[DZRURLSessionManager sharedManager] fetchImageWithURL:url completionHandler:^(UIImage *image, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    if (success) {
                        success(nil, image);
                    } else {
                        self.image = image;
                    }
                    [[DZRImageCache sharedImageCache] cacheImage:image forRequestString:request.URL.absoluteString];
                } else if (nil != failure && error != nil) {
                    self.image = placeholder;
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
}

- (void) dzr_setCurrentDownloadTask: (NSURLSessionDownloadTask *)currentDownloadTask{
    objc_setAssociatedObject(self, @selector(dzr_currentDownloadTask), currentDownloadTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLSessionDownloadTask *)dzr_currentDownloadTask{
    return (NSURLSessionDownloadTask *)objc_getAssociatedObject(self, @selector(dzr_currentDownloadTask));
}
@end
