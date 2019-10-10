//
//  DDD_NavigationManager.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ddd_FriendTalk_had_login @"FriendTalk.had.login"

@interface DDD_NavigationManager : NSObject

+ (void)ddd_resetRootViewController;
+ (void)ddd_handleUserLogin:(NSDictionary *)responseObject isLogin:(BOOL)isLogin;
+ (void)ddd_openSettingsURL;

@end
