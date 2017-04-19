//
//  HHSoftTableView.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-1.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
#import "HHSoftSVPullToRefresh.h"

typedef void(^PullRefreshBlcock)();
typedef void(^LoadMoreBlock)();

@interface HHSoftTableView : TPKeyboardAvoidingTableView

/**
 *  初始化TableView
 *
 *  @param frame      frame
 *  @param dataSource 数据源
 *  @param delegate   代理
 *  @param style      样式
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame
         dataSource:(id)dataSource
           delegate:(id)delegate
              style:(UITableViewStyle )style;
/**
 *  初始化tableView
 *
 *  @param frame          frame
 *  @param dataSource     数据源
 *  @param delegate       代理
 *  @param style          样式
 *  @param separatorColor 分割线颜色
 *
 *  @return 
 */
- (id)initWithFrame:(CGRect)frame
         dataSource:(id)dataSource
           delegate:(id)delegate
              style:(UITableViewStyle )style
     separatorColor:(UIColor *)separatorColor;

/**
 *  添加下拉刷新
 *
 *  @param pullRefresh 下拉
 */
-(void)addPullToRefresh:(PullRefreshBlcock)pullRefresh;
/**
 *  添加加载更多
 *
 *  @param loadMore 加载更多
 */
-(void)addLoadMore:(LoadMoreBlock)loadMore;

/**
 *  设置加载更多是否可用
 *
 *  @param enabled 是否可用
 */
-(void)setLoadMoreEnabled:(BOOL)enabled;
/**
 *  设置转动的风火轮停止转动
 */
-(void)stopAnimating;

-(HHSoftSVPullToRefreshState)sVPullToRefreshState;
-(SVInfiniteScrollingState)sVInfiniteScrollingState;

@end
