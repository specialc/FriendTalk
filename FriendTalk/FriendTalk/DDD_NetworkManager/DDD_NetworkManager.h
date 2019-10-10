//
//  DDD_NetworkManager.h
//  FriendTalk
//
//  Created by LYH on 2018/7/24.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDD_NetworkResponse.h"
@class DDD_NetworkDefaults;

typedef void (^DDD_NetworkCompletionBlock)(DDD_NetworkResponse *response);

@interface DDD_NetworkManager : NSObject

+ (instancetype)ddd_makeWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters;

@property (class, nonatomic, readonly) DDD_NetworkDefaults *ddd_defaults;

@property (nonatomic, copy) NSString *ddd_urlString;

@property (nonatomic, copy) NSDictionary *ddd_parameters;

@property (nonatomic, assign) NSTimeInterval ddd_timeoutInterval;

@property (nonatomic, copy) NSString *ddd_responseClass;

@property (nonatomic, copy) void (^ddd_progressBlock)(NSProgress *progress);

/** GET 请求 */
- (NSURLSessionDataTask *)GET:(DDD_NetworkCompletionBlock)completion;

/** POST 请求 */
- (NSURLSessionDataTask *)POST:(DDD_NetworkCompletionBlock)completion;

/** DELETE 请求 */
- (NSURLSessionDataTask *)DELETE:(DDD_NetworkCompletionBlock)completion;

/** PUT 请求 */
- (NSURLSessionDataTask *)PUT:(DDD_NetworkCompletionBlock)completion;

@end

@interface DDD_NetworkDefaults : NSObject
+ (instancetype)sharedInstance;
/** Setter or #define DDD_NETWORK_REQUEST_HOST. Uses setter first. */
@property (nonatomic, copy) NSString *ddd_baseURLString;
/** 通用请求参数 */
@property (nonatomic, copy) NSDictionary *ddd_baseParameters;
/** 设置响应类型 */
@property (nonatomic, copy) NSArray *ddd_acceptableContentTypes;
@end

static inline DDD_NetworkManager * DDD_NetworkManagerMake(NSString *urlString, NSDictionary *parameters) {
    return [DDD_NetworkManager ddd_makeWithURLString:urlString parameters:parameters];
}

static inline DDD_NetworkManager * DDD_NetworkManagerMakeWithResponseClass(NSString *urlString, NSDictionary *parameters, NSString *responseClass) {
    DDD_NetworkManager *ddd_manager = [DDD_NetworkManager ddd_makeWithURLString:urlString parameters:parameters];
    ddd_manager.ddd_responseClass = responseClass;
    return ddd_manager;
}
