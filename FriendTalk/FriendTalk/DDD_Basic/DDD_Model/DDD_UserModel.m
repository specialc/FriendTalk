//
//  DDD_UserModel.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_UserModel.h"

@implementation DDD_UserModel

@end


@implementation DDD_CurrentUserModel

+ (instancetype)ddd_currentUser {
    static id ddd_instanceFirst;
    static dispatch_once_t ddd_onceToken;
    dispatch_once(&ddd_onceToken, ^{
        ddd_instanceFirst = [self ddd_restore] ?: [[self alloc] init];
    });
    return ddd_instanceFirst;
}

- (BOOL)ddd_isLogin {
    if (DDD_CurrentUser.uid.length == 0) {
        return NO;
    }
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.uid        = [coder decodeObjectForKey:@"uid"];
        self.nick_name  = [coder decodeObjectForKey:@"nick_name"];
        self.avatar     = [coder decodeObjectForKey:@"avatar"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
}

+ (NSString *)archivePathName {
    NSString *ddd_sandBoxPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    NSString *ddd_archivePathName = [ddd_sandBoxPath stringByAppendingPathComponent:@"DDD_CurrentUser.archiver"];
    return ddd_archivePathName;
}

+ (instancetype)ddd_restore {
    @try {
        // 获取用户对象
        DDD_CurrentUserModel *ddd_currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:[DDD_CurrentUserModel archivePathName]];
        return ddd_currentUser;
    }
    @catch (NSException *exception) {
        [self ddd_remove];
        return nil;
    }
}

- (void)ddd_save {
    // 缓存用户对象
    [NSKeyedArchiver archiveRootObject:self toFile:[DDD_CurrentUserModel archivePathName]];
    [DDD_NavigationManager ddd_resetRootViewController];
}

+ (void)ddd_remove {
    DDD_CurrentUser.uid = nil;
    DDD_CurrentUser.nick_name = nil;
    // 删除用户对象
    [[NSFileManager defaultManager] removeItemAtPath:[DDD_CurrentUserModel archivePathName] error:NULL];
    
    // 跳转登录界面
    [DDD_NavigationManager ddd_resetRootViewController];
    // 退出登录通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ddd_kUserLogoutSuccessNotification object:nil];
}

+ (void)ddd_saveInfo:(NSDictionary *)info {
    // 基本资料
    DDD_CurrentUser.uid             = [info[@"id"] description];
    DDD_CurrentUser.nick_name       = info[@"nick_name"];
    DDD_CurrentUser.avatar          = info[@"avatar"];
    DDD_CurrentUser.birthday        = info[@"birthday"];
    DDD_CurrentUser.is_perfect      = [info[@"is_perfect"] integerValue];
    
    // 保存
    [DDD_CurrentUser ddd_save];
}

@end
