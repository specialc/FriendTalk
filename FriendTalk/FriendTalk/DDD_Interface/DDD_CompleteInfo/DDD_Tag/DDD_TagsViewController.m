//
//  DDD_TagsViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/10/8.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_TagsViewController.h"

@interface DDD_TagsViewController ()
@property (nonatomic, weak) UILabel *ddd_titleLabel;
@property (nonatomic, weak) UILabel *ddd_tipLabel;
@property (nonatomic, weak) UIScrollView *ddd_tagsScrollView;
@property (nonatomic, weak) UIButton *ddd_completeButton;
@property (nonatomic, strong) NSMutableArray *ddd_selectTagsArray;
@end

@implementation DDD_TagsViewController

+ (void)ddd_showViewControllerCompletion:(void (^)(void))completion {
//    [DDD_LoginModel ddd_requestTagsList:nil complete:^(DDD_NetworkResponse *response) {
//        if (response.ddd_success) {
            DDD_TagsViewController *ddd_vc = [[DDD_TagsViewController alloc] init];
//            ddd_vc.ddd_dataModel = response.ddd_data;
    
#warning CYTest
    DDD_TagsModel *ddd_tagsModel = [[DDD_TagsModel alloc] init];
    NSMutableArray *ddd_array = [[NSMutableArray alloc] init];
    DDD_TagsItemModel *ddd_itemModel = [[DDD_TagsItemModel alloc] init];
    ddd_itemModel.name = @"你瞅啥";
    ddd_itemModel.ID = @"1";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"2";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"3";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"4";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"5";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"6";
    [ddd_array addObject:ddd_itemModel];
    ddd_itemModel.ID = @"7";
    [ddd_array addObject:ddd_itemModel];
    ddd_tagsModel.list = (id)[NSArray arrayWithArray:ddd_array];
    ddd_vc.ddd_dataModel = ddd_tagsModel;
    
    
            ddd_vc.ddd_handleSetMarkCompleted = completion;
            DDD_BaseNavigationController *nav = [[DDD_BaseNavigationController alloc] initWithRootViewController:ddd_vc];
            [self.ddd_navigationServices.ddd_topViewController presentViewController:nav animated:YES completion:nil];
//        }
//        else {
//            if (completion) completion();
//        }
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.ddd_tagsScrollView removeAllSubviews];
    CGFloat ddd_maxY = [self ddd_addTagButtonsView:self.ddd_dataModel.list inView:self.ddd_tagsScrollView target:self addAction:@selector(ddd_didClickTagButton:)];
    self.ddd_tagsScrollView.contentSize = CGSizeMake(DDD_SCREEN_WIDTH - 30*2, ddd_maxY);
}

- (void)ddd_addNavigationBar {
    [super ddd_addNavigationBar];
    self.title = @"个性标签";
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"给自己加上标签吧";
        ddd_label.font = @"21-Medium".ddd_font;
        ddd_label.textColor = @"#2C2C2C".ddd_color;
        ddd_label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:ddd_label];
        self.ddd_titleLabel = ddd_label;
    }
    {
        UILabel *ddd_label = [[UILabel alloc] init];
        ddd_label.text = @"选择个性标签有助于找到更合适的人呦～";
        ddd_label.font = @"13-Medium".ddd_font;
        ddd_label.textColor = @"#959595".ddd_color;
        ddd_label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:ddd_label];
        self.ddd_tipLabel = ddd_label;
    }
    {
        UIScrollView *ddd_scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:ddd_scrollView];
        self.ddd_tagsScrollView = ddd_scrollView;
    }
    {
        UIButton *ddd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        ddd_button.ddd_normalTitle = @"完成";
        ddd_button.ddd_font = @"16-Medium".ddd_font;
        ddd_button.ddd_normalTitleColor = @"#FFFFFF".ddd_color;
        ddd_button.ddd_normalBackgroundImage = @"ddd_lg_getcode_bg".ddd_image;
        ddd_button.ddd_disabledBackgroundImage = @"#D2D2D2".ddd_color.ddd_image;
        ddd_button.layer.masksToBounds = YES;
        [ddd_button addTarget:self action:@selector(ddd_didClickCompleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ddd_button];
        self.ddd_completeButton = ddd_button;
    }
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    
    [self.ddd_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DDD_NAVIGATION_BAR_HEIGHT + 30);
        make.left.right.inset(20);
        make.height.equalTo(29);
    }];
    
    [self.ddd_tipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_titleLabel.mas_bottom).offset(11);
        make.left.right.inset(20);
        make.height.equalTo(18);
    }];

    [self.ddd_tagsScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ddd_tipLabel.mas_bottom).offset(50);
        make.left.right.inset(30);
        make.bottom.equalTo(self.ddd_completeButton.mas_top).inset(20);
    }];
    
    [self.ddd_completeButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.inset(50);
        make.size.equalTo(CGSizeMake(311, 40));
    }];
    self.ddd_completeButton.layer.cornerRadius = 40/2.0;
}

#pragma mark - Touches

- (void)ddd_didClickTagButton:(UIButton *)sender {
    NSUInteger idx = sender.tag - 1000;
    DDD_TagsItemModel *m = self.ddd_dataModel.list[idx];
    if (sender.selected) {
        [self.ddd_selectTagsArray removeObject:m.ID];
        sender.selected = NO;
    }
    else {
        if (self.ddd_selectTagsArray.count >= 5) {
            [SVProgressHUD showInfoWithStatus:@"最多选择5个标签"];
            return;
        }
        [self.ddd_selectTagsArray addObject:m.ID];
        sender.selected = YES;
    }
}

#pragma mark - Method

/** 创建title视图 */
- (CGFloat)ddd_addTagButtonsView:(NSArray *)titles inView:(UIView *)inView target:(id)target addAction:(SEL)addAction {
    // 拿到屏幕的宽
    CGFloat ddd_kScreenW = DDD_SCREEN_WIDTH;
    
    // 间距
    CGFloat ddd_cellSpacing = 25;//上下行距
    CGFloat ddd_initemSpacing = 25;//左右行距
    
    // 开始位置
    CGFloat ddd_begin_x = 23;
    CGFloat ddd_begin_y = 0;
    CGFloat ddd_right_margin = 23;

    CGFloat ddd_titBtnX = ddd_begin_x;
    CGFloat ddd_titBtnY = ddd_begin_y;
    CGFloat ddd_titleHeight = 40;
    CGFloat ddd_titleSpacing = 15;
    
    UIFont *ddd_font = @"14".ddd_font;
    CGFloat ddd_maxY = 0;
    
    for (int i = 0; i < titles.count; i++) {
        // 文本
        DDD_TagsItemModel *ddd_titleModel = titles[i];
        CGSize ddd_titleSize = [ddd_titleModel.name sizeWithAttributes:@{NSFontAttributeName:ddd_font}];
        // 计算文字大小
        CGFloat ddd_titBtnW = ddd_titleSize.width + ddd_titleSpacing * 2 + ddd_initemSpacing;
        //判断按钮是否超过屏幕的宽
        if ((ddd_titBtnX + ddd_titBtnW + ddd_right_margin) > ddd_kScreenW) {
            ddd_titBtnX = ddd_begin_x;
            ddd_titBtnY += ddd_titleHeight + ddd_cellSpacing;
        }
        
        // 设置按钮的位置
        if (inView) {
            UIButton *ddd_button = [[UIButton alloc] initWithFrame:CGRectMake(ddd_titBtnX, ddd_titBtnY, ddd_titBtnW, ddd_titleHeight)];
            ddd_button.tag = i + 1000;
            ddd_button.ddd_font = ddd_font;
            ddd_button.ddd_normalTitle = ddd_titleModel.name;
            ddd_button.ddd_normalTitleColor = @"#2C2C2C".ddd_color;
            ddd_button.ddd_selectedTitleColor = @"#FFFFFF".ddd_color;
            ddd_button.ddd_normalBackgroundImage = @"#F4F4F4".ddd_color.ddd_image;
            ddd_button.ddd_selectedBackgroundImage = @"#9CCEFF".ddd_color.ddd_image;
            ddd_button.layer.cornerRadius = ddd_titleHeight/2.0;
            ddd_button.layer.masksToBounds = true;
            [ddd_button addTarget:target action:addAction forControlEvents:UIControlEventTouchUpInside];
            [inView addSubview:ddd_button];
        }
        
        ddd_titBtnX += ddd_titBtnW + ddd_initemSpacing;
    }
    ddd_maxY = ddd_titBtnY + ddd_titleHeight;
    return ddd_maxY;
}

- (void)ddd_didClickCompleteButton:(UIButton *)sender {
    if (self.ddd_selectTagsArray.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择标签"];
        return;
    }
    [self handlebq];
}

- (void)handlebq {
    if (self.ddd_selectTagsArray.count > 0) {
        [DDD_LoginModel ddd_requestAddTags:@{@"label_id":self.ddd_selectTagsArray, @"type":@(4)} complete:^(DDD_NetworkResponse *response) {
            if (response.ddd_success) {
                //NSLog(@"设置标签成功: 4 \n %@", selAry);
            } else {
                //NSLog(@"设置标签失败: 4 \n %@ \n %@", selAry, result.errorMessage);
            }
        }];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.ddd_handleSetMarkCompleted) {
            self.ddd_handleSetMarkCompleted();
        }
    }];
}

#pragma mark - Getter

- (NSMutableArray *)ddd_selectTagsArray {
    if (!_ddd_selectTagsArray) {
        _ddd_selectTagsArray = [[NSMutableArray alloc] init];
    }
    return _ddd_selectTagsArray;
}

#pragma mark - Setter

- (void)setDdd_dataModel:(DDD_TagsModel *)ddd_dataModel {
    _ddd_dataModel = ddd_dataModel;
}

@end
