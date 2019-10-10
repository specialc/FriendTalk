//
//  DDD_NetworkResponse.h
//  FriendTalk
//
//  Created by LYH on 2018/10/11.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDD_NetworkResponse : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *ddd_task;
@property (nonatomic, strong) id ddd_responseObject;
@property (nonatomic, strong) id ddd_responseClassObject;
@property (nonatomic, strong) NSError *ddd_error;
@property (nonatomic, assign) BOOL ddd_success;

@property (nonatomic, assign) NSInteger ddd_code;
@property (nonatomic, strong) id ddd_data;
@property (nonatomic, copy) NSString *ddd_msg;

@end
