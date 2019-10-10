//
//  DDD_CIDatePickerView.h
//  FriendTalk
//
//  Created by yn2019 on 2019/10/9.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseView.h"

typedef void(^ddd_datePickerCompletionBlock)(NSString *ddd_dateString);

@interface DDD_CIDatePickerView : DDD_BaseView
+ (instancetype)ddd_showWithCompletion:(ddd_datePickerCompletionBlock)completion;
@end
