//
//  DDD_LoginViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/29.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_LoginViewController.h"
#import "DDD_CodeViewController.h"
#import "DDD_LoginModel.h"

@interface DDD_LoginViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UILabel *ddd_titleL;
@property (nonatomic, weak) UILabel *ddd_phoneTitleL;
@property (nonatomic, weak) UITextField *ddd_phoneTextField;
@property (nonatomic, weak) UILabel *ddd_tipL;
@property (nonatomic, weak) UIView *ddd_separatorV;
@property (nonatomic, weak) UIView *ddd_announceV;
@property (nonatomic, weak) UIButton *ddd_getCodeB;
@property (nonatomic, weak) UIButton *ddd_readB;
@property (nonatomic, weak) UIButton *ddd_announceB;

@property (nonatomic, strong) NSString    *ddd_previousTextFieldContent;
@property (nonatomic, strong) UITextRange *ddd_previousSelection;
@end

@implementation DDD_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)ddd_addNavigationBar {}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"登录/注册";
        ddd_label.font = @"21-Medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        [self.view addSubview:ddd_label];
        self.ddd_titleL = ddd_label;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"+86";
        ddd_label.font = @"16-Medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        [self.view addSubview:ddd_label];
        self.ddd_phoneTitleL = ddd_label;
    }
    {
        UITextField *ddd_textField = [[UITextField alloc] init];
        ddd_textField.placeholder = @"请输入手机号";
        ddd_textField.font = @"18-Medium".ddd_font;
        ddd_textField.textColor = @"#2C2C2C".ddd_color;

        ddd_textField.translatesAutoresizingMaskIntoConstraints = NO;
        ddd_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        ddd_textField.autocorrectionType = UITextAutocorrectionTypeNo;
        ddd_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        ddd_textField.keyboardType = UIKeyboardTypeNumberPad;
        [ddd_textField addTarget:self action:@selector(ddd_reformatAsCardNumber:) forControlEvents:UIControlEventEditingChanged];
        
        ddd_textField.delegate = self;
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
        ddd_button.ddd_normalTitle = @"获取验证码";
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
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:ddd_FriendTalk_had_login]) {
            self.ddd_readB.selected = YES;
        }
        else {
            //用户第一次登录需要手动选择协议
            self.ddd_readB.selected = NO;
        }
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
    self.ddd_previousTextFieldContent = textField.text;
    self.ddd_previousSelection = textField.selectedTextRange;
    return YES;
}

#pragma mark - Network

// 获取验证码
- (void)ddd_requestGetCode {
    NSUInteger ddd_targetPosition = [self.ddd_phoneTextField offsetFromPosition:self.ddd_phoneTextField.beginningOfDocument toPosition:self.ddd_phoneTextField.selectedTextRange.start];
    // 手机号
    NSString *ddd_phone = [self ddd_removeNonDigits:self.ddd_phoneTextField.text andPreserveCursorPosition:&ddd_targetPosition];
    
    NSMutableDictionary *ddd_param = [[NSMutableDictionary alloc] init];
    ddd_param[@"phone"] = ddd_phone;
    
#warning CYTest
    
//    @weakify(self);
//    [SVProgressHUD showWithStatus:@"加载中，请稍候..."];
//    [DDD_LoginModel ddd_requestGetLoginCode:ddd_param complete:^(DDD_NetworkResponse *response) {
//        @strongify(self);
//        [SVProgressHUD dismiss];
//        // 获取验证码成功
//        if (response.ddd_success) {
//            // 验证验证码
            DDD_CodeViewController *ddd_vc = [[DDD_CodeViewController alloc] init];
            ddd_vc.ddd_phone = ddd_phone;
//            ddd_vc.ddd_codeID = [response.ddd_data[@"id"] description];
            [self.ddd_navigationServices ddd_pushViewController:ddd_vc animated:YES];
//        }
//        else {
//            [SVProgressHUD showInfoWithStatus:response.ddd_msg];
//        }
//    }];
}

#pragma mark - Touches

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view != self.ddd_phoneTextField) {
        [self.view endEditing:YES];
    }
}

- (void)ddd_didClickGetCodeButton:(UIButton *)sender {
    if (self.ddd_readB.isSelected == NO) {
        [SVProgressHUD showInfoWithStatus:@"请先勾选用户协议"];
        return;
    }
    
    [self ddd_requestGetCode];
}

- (void)ddd_didClickReadButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)ddd_didClickAnnounceButton:(UIButton *)sender {
    // 用户协议
    
}

#pragma mark - Method

- (void)ddd_reformatAsCardNumber:(UITextField *)textField {
    NSUInteger ddd_targetPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *ddd_phoneWithoutSpaces = [self ddd_removeNonDigits:textField.text andPreserveCursorPosition:&ddd_targetPosition];
    
    // 获取验证码是否可点击
    if ([ddd_phoneWithoutSpaces length] >= 11) {
        self.ddd_getCodeB.enabled = YES;
    }
    else {
        self.ddd_getCodeB.enabled = NO;
    }
    
    // 替换文本内容
    if ([ddd_phoneWithoutSpaces length] > 11) {
        [textField setText:self.ddd_previousTextFieldContent];
        textField.selectedTextRange = self.ddd_previousSelection;
        return;
    }
    
//    // 添加空格
//    NSString *ddd_phoneWithSpaces = [self ddd_insertSpacesEveryFourDigitsIntoString:ddd_phoneWithoutSpaces andPreserveCursorPosition:&ddd_targetPosition];
//    textField.text = ddd_phoneWithSpaces;
//
//    UITextPosition *ddd_aNewPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:ddd_targetPosition];
//    [textField setSelectedTextRange:[textField textRangeFromPosition:ddd_aNewPosition toPosition:ddd_aNewPosition]];
}

- (NSString *)ddd_removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger ddd_originalPosition = *cursorPosition;
    NSMutableString *ddd_digitsOnlyString = [NSMutableString new];
    
    // 删除空格
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar ddd_characterToAdd = [string characterAtIndex:i];
        if (isdigit(ddd_characterToAdd)) {
            NSString *ddd_stringToAdd = [NSString stringWithCharacters:&ddd_characterToAdd length:1];
            [ddd_digitsOnlyString appendString:ddd_stringToAdd];
        }
        else {
            if (i < ddd_originalPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return ddd_digitsOnlyString;
}

- (NSString *)ddd_insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *ddd_stringWithAddedSpaces = [NSMutableString new];
    NSUInteger ddd_cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        if (i <= 3) {
            if ((i > 0) && ((i % 3) == 0)) {
                [ddd_stringWithAddedSpaces appendString:@" "];
                if (i < ddd_cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        else {
            NSUInteger ddd_index = i - 3;
            if ((ddd_index > 0) && ((ddd_index % 4) == 0)) {
                [ddd_stringWithAddedSpaces appendString:@" "];
                if (i < ddd_cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar ddd_characterToAdd = [string characterAtIndex:i];
        NSString *ddd_stringToAdd = [NSString stringWithCharacters:&ddd_characterToAdd length:1];
        [ddd_stringWithAddedSpaces appendString:ddd_stringToAdd];
    }
    
    return ddd_stringWithAddedSpaces;
}

@end
