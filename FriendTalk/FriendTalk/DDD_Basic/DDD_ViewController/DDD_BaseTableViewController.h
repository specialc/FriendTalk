//
//  DDD_BaseTableViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"

@interface DDD_BaseTableViewController : DDD_BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *ddd_tableView;
@property (nonatomic, assign) BOOL ddd_clearsSelectionOnViewWillAppear;

/// 预先设定当前TableView的Style
- (UITableViewStyle)ddd_tableViewStyle;

#pragma mark - 下拉刷新

/**
 *  添加下拉刷新
 */
- (void)ddd_addHeaderRefresh;

/**
 *  开始下拉刷新
 */
- (void)ddd_beginHeaderRefresh;

/**
 *  结束下拉刷新
 */
- (void)ddd_endHeaderRefresh;

/**
 *  是否正在下拉刷新
 */
- (BOOL)ddd_isHeaderRefresh;

#pragma mark - 上拉加载更多

/**
 *  添加上拉加载
 */
- (void)ddd_addFooterRefresh;

/**
 *  移除上拉加载
 */
- (void)ddd_removeFooterRefresh;

/**
 *  开始上拉加载
 */
- (void)ddd_beginFooterRefresh;

/**
 *  结束上拉加载
 */
- (void)ddd_endFooterRefresh;

/**
 *  是否正在上拉加载
 */
- (BOOL)ddd_isFooterRefresh;

@end
