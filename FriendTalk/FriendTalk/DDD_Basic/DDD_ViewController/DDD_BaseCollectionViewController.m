//
//  DDD_BaseCollectionViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseCollectionViewController.h"

@interface DDD_BaseCollectionViewController ()

@end

@implementation DDD_BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 加载视图

- (void)ddd_addNavigationBar {
    [super ddd_addNavigationBar];
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    UICollectionViewFlowLayout *ddd_layout = [[UICollectionViewFlowLayout alloc] init];
    self.ddd_layout = ddd_layout;
    
    UIView *ddd_aView = [[UIView alloc] init];
    [self.view addSubview:ddd_aView];
    
    UICollectionView *ddd_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:ddd_layout];
    _ddd_collectionView = ddd_collectionView;
    self.ddd_collectionView.delegate = self;
    self.ddd_collectionView.dataSource = self;
    self.ddd_collectionView.backgroundColor = [UIColor clearColor];
    self.ddd_collectionView.showsVerticalScrollIndicator = NO;
    self.ddd_collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.ddd_collectionView];
    
    if (@available(iOS 11.0, *)) {
        self.ddd_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [ddd_aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.ddd_collectionView);
        make.height.equalTo(0).priorityHigh();
    }];
    
    [self ddd_registerCollectionViewCell:self.ddd_collectionView];
    
#warning CYTest
//    [self.navBar bringToFront];
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    
    [self.ddd_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo((self.navBar && !self.navBar.hidden) ? self.navBar.mas_bottom : self.view.mas_top).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - 添加刷新控件

// 下拉刷新
- (void)ddd_addHeaderRefresh {
    MJRefreshStateHeader *ddd_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(ddd_refreshHeaderAction:)];
    ddd_header.lastUpdatedTimeLabel.hidden = true;
    ddd_header.stateLabel.font = @"14px".ddd_font;
    [ddd_header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [ddd_header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [ddd_header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    self.ddd_collectionView.mj_header = ddd_header;
}

- (void)ddd_beginHeaderRefresh {
    [self.ddd_collectionView.mj_header beginRefreshing];
}

- (void)ddd_endHeaderRefresh {
    [self.ddd_collectionView.mj_header endRefreshing];
}

- (BOOL)ddd_isHeaderRefresh {
    return self.ddd_collectionView.mj_header.isRefreshing;
}

// 上拉加载更多
- (void)ddd_addFooterRefresh {
    MJRefreshAutoNormalFooter *ddd_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(ddd_refreshFooterAction:)];
    ddd_footer.stateLabel.font = @"14px".ddd_font;
    ddd_footer.stateLabel.textColor = @"#999999".ddd_color;
    ddd_footer.tintColor = @"#999999".ddd_color;
    [ddd_footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [ddd_footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    [ddd_footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    self.ddd_collectionView.mj_footer = ddd_footer;
}

- (void)ddd_removeFooterRefresh {
    self.ddd_collectionView.mj_footer = nil;
}

- (void)ddd_beginFooterRefresh {
    [self.ddd_collectionView.mj_footer beginRefreshing];
}

- (void)ddd_endFooterRefresh {
    [self.ddd_collectionView.mj_footer endRefreshing];
}

- (BOOL)ddd_isFooterRefresh {
    return self.ddd_collectionView.mj_footer.isRefreshing;
}

#pragma mark - 网络请求

- (void)ddd_refreshHeaderAction:(MJRefreshStateHeader *)refresh {
    
}

- (void)ddd_refreshFooterAction:(MJRefreshStateHeader *)refresh {
    
}

- (void)ddd_getRequestSuccess:(id)ddd_data {
    [super ddd_getRequestSuccess:ddd_data];
    
    // 结束下拉刷新
    if (self.ddd_isHeaderRefresh) {
        [self ddd_endHeaderRefresh];
    }
    // 结束上拉加载
    if (self.ddd_isFooterRefresh) {
        [self ddd_endFooterRefresh];
    }
}

- (void)ddd_getRequestFailure:(NSError *)ddd_error {
    // 下拉刷新
    if (self.ddd_isHeaderRefresh) {
        [super ddd_getRequestFailure:ddd_error];
        [self ddd_endHeaderRefresh];
    }

    // 上拉加载，直接提示错误
    else if (self.ddd_isFooterRefresh) {
        [self ddd_endFooterRefresh];
        [SVProgressHUD showWithStatus:(ddd_error.msg ?: @"数据加载失败，请稍后再试")];
    }

    // 其他情况，可能是没有触发刷新动作的后台刷新
    else {
        [SVProgressHUD showWithStatus:(ddd_error.msg ?: @"数据加载失败，请稍后再试")];
    }
}

#pragma mark - 注册Cell

- (void)ddd_registerCollectionViewCell:(UICollectionView *)collectionView {
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self.ddd_collectionView) {
        [self.view endEditing:YES];
    }
}

@end
