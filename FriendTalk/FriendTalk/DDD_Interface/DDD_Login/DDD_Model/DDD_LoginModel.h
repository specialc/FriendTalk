//
//  DDD_LoginModel.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDD_TagsItemModel;
@protocol DDD_TagsItemModel;

@interface DDD_LoginModel : NSObject

/// 获取手机号是否登录并发送验证码
+ (void)ddd_requestGetLoginCode:(id)parameters complete:(DDD_NetworkCompletionBlock)complete;
/// 验证并登录
+ (void)ddd_requestMobileLogin:(id)parameters complete:(DDD_NetworkCompletionBlock)complete;
/// 标签列表
+ (void)ddd_requestTagsList:(id)parameters complete:(DDD_NetworkCompletionBlock)complete;
/// 设置标签
+ (void)ddd_requestAddTags:(id)parameters complete:(DDD_NetworkCompletionBlock)complete;
@end


// 标签
@interface DDD_TagsModel : JSONModel
@property (nonatomic, copy) NSArray<DDD_TagsItemModel *><DDD_TagsItemModel> *list;
@end

@interface DDD_TagsItemModel : JSONModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@end
