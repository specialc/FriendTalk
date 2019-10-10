//
//  DDD_UserModel.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "JSONModel.h"

/** 用户登录成功通知 */
#define ddd_kUserLoginSuccessNotification @"ddd_kUserLoginSuccessNotification"
/** 用户退出成功通知 */
#define ddd_kUserLogoutSuccessNotification @"ddd_kUserLogoutSuccessNotification"

@interface DDD_UserModel : JSONModel
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, assign) NSUInteger is_perfect; // 资料是否完善：1完善、2老用户未完善、3新用户未完善
@end


@interface DDD_CurrentUserModel : DDD_UserModel <NSCoding>

+ (instancetype)ddd_currentUser;

@property (nonatomic, assign, readonly) BOOL ddd_isLogin;

+ (void)ddd_saveInfo:(NSDictionary *)info;

+ (void)ddd_remove;

- (void)ddd_save;

@end

#define DDD_CurrentUser DDD_CurrentUserModel.ddd_currentUser
