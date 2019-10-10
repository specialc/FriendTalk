//
//  DDD_CompleteInfoViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_CompleteInfoViewController.h"
#import "DDD_TagsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "UIScrollView+DDD_Category.h"
#import "DDD_CIDatePickerView.h"

#define ddd_headerButton_height 90

@interface DDD_CompleteInfoViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) UIScrollView *ddd_mainScrollView;
@property (nonatomic, weak) UILabel *ddd_titleLabel;
@property (nonatomic, weak) UIButton *ddd_headerButton;
@property (nonatomic, weak) UITextField *ddd_nameTextField;
@property (nonatomic, weak) UIButton *ddd_birthdayButton;
@property (nonatomic, weak) UIButton *ddd_manButton;
@property (nonatomic, weak) UIButton *ddd_womanButton;
@property (nonatomic, weak) UILabel *ddd_tipLabel;
@property (nonatomic, weak) UIButton *ddd_nextButton;

@property (nonatomic, strong) UIImage *ddd_headerImage;
@end

@implementation DDD_CompleteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ddd_addNavigationBar {
    [super ddd_addNavigationBar];
    
    self.ddd_navBar.ddd_hidesShadowView = YES;
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    {
        UIScrollView *ddd_scrollView = [[UIScrollView alloc] init];
        ddd_scrollView.ddd_deliversNextResponder = YES;
        [self.view addSubview:ddd_scrollView];
        self.ddd_mainScrollView = ddd_scrollView;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"让我们认识你";
        ddd_label.font = @"21-medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        [self.ddd_mainScrollView addSubview:ddd_label];
        self.ddd_titleLabel = ddd_label;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalBackgroundImage = @"ddd_info_header_bg".ddd_image;
        ddd_button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_mainScrollView addSubview:ddd_button];
        self.ddd_headerButton = ddd_button;
    }
    {
        UITextField *ddd_textField = [[UITextField alloc] init];
        ddd_textField.placeholder = @"请填写昵称";
        ddd_textField.font = @"16-Medium".ddd_font;
        ddd_textField.textColor = @"#2C2C2C".ddd_color;
        
        ddd_textField.translatesAutoresizingMaskIntoConstraints = NO;
        ddd_textField.clearButtonMode = UITextFieldViewModeNever;
        ddd_textField.autocorrectionType = UITextAutocorrectionTypeNo;
        ddd_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        ddd_textField.keyboardType = UIKeyboardTypeDefault;
        ddd_textField.textAlignment = NSTextAlignmentCenter;
        [ddd_textField addTarget:self action:@selector(ddd_didNameTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        
        ddd_textField.delegate = self;
        ddd_textField.layer.masksToBounds = YES;
        ddd_textField.layer.borderWidth = 1;
        ddd_textField.layer.borderColor = @"#D2D2D2".ddd_color.CGColor;
        [self.ddd_mainScrollView addSubview:ddd_textField];
        self.ddd_nameTextField = ddd_textField;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_font = @"16".ddd_font;
        ddd_button.ddd_normalTitle = @"选择出生日期";
        ddd_button.ddd_selectedTitle = @"";
        ddd_button.ddd_normalTitleColor = @"#DDDDDD".ddd_color;
        ddd_button.ddd_selectedTitleColor = @"#2C2C2C".ddd_color;
        ddd_button.layer.masksToBounds = YES;
        ddd_button.layer.borderWidth = 1;
        ddd_button.layer.borderColor = @"#D2D2D2".ddd_color.CGColor;
        [ddd_button addTarget:self action:@selector(ddd_didClickBirthdayButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_mainScrollView addSubview:ddd_button];
        self.ddd_birthdayButton = ddd_button;
        
        self.ddd_birthdayButton.selected = NO;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_font = @"12-Medium".ddd_font;
        ddd_button.ddd_normalTitle = @"男";
        ddd_button.ddd_normalTitleColor = @"#DDDDDD".ddd_color;
        ddd_button.ddd_selectedTitleColor = @"#0099FF".ddd_color;
        ddd_button.ddd_normalImage = @"ddd_info_man".ddd_image;
        ddd_button.ddd_selectedImage = @"ddd_info_man_s".ddd_image;
        ddd_button.ddd_imageTop(4);
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickManButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_mainScrollView addSubview:ddd_button];
        self.ddd_manButton = ddd_button;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_font = @"12-Medium".ddd_font;
        ddd_button.ddd_normalTitle = @"女";
        ddd_button.ddd_normalTitleColor = @"#DDDDDD".ddd_color;
        ddd_button.ddd_selectedTitleColor = @"#0099FF".ddd_color;
        ddd_button.ddd_normalImage = @"ddd_info_woman".ddd_image;
        ddd_button.ddd_selectedImage = @"ddd_info_woman_s".ddd_image;
        ddd_button.ddd_imageTop(4);
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickWomanButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_mainScrollView addSubview:ddd_button];
        self.ddd_womanButton = ddd_button;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"*注册成功后，性别不可修改";
        ddd_label.font = @"10".ddd_font;
        ddd_label.textColor = @"#B2B2B2".ddd_color;
        ddd_label.textAlignment = NSTextAlignmentCenter;
        [self.ddd_mainScrollView addSubview:ddd_label];
        self.ddd_tipLabel = ddd_label;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_font = @"16-Medium".ddd_font;
        ddd_button.ddd_normalTitle = @"下一步";
        ddd_button.ddd_normalTitleColor = @"#FFFFFF".ddd_color;
        ddd_button.ddd_normalBackgroundImage = @"ddd_lg_getcode_bg".ddd_image;
        ddd_button.ddd_disabledBackgroundImage = @"#D2D2D2".ddd_color.ddd_image;
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_mainScrollView addSubview:ddd_button];
        self.ddd_nextButton = ddd_button;
        self.ddd_nextButton.enabled = NO;
    }
    
    [self.view bringSubviewToFront:self.ddd_navBar];
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    
    [self.ddd_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.ddd_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DDD_NAVIGATION_BAR_HEIGHT + 10);
        make.left.equalTo(32);
        make.right.equalTo(-32);
        make.height.equalTo(29);
        make.width.equalTo(DDD_SCREEN_WIDTH - 32*2);
    }];
    
    [self.ddd_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.ddd_titleLabel.mas_bottom).offset(56);
        make.size.equalTo(ddd_headerButton_height);
    }];
    
    [self.ddd_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.ddd_headerButton.mas_bottom).offset(35);
        make.size.equalTo(CGSizeMake(310, 40));
    }];
    self.ddd_nameTextField.layer.cornerRadius = 40/2.0;
    
    [self.ddd_birthdayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.ddd_nameTextField.mas_bottom).offset(32);
        make.size.equalTo(CGSizeMake(310, 40));
    }];
    self.ddd_birthdayButton.layer.cornerRadius = 40/2.0;
    
    [self.ddd_manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_birthdayButton.mas_bottom).offset(65);
        make.right.equalTo(self.ddd_mainScrollView.centerX).offset(-44);
        make.height.equalTo(46);
    }];
    
    [self.ddd_womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_manButton);
        make.left.equalTo(self.ddd_mainScrollView.centerX).offset(44);
        make.height.equalTo(self.ddd_manButton);
    }];
    
    [self.ddd_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_manButton.mas_bottom).offset(19);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(15);
    }];
    
    [self.ddd_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.ddd_tipLabel.mas_bottom).offset(40);
        make.size.equalTo(CGSizeMake(310, 40));
        make.bottom.equalTo(-47);
    }];
    self.ddd_nextButton.layer.cornerRadius = 40/2.0;
}

#pragma mark - Touches

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view != self.ddd_nameTextField || touches.anyObject.view == self.ddd_mainScrollView) {
        [self.view endEditing:YES];
    }
}

- (void)ddd_didClickHeaderButton:(UIButton *)sender {
    [self.view endEditing:YES];
    UIAlertController *ddd_alertController = DDD_ActionSheet(@"", @[@"相册", @"拍照", @"取消"], ^(UIAlertAction *action) {
        if ([action.title isEqualToString:@"相册"]) {
            // 打开相册
            [self ddd_selectPicture:NO];
        }
        else if ([action.title isEqualToString:@"拍照"]) {
            // 打开摄像头
            [self ddd_selectPicture:YES];
        }
    });
    ddd_alertController.view.tintColor = @"#2C2C2C".ddd_color;
}

- (void)ddd_didNameTextFieldEditingChanged:(UITextField *)textField {
    [self ddd_handleForNextButtonEnable];
}

- (void)ddd_didClickBirthdayButton:(UIButton *)sender {
    [self.view endEditing:YES];
    [self ddd_handleForNextButtonEnable];
    @weakify(self);
    [DDD_CIDatePickerView ddd_showWithCompletion:^(NSString *dateString) {
        @strongify(self);
        self.ddd_birthdayButton.ddd_selectedTitle = dateString;
        self.ddd_birthdayButton.selected = YES;
    }];
}

- (void)ddd_didClickManButton:(UIButton *)sender {
    self.ddd_manButton.selected = YES;
    self.ddd_womanButton.selected = NO;
    [self ddd_handleForNextButtonEnable];
}

- (void)ddd_didClickWomanButton:(UIButton *)sender {
    self.ddd_manButton.selected = NO;
    self.ddd_womanButton.selected = YES;
    [self ddd_handleForNextButtonEnable];
}

- (void)ddd_didClickNextButton:(UIButton *)sender {
//    DDD_TagsViewController *ddd_vc = [[DDD_TagsViewController alloc] init];
//    [self.ddd_navigationServices ddd_pushViewController:ddd_vc animated:YES];
    if (self.ddd_handleUserInfoCompleted) {
        self.ddd_handleUserInfoCompleted();
    }
}

#pragma mark - Method

- (void)ddd_handleForNextButtonEnable {
    BOOL ddd_enable = YES;
    if (self.ddd_headerImage == nil) {
        ddd_enable = NO;
    }
    else if (self.ddd_nameTextField.text.length == 0) {
        ddd_enable = NO;
    }
    else if (self.ddd_birthdayButton.ddd_normalTitle.length == 0) {
        ddd_enable = NO;
    }
    else if (self.ddd_manButton.isSelected == NO && self.ddd_womanButton.isSelected == NO) {
        ddd_enable = NO;
    }
    
    self.ddd_nextButton.enabled = ddd_enable;
}

- (void)ddd_selectPicture:(BOOL)ddd_openCamera {
    UIImagePickerController *ddd_picker = [[UIImagePickerController alloc] init];
    ddd_picker.delegate = self;
    ddd_picker.editing = NO;
    
    if (ddd_openCamera) {
        // 判断相机是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 判断是否开启相机权限
            if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) {
                [self ddd_openLimitsAlertController:@"相机服务未开启" message:@"请开启相机权限，以保证准确使用拍摄照片和录制视频功能。"];
                return;
            }
            ddd_picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            [self ddd_notAvailableAlertController:@"错误" message:@"相机不可用"];
            return;
        }
    }
    else {
        // 判断相册是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            // 判断是否开启相册权限
            if (PHPhotoLibrary.authorizationStatus == PHAuthorizationStatusDenied) {
                [self ddd_openLimitsAlertController:@"相册服务未开启" message:@"请开启相册权限，允许访问你的相册"];
                return;
            }
            ddd_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else {
            [self ddd_notAvailableAlertController:@"错误" message:@"相册不可用"];
            return;
        }
    }
    [self presentViewController:ddd_picker animated:YES completion:nil];
}

// 不可用弹窗
- (void)ddd_notAvailableAlertController:(NSString *)title message:(NSString *)message {
    UIAlertController *ddd_alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ddd_action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ddd_alert addAction:ddd_action];
    [self presentViewController:ddd_alert animated:YES completion:nil];
}

// 打开权限弹窗
- (void)ddd_openLimitsAlertController:(NSString *)title message:(NSString *)message {
    UIAlertController *ddd_alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ddd_action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ddd_actionOpen = [UIAlertAction actionWithTitle:@"开启权限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DDD_NavigationManager ddd_openSettingsURL];
    }];
    [ddd_alert addAction:ddd_action];
    [ddd_alert addAction:ddd_actionOpen];
    [self presentViewController:ddd_alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *ddd_image = info[UIImagePickerControllerOriginalImage];
    self.ddd_headerImage = ddd_image;
    self.ddd_headerButton.ddd_normalImage = ddd_image;
    self.ddd_headerButton.layer.cornerRadius = ddd_headerButton_height/2.0;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self ddd_handleForNextButtonEnable];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter

- (void)setDdd_dataModel:(NSDictionary *)ddd_dataModel {
    _ddd_dataModel = ddd_dataModel;
}

@end
