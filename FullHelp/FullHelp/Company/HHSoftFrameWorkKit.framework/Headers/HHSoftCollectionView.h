//
//  HHSoftCollectionView.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-7-21.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PullRefreshBlcock)();

typedef void(^LoadMoreBlock)();

@interface HHSoftCollectionView : UICollectionView
/**
 *  初始化CollectionView
 *
 *  @param dataSource dataSource
 *  @param delegate   delegate
 *
 *  @return
 */
-(id)initWithDataSource:(id)dataSource delegate:(id)delegate;
/**
 *  初始化CollectionView
 *
 *  @param frame      位置
 *  @param dataSource dataSource
 *  @param delegate   delegate
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame dataSource:(id)dataSource delegate:(id)delegate;
/**
 *  初始化CollectionView
 *
 *  @param frame      位置
 *  @param layout     layout
 *  @param dataSource dataSource
 *  @param delegate   delegate
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
        dataSource:(id)dataSource delegate:(id)delegate;
/**
 *  添加下拉刷新和加载更多
 *
 *  @param pullRefresh 下拉
 *  @param loadMore    加载更多
 */
-(void)addPullRefresh:(PullRefreshBlcock)pullRefresh loadMore:(LoadMoreBlock)loadMore;
/**
 *  设置加载更多是否可用
 *
 *  @param enabled 是否可用
 */
-(void)setLoadMoreEnabled:(BOOL)enabled;



@end
