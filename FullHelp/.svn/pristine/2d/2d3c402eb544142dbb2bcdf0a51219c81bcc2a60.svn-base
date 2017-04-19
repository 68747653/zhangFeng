//
//  UIViewController+NavigationBar.h
//  ShiShiCai
//
//  Created by hhsoft on 2017/1/3.
//  Copyright © 2017年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)
/** 需要监听的view */
@property (nonatomic,strong) UIScrollView * keyScrollView;

@property (nonatomic, strong) UINavigationBar *hhsoftNavigationBar;

@property (nonatomic, strong) UINavigationItem *hhsoftNaigationItem;

/**
 左侧按钮是否可以隐藏
 */
@property (nonatomic,assign) BOOL  isLeftAlpha;
/**
 中间按钮是否可以隐藏
 */
@property (nonatomic,assign) BOOL  isTitleAlpha;
/**
 右侧侧按钮是否可以隐藏
 */
@property (nonatomic,assign) BOOL  isRightAlpha;

/**
 添加一个透明的NavigationBar
 */
- (void)addLucencyNavigationBar;

/**
 根据偏移量导航栏渐变 (滚动完成偏移量为0时不显示子视图)

 @param offy 偏移量
 @param headerHeight headerView高度
 */
- (void)showNavigationBarByOffy:(CGFloat)offy headerHeight:(CGFloat)headerHeight;

/**
 根据偏移量导航栏渐变(滚动完成偏移量为0时显示子视图)

 @param offy 偏移量
 @param headerHeight headerView高度
 */
- (void)showZeroNavigationBarByOffy:(CGFloat)offy headerHeight:(CGFloat)headerHeight;
@end
