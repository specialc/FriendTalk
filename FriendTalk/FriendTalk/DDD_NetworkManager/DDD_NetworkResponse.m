//
//  DDD_NetworkResponse.m
//  FriendTalk
//
//  Created by LYH on 2018/10/11.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_NetworkResponse.h"
#import "DDD_NetworkResponseHandler.h"

@implementation DDD_NetworkResponse
- (BOOL)ddd_success {
    return !self.ddd_error && self.ddd_code == DDD_NetworkResponseHandler.ddd_successCode;
}
@end
