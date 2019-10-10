//
//  DDD_CodeViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"

@interface DDD_CodeViewController : DDD_BaseViewController
@property (nonatomic, copy) NSString *ddd_phone;  // 验证的手机号
@property (nonatomic, copy) NSString *ddd_codeID; // 验证码ID
@property (nonatomic, assign) BOOL ddd_readAnnounce;
@end
