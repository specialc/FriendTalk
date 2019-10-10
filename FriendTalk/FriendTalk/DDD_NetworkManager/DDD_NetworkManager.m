//
//  DDD_NetworkManager.m
//  FriendTalk
//
//  Created by LYH on 2018/7/24.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_NetworkManager.h"
#import "DDD_NetworkResponseHandler.h"

#if __has_include("AFNetworking.h")
#import "AFNetworking.h"
#endif

#ifndef DDD_NETWORK_REQUEST_HOST
#define DDD_NETWORK_REQUEST_HOST @""
#endif

#define DDD_NETWORK_REQUEST_TIMEOUT 10

@interface DDD_NetworkManager ()
@property (nonatomic, copy) DDD_NetworkCompletionBlock ddd_completion;
@property (nonatomic, strong) DDD_NetworkResponseHandler *ddd_responseHandler;
@end

@implementation DDD_NetworkManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.ddd_responseHandler = [[DDD_NetworkResponseHandler alloc] init];
    }
    return self;
}

+ (instancetype)ddd_makeWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters {
    DDD_NetworkManager *ddd_manager = [[self alloc] init];
    ddd_manager.ddd_urlString = urlString;
    ddd_manager.ddd_parameters = parameters;
    ddd_manager.ddd_timeoutInterval = DDD_NETWORK_REQUEST_TIMEOUT;
    return ddd_manager;
}

+ (DDD_NetworkDefaults *)ddd_defaults {
    return DDD_NetworkDefaults.sharedInstance;
}

- (NSString *)ddd_urlString {
    if ([_ddd_urlString hasPrefix:@"http"]) {
        return _ddd_urlString;
    }
    NSString *ddd_host = DDD_NetworkManager.ddd_defaults.ddd_baseURLString;
    NSString *ddd_path = _ddd_urlString;
    if ([ddd_host hasSuffix:@"/"] && [ddd_path hasPrefix:@"/"]) {
        ddd_path = [ddd_path substringFromIndex:1];
    }
    else if (![ddd_host hasSuffix:@"/"] && ![ddd_path hasPrefix:@"/"]) {
        ddd_path = [@"/" stringByAppendingString:ddd_path];
    }
    return [ddd_host stringByAppendingString:ddd_path];
}

#pragma mark - Setter

- (void)setDdd_parameters:(NSDictionary *)ddd_parameters {
    if (DDD_NetworkManager.ddd_defaults.ddd_baseParameters.count > 0 && ddd_parameters.count > 0) {
        NSMutableDictionary *ddd_mutableParameters = [NSMutableDictionary dictionaryWithDictionary:ddd_parameters];
        [ddd_mutableParameters addEntriesFromDictionary:DDD_NetworkManager.ddd_defaults.ddd_baseParameters];
        _ddd_parameters = ddd_mutableParameters;
    } else {
        _ddd_parameters = ddd_parameters;
    }
}

- (void)setDdd_responseClass:(NSString *)ddd_responseClass {
    _ddd_responseClass = ddd_responseClass;
    self.ddd_responseHandler.ddd_responseClass = NSClassFromString(ddd_responseClass);
}

#pragma mark - Request

- (NSURLSessionDataTask *)GET:(DDD_NetworkCompletionBlock)completion {
    return [self ddd_request:@"GET" completion:completion];
}

- (NSURLSessionDataTask *)POST:(DDD_NetworkCompletionBlock)completion {
    return [self ddd_request:@"POST" completion:completion];
}

- (NSURLSessionDataTask *)DELETE:(DDD_NetworkCompletionBlock)completion {
    return [self ddd_request:@"DELETE" completion:completion];
}

- (NSURLSessionDataTask *)PUT:(DDD_NetworkCompletionBlock)completion {
    return [self ddd_request:@"PUT" completion:completion];
}

- (NSURLSessionDataTask *)ddd_request:(NSString *)method completion:(DDD_NetworkCompletionBlock)completion {
    NSParameterAssert(self.ddd_urlString);
    
    self.ddd_completion = completion;
    
    void (^ddd_successCallBack)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        [self ddd_handleSuccessResponse:task responseObject:responseObject];
    };
    void (^ddd_failureCallBack)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error) {
        [self ddd_handleFailureResponse:task error:error];
    };
    
#if __has_include("AFNetworking.h")
    AFHTTPSessionManager *ddd_sessionManager = AFHTTPSessionManager.manager;
    // REQUEST
    // 参数以 JSON 形式传给后台
    ddd_sessionManager.requestSerializer = AFJSONRequestSerializer.serializer;
    // 设置超时时间
    ddd_sessionManager.requestSerializer.timeoutInterval = self.ddd_timeoutInterval > 0 ? self.ddd_timeoutInterval : DDD_NETWORK_REQUEST_TIMEOUT;
    
    // RESPONSE
    AFJSONResponseSerializer *ddd_responseSerializer = (AFJSONResponseSerializer *)ddd_sessionManager.responseSerializer;
    // 设置响应类型
    ddd_responseSerializer.acceptableContentTypes = ({
        NSMutableSet *ddd_types = [NSMutableSet setWithSet:ddd_responseSerializer.acceptableContentTypes];
        [ddd_types addObjectsFromArray:DDD_NetworkManager.ddd_defaults.ddd_acceptableContentTypes];
        ddd_types;
    });
    // 移除空值字段
    if ([ddd_responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]) {
        ddd_responseSerializer.removesKeysWithNullValues = YES;
    }
    
    NSURLSessionDataTask *ddd_dataTask = nil;
    if ([method isEqualToString:@"GET"]) {
        ddd_dataTask = [ddd_sessionManager GET:self.ddd_urlString parameters:self.ddd_parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            if (self.ddd_progressBlock) self.ddd_progressBlock(downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ddd_successCallBack(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ddd_failureCallBack(task, error);
        }];
    } else if ([method isEqualToString:@"POST"]) {
        ddd_dataTask = [ddd_sessionManager POST:self.ddd_urlString parameters:self.ddd_parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            if (self.ddd_progressBlock) self.ddd_progressBlock(uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ddd_successCallBack(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ddd_failureCallBack(task, error);
        }];
    } else if ([method isEqualToString:@"DELETE"]) {
        ddd_dataTask = [ddd_sessionManager DELETE:self.ddd_urlString parameters:self.ddd_parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ddd_successCallBack(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ddd_failureCallBack(task, error);
        }];
    } else if ([method isEqualToString:@"PUT"]) {
        ddd_dataTask = [ddd_sessionManager PUT:self.ddd_urlString parameters:self.ddd_parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ddd_successCallBack(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ddd_failureCallBack(task, error);
        }];
    }
#endif
    
    // LOG
    if (self.ddd_parameters.count > 0) {
        NSLog(@"[网络请求] %@ = %@\n%@", method, ddd_dataTask.originalRequest.URL, self.ddd_parameters);
    } else {
        NSLog(@"[网络请求] %@ = %@", method, ddd_dataTask.originalRequest.URL);
    }
    
    return ddd_dataTask;
}

- (void)ddd_handleSuccessResponse:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    DDD_NetworkResponse *ddd_response = [self.ddd_responseHandler ddd_handleSuccessResponse:task responseObject:responseObject];
    if (self.ddd_completion) self.ddd_completion(ddd_response);
}

- (void)ddd_handleFailureResponse:(NSURLSessionDataTask *)task error:(NSError *)error {
    DDD_NetworkResponse *ddd_response = [self.ddd_responseHandler ddd_handleFailureResponse:task error:error];
    if (self.ddd_completion) self.ddd_completion(ddd_response);
}

@end

@implementation DDD_NetworkDefaults

+ (instancetype)sharedInstance {
    static DDD_NetworkDefaults *ddd_defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddd_defaults = [[self alloc] init];
    });
    return ddd_defaults;
}

- (NSString *)ddd_baseURLString {
    if (!_ddd_baseURLString) {
        return DDD_NETWORK_REQUEST_HOST;
    }
    return _ddd_baseURLString;
}

@end
