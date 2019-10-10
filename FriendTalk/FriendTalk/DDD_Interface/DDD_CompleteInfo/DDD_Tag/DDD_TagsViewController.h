//
//  DDD_TagsViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"
#import "DDD_LoginModel.h"

@interface DDD_TagsViewController : DDD_BaseViewController
@property (nonatomic, strong) DDD_TagsModel *ddd_dataModel;
+ (void)ddd_showViewControllerCompletion:(void (^)(void))completion;

@property (nonatomic, copy) void (^ddd_handleSetMarkCompleted)(void);
@end
