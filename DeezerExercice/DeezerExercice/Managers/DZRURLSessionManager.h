//
//  DZRURLSessionManager.h
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface DZRURLSessionManager : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate>

typedef void (^DZRURLSessionTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);

@property (nonatomic, strong, readonly) NSURLSession *session;

// We use operation queue to manager multiple requests and their callbacks
@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

+ (instancetype)sharedManager;
- (instancetype)initWithBasicConfiguration NS_DESIGNATED_INITIALIZER;

// Get method for retrive the web service
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// Get images
- (void)fetchImageWithURL:(NSURL *)url completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;

- (void)cancelRuningTask;
@end
