//
//  NSArray+DDD_Category.h
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (DDD_Category)
@property (nonatomic, readonly) NSString *ddd_toJSON;
@property (nonatomic, readonly) NSString *ddd_toBase64;
@end

NS_ASSUME_NONNULL_END
