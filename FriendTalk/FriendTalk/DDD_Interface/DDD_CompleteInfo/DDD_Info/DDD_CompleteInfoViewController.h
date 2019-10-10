//
//  DDD_CompleteInfoViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"
#import <Foundation/Foundation.h>

@interface DDD_CompleteInfoViewController : DDD_BaseViewController
@property (nonatomic, strong) NSDictionary *ddd_dataModel;
@property (nonatomic, copy) void (^ddd_handleUserInfoCompleted)(void);
@end
