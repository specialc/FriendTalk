//
//  DDD_BaseWebViewController.m
//  FriendTalk
//
//  Created by LYH on 2018/6/27.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "DDD_BaseWebViewController.h"
#import <StoreKit/StoreKit.h>

@interface DDD_BaseWebViewController () <SKStoreProductViewControllerDelegate>
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, copy) NSArray<NSString *> *scriptMessageNames;
@property (nonatomic, copy) void (^receiveScriptMessageHandler)(WKScriptMessage *message);
@end

@implementation DDD_BaseWebViewController

@synthesize ddd_webView = _ddd_webView;
@synthesize ddd_configuration = _ddd_configuration;

+ (instancetype)ddd_showWithWebURLString:(NSString *)urlString {
    if (urlString.length == 0) {
        return nil;
    }
    DDD_BaseWebViewController *ddd_vc = [[self alloc] init];
    ddd_vc.ddd_webURLString = urlString;
    DDD_ShowViewController(ddd_vc, YES);
    return ddd_vc;
}

+ (instancetype)ddd_showWithFileURLPath:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    DDD_BaseWebViewController *ddd_vc = [[self alloc] init];
    ddd_vc.ddd_fileURLPath = path;
    DDD_ShowViewController(ddd_vc, YES);
    return ddd_vc;
}

+ (void)ddd_clearWebCaches {
    NSSet *ddd_dataTypes = WKWebsiteDataStore.allWebsiteDataTypes;
    NSDate *ddd_date = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:ddd_dataTypes modifiedSince:ddd_date completionHandler:^{
        NSLog(@"清除 WKWebView 缓存完成");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 默认配置
    self.ddd_allowsBackForwardNavigationGestures = YES;
    self.ddd_forceOpenButHttp = NO;
    
    NSURL *ddd_url = nil;
    if (self.ddd_fileURLPath) {
        ddd_url = [NSURL fileURLWithPath:self.ddd_fileURLPath.ddd_stringByEscapingForURLArgument];
    }
    else if (self.ddd_webURLString) {
        ddd_url = [NSURL URLWithString:self.ddd_webURLString.ddd_stringByEscapingForURLArgument];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:ddd_url];
    [self.ddd_webView loadRequest:request];
}

#pragma mark - UI

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    [self.ddd_navBar ddd_addLeftButton:self.closeButton animated:NO];
    [self.view insertSubview:self.ddd_webView belowSubview:self.ddd_navBar];
    [self.ddd_webView addSubview:self.progressBar];
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    if (self.ddd_hiddenNavBar) {
        [self.ddd_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    } else {
        [self.ddd_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ddd_navBar.mas_bottom);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
}

- (WKWebView *)ddd_webView {
    if (!_ddd_webView) {
        _ddd_webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.ddd_configuration];
        _ddd_webView.navigationDelegate = self;
        _ddd_webView.UIDelegate = self;
    }
    return _ddd_webView;
}

- (WKWebViewConfiguration *)ddd_configuration {
    if (!_ddd_configuration) {
        _ddd_configuration = [[WKWebViewConfiguration alloc] init];
        _ddd_configuration.allowsInlineMediaPlayback = YES;
        _ddd_configuration.mediaPlaybackRequiresUserAction = NO;
    }
    return _ddd_configuration;
}

- (UIProgressView *)progressBar {
    if (!_progressBar) {
        _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressBar.ddd_width = self.ddd_webView.ddd_width;
        _progressBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        _progressBar.alpha = 0;
    }
    return _progressBar;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _closeButton.ddd_normalImage = @"close".ddd_image;
        _closeButton.alpha = 0;
        [_closeButton addTarget:self action:@selector(didClickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

#pragma mark - TouchEvents

- (void)ddd_didClickBackButton:(UIButton *)sender {
    if (sender && self.ddd_webView.canGoBack) {
        [self.ddd_webView goBack];
        return;
    }
    [super ddd_didClickBackButton:sender];
}

- (void)didClickCloseButton:(UIButton *)sender {
    [self ddd_didClickBackButton:nil];
}

#pragma mark - Public

- (void)ddd_setScriptMessages:(NSArray<NSString *> *)names reveiveHandler:(void (^)(WKScriptMessage *))handler {
    [self removeScriptMessages];
    
    self.receiveScriptMessageHandler = handler;
    self.scriptMessageNames = names;
    [self addScriptMessages];
}

- (void)addScriptMessages {
    if (self.ddd_webView && self.scriptMessageNames.count > 0) {
        for (NSString *name in self.scriptMessageNames) {
            [self.ddd_webView.configuration.userContentController addScriptMessageHandler:self name:name];
        }
    }
}

- (void)removeScriptMessages {
    if (self.ddd_webView && self.scriptMessageNames.count > 0) {
        for (NSString *ddd_name in self.scriptMessageNames) {
            [self.ddd_webView.configuration.userContentController removeScriptMessageHandlerForName:ddd_name];
        }
    }
}

- (void)ddd_pauseWebPlaying {
    [self.ddd_webView evaluateJavaScript:
     @"var videos = document.getElementsByTagName('video'); \
     for (var i = 0; i < videos.length; i++) { \
     videos[i].pause(); \
     }" completionHandler:nil];
    
    [self.ddd_webView evaluateJavaScript:
     @"var medias = document.getElementsByTagName('media'); \
     for (var i = 0; i < medias.length; i++) { \
     medias[i].pause(); \
     }" completionHandler:nil];
}

#pragma mark - WKNavigationDelegate

// 决定是否允许或取消跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *ddd_url = navigationAction.request.URL;
    NSLog(@"决定是否允许或取消跳转: %@", ddd_url);
    // 解决无法跳转新窗口问题
    if (!navigationAction.targetFrame) {
        [webView loadRequest:navigationAction.request];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    // 强制跳转 App
    if (self.ddd_forceOpenButHttp) {
        if (![ddd_url.scheme hasPrefix:@"http"]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:ddd_url options:@{} completionHandler:nil];
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[UIApplication sharedApplication] openURL:ddd_url];
                });
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 收到响应后决定是否允许或取消跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"收到响应后决定是否允许或取消跳转: %@", navigationResponse.response.URL);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 当页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"当页面开始加载时调用");
}

// 当开始加载数据时发生错误时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"当开始加载数据时发生错误时调用: %@", error);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用");
}

// 当页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"当页面加载完成时调用");
}

// 当加载过程中发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"当加载过程中发生错误时调用: %@", error);
}

// 当页面需要响应身份验证质询时调用
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    NSLog(@"当页面需要响应身份验证质询时调用");
    // 判断服务器采用的验证方法
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 未发生错误的情况下创建一个凭证, 并使用证书
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *ddd_credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, ddd_credential);
        } else {
            // 验证失败, 取消本次验证
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

// 当页面内容进程终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"当页面内容进程终止时调用");
    [webView reload];
}

#pragma mark WKUIDelegate

// 显示警告弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"显示警告弹窗");
    DDD_Alert(message, @[@"好"], ^(UIAlertAction *action) {
        completionHandler();
    });
}

// 显示确认弹窗
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"显示确认弹窗");
    DDD_Alert(message, @[@"取消", @"好"], ^(UIAlertAction *action) {
        completionHandler(action.ddd_index == 1 ? YES : NO);
    });
}

// 显示文本输入弹窗
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"显示文本输入弹窗");
    __block UIAlertController *ddd_alert = DDD_Alert(nil, @[@"取消", @"好"], ^(UIAlertAction *action) {
        completionHandler(action.ddd_index == 1 ? ddd_alert.textFields.firstObject.text : nil);
    });
    [ddd_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
}

#pragma mark WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.receiveScriptMessageHandler) {
        self.receiveScriptMessageHandler(message);
    }
}

#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - KVO

- (void)ddd_removeObservers {
    [super ddd_removeObservers];
    [self removeScriptMessages];
    [self.ddd_webView removeObserver:self forKeyPath:@"title"];
    [self.ddd_webView removeObserver:self forKeyPath:@"loading"];
    [self.ddd_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.ddd_webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.ddd_webView removeObserver:self forKeyPath:@"canGoForward"];
}

- (void)ddd_addObservers {
    [super ddd_addObservers];
    [self addScriptMessages];
    [self.ddd_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.ddd_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.ddd_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.ddd_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.ddd_webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"title: %@", self.ddd_webView.title);
        if (!self.ddd_webTitle) {
            self.title = self.ddd_webView.title.length == 0 ? self.ddd_webView.URL.absoluteString : self.ddd_webView.title;
        }
    }
    else if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading: %d", self.ddd_webView.loading);
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.progressBar.alpha = self.ddd_webView.loading ? 1 : 0;
        } completion:^(BOOL finished) {
            self.progressBar.progress = 0;
        }];
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"estimatedProgress: %f", self.ddd_webView.estimatedProgress);
        [self.progressBar setProgress:self.ddd_webView.estimatedProgress animated:self.ddd_webView.estimatedProgress > self.progressBar.progress];
    }
    else if ([keyPath isEqualToString:@"canGoBack"]) {
        NSLog(@"canGoBack: %d", self.ddd_webView.canGoBack);
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.closeButton.alpha = self.ddd_webView.canGoBack ? 1 : 0;
        } completion:nil];
    }
    else if ([keyPath isEqualToString:@"canGoForward"]) {
        NSLog(@"canGoForward: %d", self.ddd_webView.canGoForward);
    }
}

#pragma mark - Setter

- (void)setDdd_webTitle:(NSString *)ddd_webTitle {
    _ddd_webTitle = ddd_webTitle;
    self.title = ddd_webTitle;
}

- (void)setDdd_allowsBackForwardNavigationGestures:(BOOL)ddd_allowsBackForwardNavigationGestures {
    _ddd_allowsBackForwardNavigationGestures = ddd_allowsBackForwardNavigationGestures;
    self.ddd_webView.allowsBackForwardNavigationGestures = ddd_allowsBackForwardNavigationGestures;
}

- (void)setDdd_opaque:(BOOL)ddd_opaque {
    _ddd_opaque = ddd_opaque;
    self.ddd_webView.opaque = ddd_opaque;
}

#pragma mark - MemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
