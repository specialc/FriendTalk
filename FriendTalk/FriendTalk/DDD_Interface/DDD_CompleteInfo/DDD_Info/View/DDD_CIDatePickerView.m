//
//  DDD_CIDatePickerView.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/9.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_CIDatePickerView.h"

#define DDD_PICKER_HEIGHT 96.f

@interface DDD_CIDatePickerView()
@property (nonatomic, strong) UIView *ddd_mainView;
@property (nonatomic, strong) UIButton *ddd_cancelButton;
@property (nonatomic, strong) UIButton *ddd_confirmButton;
@property (nonatomic, strong) UIView *ddd_topView;
@property (nonatomic, strong) UIDatePicker *ddd_datePicker;
@property (nonatomic, copy) ddd_datePickerCompletionBlock ddd_completionHanler;
@end

@implementation DDD_CIDatePickerView

+ (instancetype)ddd_showWithCompletion:(ddd_datePickerCompletionBlock)completion {
    DDD_CIDatePickerView *ddd_datePicker = [[DDD_CIDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ddd_datePicker.backgroundColor = @"#000000".ddd_colorWithAlpha(0.4);
    ddd_datePicker.ddd_completionHanler = completion;
    [[UIApplication sharedApplication].delegate.window addSubview:ddd_datePicker];
    
    [ddd_datePicker layoutIfNeeded];
    ddd_datePicker.ddd_mainView.transform = CGAffineTransformMakeTranslation(0, ddd_datePicker.ddd_mainView.frame.size.height);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ddd_datePicker.ddd_mainView.transform = CGAffineTransformIdentity;
        ddd_datePicker.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:nil];
    return ddd_datePicker;
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    {
        UIView *ddd_view = [[UIView alloc] init];
        ddd_view.backgroundColor = UIColor.whiteColor;
        [self addSubview:ddd_view];
        self.ddd_mainView = ddd_view;
    }
    {
        UIView *ddd_view = [[UIView alloc] init];
        ddd_view.backgroundColor = UIColor.whiteColor;
        [self.ddd_mainView addSubview:ddd_view];
        self.ddd_topView = ddd_view;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalTitle = @"取消";
        ddd_button.ddd_font = @"15-Medium".ddd_font;
        ddd_button.ddd_normalTitleColor = @"#2C2C2C".ddd_color;
        ddd_button.contentEdgeInsets = UIEdgeInsetsMake(0, 23, 0, 23);
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_topView addSubview:ddd_button];
        self.ddd_cancelButton = ddd_button;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalTitle = @"确定";
        ddd_button.ddd_font = @"15-Medium".ddd_font;
        ddd_button.ddd_normalTitleColor = @"#2C2C2C".ddd_color;
        ddd_button.contentEdgeInsets = UIEdgeInsetsMake(0, 23, 0, 23);
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.ddd_topView addSubview:ddd_button];
        self.ddd_confirmButton = ddd_button;
    }
    {
        NSDateFormatter *ddd_format = [[NSDateFormatter alloc] init];
        ddd_format.dateFormat = @"yyyy-MM-dd";
        
        UIDatePicker *ddd_datePicker = [[UIDatePicker alloc] init];
        ddd_datePicker.minimumDate = [ddd_format dateFromString:@"1960-01-01"];
        ddd_datePicker.maximumDate = [NSDate date];
        ddd_datePicker.datePickerMode = UIDatePickerModeDate;
        ddd_datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [self.ddd_mainView addSubview:ddd_datePicker];
        self.ddd_datePicker = ddd_datePicker;
        
        if (DDD_CurrentUser.birthday) {
            self.ddd_datePicker.date = [ddd_format dateFromString:DDD_CurrentUser.birthday];
        }
    }
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    
    [self.ddd_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(0);
        make.height.equalTo(78 + DDD_PICKER_HEIGHT + 53 + DDD_iPhoneXJawHeight);
    }];
    
    [self.ddd_topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(57);
    }];
    
    [self.ddd_cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [self.ddd_confirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [self.ddd_datePicker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_topView.mas_bottom).offset(21);
        make.left.right.equalTo(0);
        make.height.equalTo(DDD_PICKER_HEIGHT);
    }];
}

#pragma mark - TouchEvents

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self) {
        [self ddd_removeFromSuperview];
    }
}

- (void)ddd_didClickCancelButton:(UIButton *)sender {
    [self ddd_removeFromSuperview];
}

- (void)ddd_didClickConfirmButton:(UIButton *)sender {
    if (self.ddd_completionHanler) {
        NSDateFormatter *ddd_formatter = [[NSDateFormatter alloc] init];
        ddd_formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [ddd_formatter  stringFromDate:self.ddd_datePicker.date];
        self.ddd_completionHanler(dateStr);
    }
    [self ddd_removeFromSuperview];
}

#pragma mark - Method

- (void)ddd_removeFromSuperview {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.ddd_mainView.transform = CGAffineTransformMakeTranslation(0, self.ddd_mainView.frame.size.height);
        self.backgroundColor = @"#000000".ddd_colorWithAlpha(0.4);
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

@end
