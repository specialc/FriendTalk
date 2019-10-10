//
//  NSArray+DDD_Category.m
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "NSArray+DDD_Category.h"

@implementation NSArray (DDD_Category)

- (NSString *)ddd_toJSON {
    NSError *ddd_error = nil;
    NSData *ddd_data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&ddd_error];
    if (ddd_error) {
        NSLog(@"%@", ddd_error);
    }
    return [[NSString alloc] initWithData:ddd_data encoding:NSUTF8StringEncoding];
}

- (NSString *)ddd_toBase64 {
    NSData *ddd_data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [ddd_data base64EncodedStringWithOptions:kNilOptions];
}

@end
