//
//  UIImageView+DZRImageFetcher.h
//  DeezerExercice
//
//  Created by Ce Yang on 09/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DZRImageFetcher)

- (void)setImageWithURL: (NSURL *)url
            placeholder:(UIImage *)placeholder
                success:(void(^)(NSHTTPURLResponse *response))success
                failure:(void(^)(NSHTTPURLResponse *response))failure;

@end
