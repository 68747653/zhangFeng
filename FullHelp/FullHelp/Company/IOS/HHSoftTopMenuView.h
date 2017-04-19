//
//  HHSoftTopMenuView.h
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/29.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHSoftTopMenuView;

#pragma mark ------ 数据源
@protocol HHSoftTopMenuViewDataSource <NSObject>
@required
/**
 *  @param hhsoftTopMenuView hhsoftTopMenuView
 *  @param column            组数
 *
 *  @return 返回每组的名称
 */
- (NSString *)hhsoftTopMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView titleForColumn:(NSInteger)column;
@optional
/**
 *
 *  @param hhsoftTopMenuView hhsoftTopMenuView
 *
 *  @return 返回hhsoftTopMenuView组数  默认1组
 */
- (NSInteger)numberOfcolumsInMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView;
/**
 *
 *  @param hhsoftTopMenuView hhsoftTopMenuView
 *
 *  @return 返回默认选择的组索引
 */
- (NSInteger)defaultSelectCoumnsInMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView;
@end
#pragma mark ------ 代理方法
@protocol HHSoftTopMenuViewDelegate <NSObject>
/**
 *
 *  @param hhsoftTopMenuView hhsoftTopMenuView
 *  @param index             选中的菜单索引
 */
- (void)hhsoftTopMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView didSelectMenuIndex:(NSInteger)index;
@end

@interface HHSoftTopMenuView : UIScrollView
@property (nonatomic, weak) id <HHSoftTopMenuViewDataSource> menuDataSource;
@property (nonatomic, weak) id <HHSoftTopMenuViewDelegate> menuDelegate;
//选中字体颜色
@property (nonatomic, strong) UIColor *highlightedTextColor;
//普通字体颜色
@property (nonatomic, strong) UIColor *textColor;
//指示器颜色
@property (nonatomic, strong) UIColor *indicatorColor;
//普通字体大小
@property (nonatomic, assign) CGFloat  fontSize;
//高亮字体大小
@property (nonatomic, assign) CGFloat  highlightFontSize;
/** 每个标签宽度 */
@property (nonatomic, assign) CGFloat menuItemWidth;
/**
 *  初始化控件
 *
 *  @param frame              坐标大小
 *  @param indicatorLayerSize 指示器大小
 *
 */
- (instancetype)initWithFrame:(CGRect)frame indicatorLayerSize:(CGSize)indicatorLayerSize;
//刷新菜单
- (void)reloadData;
//刷新某一组菜单
- (void)reloadDataWithMenuIndex:(NSInteger)index;
/**
 *  指示器根据滚动状态事实偏移
 *
 *  @param index
 */
#warning 有问题 等有时间再修改
- (void) changeIndicatorLayerX:(CGFloat)x;
/**
 *  让menuView选中某一组
 *
 *  @param index
 */
- (void) selectMenuIndex:(NSInteger)index;
@end
