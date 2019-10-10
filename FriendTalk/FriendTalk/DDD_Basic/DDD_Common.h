//
//  DDD_Common.h
//  FriendTalk
//
//  Created by zhxixh_pc on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDD_Common : NSObject
UIViewController * DDD_VisibleViewController(UIViewController * _Nullable viewController);
BOOL DDD_ShowViewController(UIViewController *viewController, BOOL animated);
@end

NS_ASSUME_NONNULL_END
