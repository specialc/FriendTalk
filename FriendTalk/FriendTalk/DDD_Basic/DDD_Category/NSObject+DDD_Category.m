//
//  NSObject+DDD_Category.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "NSObject+DDD_Category.h"

@interface DDD_NavigationServiceJ : NSObject
@property (nonatomic, strong) id<DDD_NavigationProtocol> ddd_navigationServices;
@end
@implementation DDD_NavigationServiceJ
+ (instancetype)ddd_shared {
    static id ddd_instance;
    static dispatch_once_t ddd_onceToken;
    dispatch_once(&ddd_onceToken, ^{
        ddd_instance = [[self alloc] init];
    });
    return ddd_instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _ddd_navigationServices = [[DDD_NavigationControllerServicesImpl alloc] init];
    }
    return self;
}
@end


@implementation NSObject (DDD_Category)

- (id<DDD_NavigationProtocol>)ddd_navigationServices {
    return [DDD_NavigationServiceJ ddd_shared].ddd_navigationServices;
}

@end
