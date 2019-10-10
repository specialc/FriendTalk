//
//  DDD_LoginModel.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_LoginModel.h"

@implementation DDD_LoginModel

// 登录公共参数
+ (NSDictionary *)ddd_loginParameters {
    NSMutableDictionary *ddd_parameters = [NSMutableDictionary dictionary];
    ddd_parameters[@"platform"]        = @"ios";
    ddd_parameters[@"channel"]         = @"0";
//    parameters[@"app_name"]        = [NormalApplicationInfo appName];
//    parameters[@"app_version"]     = [NormalApplicationInfo appVersion];
//    parameters[@"device_name"]     = [NormalApplicationInfo deviceName];
//    parameters[@"uuid"]            = [NormalApplicationInfo udid];
//    parameters[@"network_type"]    = [NormalApplicationInfo networkType];
//    parameters[@"package_name"]    = [NormalApplicationInfo bundleID];
//    parameters[@"phone_type"]      = [NormalApplicationInfo deviceType];
//    parameters[@"product_type"]    = @"paopao";
//    parameters[@"system_version"]  = [NormalApplicationInfo systemVersion];
//    parameters[@"wifiname"]        = [NormalApplicationInfo wifiName];
//    parameters[@"issiminstalled"]  = @([NormalApplicationInfo isSIMInstalled]);
//    parameters[@"ischarging"]      = @([NormalApplicationInfo isCharging]);
    
    ddd_parameters[@"token_voip"]        = [[NSUserDefaults standardUserDefaults] objectForKey:@"push.token.voip"];
    ddd_parameters[@"token_apns"]        = [[NSUserDefaults standardUserDefaults] objectForKey:@"push.token.apns"];
    ddd_parameters[@"jpush"]             = [[NSUserDefaults standardUserDefaults] objectForKey:@"push.jpush.id"];
    
    return ddd_parameters.copy;
}

// 获取手机号是否登录并发送验证码
+ (void)ddd_requestGetLoginCode:(id)parameters complete:(DDD_NetworkCompletionBlock)complete {
    [DDD_NetworkManagerMake(@"/login/phone", parameters) POST:complete];
}

// 验证并登录
+ (void)ddd_requestMobileLogin:(id)parameters complete:(DDD_NetworkCompletionBlock)complete {
    NSMutableDictionary *ddd_param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [ddd_param addEntriesFromDictionary:[self ddd_loginParameters]];
    [DDD_NetworkManagerMake(@"/login/verify-phone", ddd_param) POST:^(DDD_NetworkResponse *response) {
        if (response.ddd_success) {
            [DDD_CurrentUserModel ddd_saveInfo:response.ddd_data];
            [[NSNotificationCenter defaultCenter] postNotificationName:ddd_kUserLoginSuccessNotification object:nil];
        }
        if (complete) complete(response);
    }];
}

/// 标签列表
+ (void)ddd_requestTagsList:(id)parameters complete:(DDD_NetworkCompletionBlock)complete {
    [DDD_NetworkManagerMakeWithResponseClass(@"/label/label/list", parameters, @"DDD_TagsModel") POST:complete];
}

/// 设置标签
+ (void)ddd_requestAddTags:(id)parameters complete:(DDD_NetworkCompletionBlock)complete {
    [DDD_NetworkManagerMake(@"/label/label/set-label", parameters) POST:complete];
}

@end


@implementation DDD_TagsModel
@end
@implementation DDD_TagsItemModel
@end
