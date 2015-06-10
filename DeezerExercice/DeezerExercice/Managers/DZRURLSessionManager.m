//
//  DZRURLSessionManager.m
//  DeezerExercice
//
//  Created by Ce Yang on 30/05/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRURLSessionManager.h"

// CYA: As deployment target is iOS 7 and later, we use NSURLSession instead of NSURLConnection
// To benefit its advantage over NSURLConnection: the ability to configure per-session cache, protocol, cookie, and credential policies,

static NSString * const DZRAPIBaseURL = @"http://api.deezer.com/";


//Serial queue: inspired by AFNetworking
static dispatch_queue_t url_session_manager_creation_queue(){
    static dispatch_queue_t dz_url_session_manager_creation_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dz_url_session_manager_creation_queue = dispatch_queue_create("com.deezer.networking", DISPATCH_QUEUE_SERIAL);
    });
    return dz_url_session_manager_creation_queue;
}

@interface DZRURLSessionManager ()

@property (nonatomic, strong, readwrite) NSURLSession *session;
@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;
@property (nonatomic, strong, readwrite) NSURL *baseURL;
@property (nonatomic, strong, readwrite) NSMutableDictionary *taskDelegateDictionary;

@end

@implementation DZRURLSessionManager

+(instancetype)sharedManager {
    static DZRURLSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DZRURLSessionManager alloc] initWithBasicConfiguration];
    });
    return _sharedManager;
}

-(instancetype)initWithBasicConfiguration{
    if (self = [super init]) {
        self.operationQueue = [NSOperationQueue new];
        self.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
        
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:self.operationQueue];
        self.baseURL = [NSURL URLWithString:DZRAPIBaseURL];
        self.taskDelegateDictionary = [NSMutableDictionary dictionary];
        
        return self;
    } else {
        return nil;
    }
    
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // Init URLRequest
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URLString relativeToURL:self.baseURL]];
    
    __block NSURLSessionDataTask *dataTask = nil;
    
    dispatch_sync(url_session_manager_creation_queue(), ^{
        dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                if (success) {
                    NSError *serializeError = nil;
                    id responseObject = [self convertToJSONWithData:data ifError:&serializeError];
                    if (responseObject && nil == serializeError) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            success(dataTask, responseObject);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failure(nil, serializeError);
                        });
                    }
                } else {
                    if (failure) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failure(nil, error);
                        });
                    }
                }
            }
        }];
    });
    
    [dataTask resume];
    
    return dataTask;
}

-(NSURLSessionDownloadTask *)fetchImageWithURL:(NSURL *)url completionHandler:(void (^)(UIImage *, NSError *))completionHandler{
    NSURLSessionDownloadTask *downloadImageTask = [self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        if (downloadedImage) {
            completionHandler(downloadedImage, nil);
        } else{
            completionHandler(nil, [NSError errorWithDomain:NSURLErrorDomain code:10002 userInfo:nil]);
        }
    }];
    [downloadImageTask resume];
    return downloadImageTask;
}

- (void) cancelRuningTask {
    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        //Cancel all runing task
        for (NSURLSessionDataTask *task in dataTasks) {
            if (task.state == NSURLSessionTaskStateRunning) {
                [task cancel];
            }
        }
    }];

}

#pragma mark - private methods
/**
 *  Simple JSON Serialize method
 */
- (id) convertToJSONWithData: (NSData *) data
                     ifError:(NSError **) error{
    id responseObject = nil;
    error = nil;
    if (data) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (responseString && ![responseString isEqualToString:@" "]){
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            if (data) {
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
            } else {
                return nil;
            }
        }else {
            return nil;
        }
        return responseObject;
    } else {
        return nil;
    }
}

@end

