//
//  DDD_BaseWebViewController.h
//  FriendTalk
//
//  Created by LYH on 2018/6/27.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_BaseViewController.h"
#import <WebKit/WebKit.h>

@interface DDD_BaseWebViewController : DDD_BaseViewController <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, readonly) WKWebView *ddd_webView;
@property (nonatomic, readonly) WKWebViewConfiguration *ddd_configuration;

/** 默认网页标题 */
@property (nonatomic, copy) NSString *ddd_webTitle;
/** 默认网页链接 */
@property (nonatomic, copy) NSString *ddd_webURLString;
/** 默认文件路径 */
@property (nonatomic, copy) NSString *ddd_fileURLPath;

@property (nonatomic, assign) BOOL ddd_forceOpenButHttp;

/** A Boolean value indicating whether horizontal swipe gestures will trigger back-forward list navigations. */
@property (nonatomic, assign) BOOL ddd_allowsBackForwardNavigationGestures;
/** A Boolean value that determines whether the view is opaque. */
@property (nonatomic, getter=ddd_isOpaque) BOOL ddd_opaque;

/**
 Add script message handlers.

 @param handler Invoked when a script message is received from a webpage.
 */
- (void)ddd_setScriptMessages:(NSArray<NSString *> *)names reveiveHandler:(void (^)(WKScriptMessage *message))handler;

/** 类方法跳转网页 */
+ (instancetype)ddd_showWithWebURLString:(NSString *)urlString;
/** 类方法跳转文件预览 */
+ (instancetype)ddd_showWithFileURLPath:(NSString *)path;

/** 清除 WKWebView 缓存 */
+ (void)ddd_clearWebCaches API_AVAILABLE(ios(9.0));

/** 暂停网页内音视频播放 */
- (void)ddd_pauseWebPlaying;

@end
