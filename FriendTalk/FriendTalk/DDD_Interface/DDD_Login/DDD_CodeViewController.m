//
//  DDD_CodeViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_CodeViewController.h"
#import "DDD_LoginModel.h"

@interface DDD_CodeViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UILabel *ddd_titleL;
@property (nonatomic, weak) UILabel *ddd_phoneTitleL;
@property (nonatomic, weak) UITextField *ddd_phoneTextField;
@property (nonatomic, weak) UILabel *ddd_tipL;
@property (nonatomic, weak) UIView *ddd_separatorV;
@property (nonatomic, weak) UIView *ddd_announceV;
@property (nonatomic, weak) UIButton *ddd_getCodeB;
@property (nonatomic, weak) UIButton *ddd_readB;
@property (nonatomic, weak) UIButton *ddd_announceB;

@property (nonatomic, strong) NSTimer  *ddd_numTimer; // 倒计时定时器
@property (nonatomic, assign) NSInteger ddd_number; // 倒计时时间
@end

@implementation DDD_CodeViewController

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    if (!parent) {
        [self ddd_stopNumTimer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ddd_startCodeCountDownTimer:60];
}

- (void)ddd_addNavigationBar {
    [super ddd_addNavigationBar];
    self.ddd_navBar.ddd_tintColor = @"#333333".ddd_color;
    self.ddd_navBar.ddd_hidesShadowView = YES;
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"请输入4位验证码";
        ddd_label.font = @"21-Medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        [self.view addSubview:ddd_label];
        self.ddd_titleL = ddd_label;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = [NSString stringWithFormat:@"+86 %@", self.ddd_phone.length > 0 ? self.ddd_phone : @""];
        ddd_label.font = @"16-Medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        [self.view addSubview:ddd_label];
        self.ddd_phoneTitleL = ddd_label;
    }
    {
        UITextField *ddd_textField = [[UITextField alloc] init];
        ddd_textField.placeholder = @"输入验证码";
        ddd_textField.font = @"18-Medium".ddd_font;
        ddd_textField.textColor = @"#2C2C2C".ddd_color;
        ddd_textField.keyboardType = UIKeyboardTypeNumberPad;
        ddd_textField.delegate = self;
        [ddd_textField addTarget:self action:@selector(ddd_phoneTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        if (@available(iOS 12.0, *)) {
            ddd_textField.textContentType = UITextContentTypeOneTimeCode;
        }
        [self.view addSubview:ddd_textField];
        self.ddd_phoneTextField = ddd_textField;
    }
    {
        UIView *ddd_view = [[UIView alloc] init];
        ddd_view.backgroundColor = @"#D2D2D2".ddd_color;
        [self.view addSubview:ddd_view];
        self.ddd_separatorV = ddd_view;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.font = @"12".ddd_font;
        ddd_label.textColor = @"#F96B3B".ddd_color;
        [self.view addSubview:ddd_label];
        self.ddd_tipL = ddd_label;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_font = @"16-Medium".ddd_font;
        ddd_button.ddd_normalTitle = @"60s后重新获取验证码";
        ddd_button.ddd_normalTitleColor = @"#FFFFFF".ddd_color;
        ddd_button.ddd_normalBackgroundImage = @"ddd_lg_getcode_bg".ddd_image;
        ddd_button.ddd_disabledBackgroundImage = @"#D2D2D2".ddd_color.ddd_image;
        ddd_button.enabled = NO;
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickGetCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ddd_button];
        self.ddd_getCodeB = ddd_button;
    }
    {
        UIView *ddd_view = [[UIView alloc] init];
        ddd_view.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:ddd_view];
        self.ddd_announceV = ddd_view;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalTitle = @"注册/登录代表您已阅读并同意 ";
        ddd_button.ddd_font = @"12".ddd_font;
        ddd_button.ddd_normalTitleColor = @"#979797".ddd_color;
        ddd_button.ddd_normalImage = @"ddd_lg_announce".ddd_image;
        ddd_button.ddd_selectedImage = @"ddd_lg_announce_s".ddd_image;
        ddd_button.ddd_imageLeft(7);
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickReadButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_announceV addSubview:ddd_button];
        self.ddd_readB = ddd_button;
        
        self.ddd_readB.selected = YES;
        self.ddd_readB.userInteractionEnabled = NO;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalTitle = @"用户协议";
        ddd_button.ddd_font = @"12".ddd_font;
        ddd_button.ddd_normalTitleColor = @"#F96B3B".ddd_color;
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickAnnounceButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_announceV addSubview:ddd_button];
        self.ddd_announceB = ddd_button;
    }
}

- (void)ddd_addMasonrys {
    [self.ddd_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DDD_NAVIGATION_BAR_HEIGHT+10);
        make.left.equalTo(34);
        make.right.equalTo(-34);
        make.height.equalTo(29);
    }];
    
    [self.ddd_phoneTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_titleL.mas_bottom).offset(DDD_SCREEN_HEIGHT/667*113.0);
        make.left.equalTo(34);
        make.right.equalTo(-34);
        make.height.equalTo(29);
    }];
    
    [self.ddd_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_phoneTitleL.mas_bottom).offset(27);
        make.left.equalTo(34);
        make.right.equalTo(-34);
        make.height.equalTo(41);
    }];
    
    [self.ddd_separatorV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_phoneTextField.mas_bottom).offset(8);
        make.left.equalTo(34);
        make.right.equalTo(-34);
        make.height.equalTo(1);
    }];
    
    [self.ddd_tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_phoneTextField.mas_bottom).offset(9);
        make.left.equalTo(34);
        make.right.equalTo(-34);
        make.height.equalTo(17);
    }];
    
    [self.ddd_getCodeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_phoneTextField.mas_bottom).offset(DDD_SCREEN_HEIGHT/667*102.0);
        make.left.equalTo(32);
        make.right.equalTo(-32);
        make.height.equalTo(44);
    }];
    self.ddd_getCodeB.layer.cornerRadius = 44/2.0;
    
    [self.ddd_announceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_getCodeB.mas_bottom).offset(14);
        make.centerX.equalTo(0);
        make.height.equalTo(17);
    }];
    
    [self.ddd_readB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [self.ddd_announceB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(self.ddd_readB.mas_right).offset(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (text.length > 4) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)ddd_phoneTextFieldEditingChanged:(UITextField *)textField {
    if (textField.text.length >= 4) {
        [self ddd_requestPhoneLogin];
        [textField resignFirstResponder];
    }
}

#pragma mark - Network

// 获取验证码
- (void)ddd_requestGetCode {
    
#warning CYTest
    
//    NSMutableDictionary *ddd_param = [[NSMutableDictionary alloc] init];
//    ddd_param[@"phone"] = self.ddd_phone;
//
//    @weakify(self);
//    [SVProgressHUD showWithStatus:@"加载中，请稍候..."];
//    [DDD_LoginModel ddd_requestGetLoginCode:ddd_param complete:^(DDD_NetworkResponse *response) {
//        @strongify(self);
//        [SVProgressHUD dismiss];
//        // 验证手机号通过
//        if (response.ddd_success) {
//            self.ddd_codeID = [response.ddd_data[@"id"] description];
            [self ddd_startCodeCountDownTimer:60];
//        }
//    }];
}

// 登录
- (void)ddd_requestPhoneLogin {
    NSMutableDictionary *ddd_param = [[NSMutableDictionary alloc] init];
    ddd_param[@"code"] = self.ddd_phoneTextField.text;
    ddd_param[@"id"] = self.ddd_codeID;
    
#warning CYTest
    
//    [SVProgressHUD showWithStatus:@"加载中，请稍候..."];
//    [DDD_LoginModel ddd_requestMobileLogin:ddd_param complete:^(DDD_NetworkResponse *response) {
//        [SVProgressHUD dismiss];
//        if (response.ddd_success) {
//            [DDD_NavigationManager ddd_handleUserLogin:response.ddd_data isLogin:YES];
    [DDD_NavigationManager ddd_handleUserLogin:nil isLogin:YES];
//        }
//        else {
//            [SVProgressHUD showInfoWithStatus:response.ddd_msg];
//        }
//    }];
}

#pragma mark - Touches

- (void)ddd_didClickGetCodeButton:(UIButton *)sender {
    [self ddd_requestGetCode];
}

- (void)ddd_didClickReadButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)ddd_didClickAnnounceButton:(UIButton *)sender {
    
}

#pragma mark - Method

// 开始计时
- (void)ddd_startCodeCountDownTimer:(NSInteger)duration {
    if (!self.ddd_numTimer) {
        self.ddd_number = 0;
        self.ddd_numTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ddd_updateTime) userInfo:nil repeats:YES];
        self.ddd_getCodeB.enabled = NO;
        self.ddd_getCodeB.ddd_normalTitle = [NSString stringWithFormat:@"%lds后重新获取验证码", duration];
    }
}

// 停止计时
- (void)ddd_stopNumTimer {
    if (self.ddd_numTimer) {
        [self.ddd_numTimer invalidate];
        self.ddd_numTimer = nil;
    }
}

#pragma mark --- 更新label上的显示时间 ---
- (void)ddd_updateTime {
    NSLog(@"倒计时：%ld", (long)self.ddd_number);
    self.ddd_number++;
    if (self.ddd_number >= 60){
        self.ddd_number = 0;
        [self ddd_stopNumTimer];
        self.ddd_getCodeB.enabled = YES;
        self.ddd_getCodeB.ddd_normalTitle = @"重发验证码";
        return;
    }
    self.ddd_getCodeB.enabled = NO;
    self.ddd_getCodeB.ddd_normalTitle = [NSString stringWithFormat:@"%lds后重新获取验证码", 60-self.ddd_number];
}

@end
