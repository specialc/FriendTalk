//
//  DDD_CommonMacro.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#ifndef DDD_CommonMacro_h
#define DDD_CommonMacro_h

// Block
#if DEBUG
#define ext_keywordify autoreleasepool{}
#else
#define ext_keywordify try{} @finally{}
#endif

#define weakify(obj) \
    ext_keywordify \
    __weak __typeof__(obj) weak##obj = obj

#define strongify(obj) \
    ext_keywordify \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    __strong __typeof__(obj) obj = weak##obj \
    _Pragma("clang diagnostic pop")

#define blockify(obj) \
    ext_keywordify \
    __block __typeof__(obj) block##obj = obj

// 判断 iPhone X
#define DDD_SAFE_AREA_INSETS ({ \
    UIEdgeInsets ddd_insets = UIEdgeInsetsZero; \
    if (@available(iOS 11.0, *)) { \
        ddd_insets = UIApplication.sharedApplication.delegate.window.safeAreaInsets; \
    } \
    ddd_insets; \
})

#define DDD_INTERFACE_ORIENTATION UIApplication.sharedApplication.statusBarOrientation

#define DDD_IS_IPHONE_X ({ \
    CGFloat ddd_top = DDD_SAFE_AREA_INSETS.top; \
    ddd_top > 20; \
})

#define DDD_SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define DDD_SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height
#define DDD_STATUS_BAR_HEIGHT (DDD_IS_IPHONE_X ? DDD_SAFE_AREA_INSETS.top : 20.f)
#define DDD_NAVIGATION_BAR_HEIGHT (DDD_STATUS_BAR_HEIGHT + 44.f)
#define DDD_TAB_BAR_HEIGHT (49.f DDD_SAFE_AREA_INSETS.bottom)
#define DDD_iPhoneXJawHeight      (DDD_IS_IPHONE_X ? 34. : 0.)

#define DDD_DELEGATE_WINDOW UIApplication.sharedApplication.delegate.window
#define DDD_ROOT_CONTROLLER DDD_DELEGATE_WINDOW.rootViewController

#define DDD_MAIN_COLOR @"#FF5959".ddd_color

#endif /* DDD_CommonMacro_h */
