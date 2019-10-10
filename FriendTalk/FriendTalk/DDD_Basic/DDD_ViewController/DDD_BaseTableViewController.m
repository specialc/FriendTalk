//
//  DDD_BaseTableViewController.m
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseTableViewController.h"

@interface DDD_BaseTableViewController ()

@end

@implementation DDD_BaseTableViewController

- (UITableViewStyle)ddd_tableViewStyle {
    return UITableViewStylePlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.ddd_clearsSelectionOnViewWillAppear) {
        [self.ddd_tableView deselectRowAtIndexPath:self.ddd_tableView.indexPathForSelectedRow animated:YES];
    }
}

#pragma mark - 添加视图

- (void)ddd_addNavigationBar {
    [super ddd_addNavigationBar];
}

- (void)ddd_addSubViews {
    [super ddd_addSubViews];
    
    // 用来解决iOS7-iOS8系统中 Tabbar NavigationBar合用时automaticallyAdjustsScrollViewInsets出现的问题
    // 请勿改变控件顺序z-index，切记
    DDD_BaseView *ddd_aView = [[DDD_BaseView alloc] init];
    [self.view addSubview:ddd_aView];
    
    UITableView *ddd_aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self ddd_tableViewStyle]];
    [self.view addSubview:ddd_aTableView];
    _ddd_tableView = ddd_aTableView;
    self.ddd_tableView.delegate = self;
    self.ddd_tableView.dataSource = self;
    self.ddd_tableView.backgroundColor      = [UIColor clearColor];
    self.ddd_tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
    self.ddd_tableView.showsVerticalScrollIndicator = NO;
    self.ddd_tableView.estimatedRowHeight   = 44;
    self.ddd_tableView.rowHeight            = UITableViewAutomaticDimension;
    if (@available(iOS 11.0, *)) {
        self.ddd_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [ddd_aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.ddd_tableView);
        make.height.equalTo(0).priorityHigh();
    }];
    
    self.ddd_clearsSelectionOnViewWillAppear = YES;
    
#warning CYTest
//    [self.ddd_navBar bringToFront];
}

- (void)ddd_addMasonrys {
    [super ddd_addMasonrys];
    
    [self.ddd_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
#warning CYTest
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
    ddd_header.lastUpdatedTimeLabel.hidden = YES;
    ddd_header.stateLabel.font = @"14px".ddd_font;
    [ddd_header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [ddd_header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [ddd_header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    self.ddd_tableView.mj_header = ddd_header;
}

- (void)ddd_beginHeaderRefresh {
    [self.ddd_tableView.mj_header beginRefreshing];
}

- (void)ddd_endHeaderRefresh {
    [self.ddd_tableView.mj_header endRefreshing];
}

- (BOOL)ddd_isHeaderRefresh {
    return self.ddd_tableView.mj_header.isRefreshing;
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
    self.ddd_tableView.mj_footer = ddd_footer;
}

- (void)ddd_removeFooterRefresh {
    self.ddd_tableView.mj_footer = nil;
}

- (void)ddd_beginFooterRefresh {
    [self.ddd_tableView.mj_footer beginRefreshing];
}

- (void)ddd_endFooterRefresh {
    [self.ddd_tableView.mj_footer endRefreshing];
}

- (BOOL)ddd_isFooterRefresh {
    return self.ddd_tableView.mj_footer.isRefreshing;
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

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self.ddd_tableView) {
        [self.view endEditing:YES];
    }
}

@end
