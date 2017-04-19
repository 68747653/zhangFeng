//
//  HHSoftScrollView.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-24.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "HHSoftScrollImageInfo.h"

typedef void(^HHSoftScrollImgTap)(NSInteger currentIndex);
typedef void(^HHSoftScrollScrollEvent)(NSInteger currentIndex);

@interface HHSoftScrollView : UIScrollView
/**
 *  全部是网络图片的时候，图片地址的数组
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImg;
/**
 *  既有网络图片，又有本地图片的时候，对象的数组
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImageInfo;

/**
 *  初始化背景为固定颜色的滚动条
 *
 *  @param frame
 *  @param arrScrollImg    要加载的图片数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundColor ScrollView的背景颜色
 *  @param enableBounces 滑动到边界是否可以继续滑动
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor enableBounces:(BOOL)enableBounces imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  初始化背景为固定图片的滚动条
 *
 *  @param frame
 *  @param arrScrollImg    要加载的图片数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundImage ScrollView的背景图
 *  @param enableBounces 滑动到边界是否可以继续滑动
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage enableBounces:(BOOL)enableBounces imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImg:(NSArray *)arrImg;

/**************************************2016-02-17新增网络图片、本地图片混合方法*****************************************************/

/**
 *  初始化背景为固定颜色的滚动条
 *
 *  @param frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundColor ScrollView的背景颜色
 *  @param enableBounces 滑动到边界是否可以继续滑动
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor enableBounces:(BOOL)enableBounces imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  初始化背景为固定图片的滚动条
 *
 *  @param frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundImage ScrollView的背景图
 *  @param enableBounces 滑动到边界是否可以继续滑动
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage enableBounces:(BOOL)enableBounces imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImgInfo:(NSArray *)arrImgInfo;


@end
