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

/**
 *  /
 *
 *  @param url               url of image
 *  @param completionHandler return image when request is success, return NSError when error occurs
 *
 *  @return NSURLSessionDownloadTask, when imageview will load another image, if the old request is not finished, cancel it. So that there will not be image flush
 */
- (NSURLSessionDownloadTask *)fetchImageWithURL:(NSURL *)url completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;

- (void)cancelRuningTask;

// Just set it to public method for test purpose
- (id) convertToJSONWithData: (NSData *) data ifError:(NSError **) error;
@end
