//
//  NSObject+DDD_Category.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDD_Category)
@property (nonatomic, weak, readonly) id<DDD_NavigationProtocol> ddd_navigationServices;
@end
