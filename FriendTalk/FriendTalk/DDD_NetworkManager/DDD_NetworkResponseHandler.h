//
//  DDD_NetworkResponseHandler.h
//  FriendTalk
//
//  Created by LYH on 2018/10/11.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDD_NetworkResponse.h"

@interface DDD_NetworkResponseHandler : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *ddd_task;
@property (nonatomic, strong) Class ddd_responseClass;

- (DDD_NetworkResponse *)ddd_handleSuccessResponse:(NSURLSessionDataTask *)task responseObject:(id)responseObject;
- (DDD_NetworkResponse *)ddd_handleFailureResponse:(NSURLSessionDataTask *)task error:(NSError *)error;

// Override these methods for parsing the responseObject.
// e.g. {"code": 0, "data": {}, "msg": ""}
- (NSString *)ddd_codeKey;
- (NSString *)ddd_dataKey;
- (NSString *)ddd_msgKey;
+ (NSInteger)ddd_successCode;

@end
