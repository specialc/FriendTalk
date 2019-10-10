//
//  DDD_NetworkResponseHandler.m
//  FriendTalk
//
//  Created by LYH on 2018/10/11.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_NetworkResponseHandler.h"

#if __has_include("JSONModel.h")
#import "JSONModel.h"
#endif

@implementation DDD_NetworkResponseHandler

- (DDD_NetworkResponse *)ddd_handleSuccessResponse:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
#if __has_include("JSONModel.h")
    DDD_NetworkResponse *ddd_response = [[DDD_NetworkResponse alloc] init];
    ddd_response.ddd_task = task;
    ddd_response.ddd_responseObject = responseObject;
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"[网络请求] 响应数据格式非 JSON: %@\n%@", task.originalRequest.URL, responseObject);
        return ddd_response;
    }
    
    ddd_response.ddd_msg = responseObject[self.ddd_msgKey];
    ddd_response.ddd_data = responseObject[self.ddd_dataKey];
    ddd_response.ddd_code = [responseObject[self.ddd_codeKey] integerValue];
    
    if (ddd_response.ddd_code == DDD_NetworkResponseHandler.ddd_successCode) {
        NSLog(@"[网络请求] 请求成功: %@\n%@", task.originalRequest.URL, responseObject);
    } else {
        ddd_response.ddd_error = [NSError errorWithDomain:@"" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"响应数据 code 不正确"}];
        NSLog(@"[网络请求] 响应数据 code 不正确: %@\n%@", task.originalRequest.URL, responseObject);
        return ddd_response;
    }
    
    if (self.ddd_responseClass && [self.ddd_responseClass isKindOfClass:[JSONModel class]]) {
        NSError *ddd_error = nil;
        if ([ddd_response.ddd_data isKindOfClass:[NSDictionary class]]) {
            ddd_response.ddd_responseClassObject = [[self.ddd_responseClass alloc] initWithDictionary:ddd_response.ddd_data error:&ddd_error];
        }
        else if ([ddd_response.ddd_data isKindOfClass:[NSArray class]]) {
            ddd_response.ddd_responseClassObject = [self.ddd_responseClass arrayOfModelsFromDictionaries:nil error:&ddd_error];
        }
        if (ddd_error) {
            NSLog(@"[网络请求] 响应数据解析出错: %@\n%@\n%@", task.originalRequest.URL, responseObject, ddd_error);
        }
    }
    return ddd_response;
#endif
    return nil;
}

// NSError 用于指示 NSURL 域中的错误的常量: NSURLErrorDomain
- (DDD_NetworkResponse *)ddd_handleFailureResponse:(NSURLSessionDataTask *)task error:(NSError *)error {
    DDD_NetworkResponse *ddd_response = [[DDD_NetworkResponse alloc] init];
    ddd_response.ddd_error = error;
    NSLog(@"[网络请求] 请求失败: %@\n%@", task.originalRequest.URL, error);
    return ddd_response;
}

- (NSString *)ddd_codeKey {
    return @"code";
}

- (NSString *)ddd_dataKey {
    return @"data";
}

- (NSString *)ddd_msgKey {
    return @"msg";
}

+ (NSInteger)ddd_successCode {
    return 200;
}

@end
