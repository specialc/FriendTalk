//
//  NSError+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "NSError+DDD_Category.h"

@implementation NSError (DDD_Category)

- (NSString *)msg {
    return self.userInfo[@"msg"];
}

@end
