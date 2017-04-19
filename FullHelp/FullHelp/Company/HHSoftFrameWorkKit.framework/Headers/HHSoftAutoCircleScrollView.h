//
//  HHSoftAutoScrollView.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-23.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "HHSoftScrollImageInfo.h"
typedef void(^HHSoftScrollImgTap)(NSInteger currentIndex);
typedef void(^HHSoftScrollScrollEvent)(NSInteger currentIndex);

@interface HHSoftAutoCircleScrollView : UIScrollView
/**
 *  纯网络图片，网络地址数组
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImg;
/**
 *  网络图片、本地图片混合存储对象数组
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImgInfo;

/**
 *  初始化支持滑动和自动轮播的背景颜色的滚动条
 *
 *  @param frame           frame
 *  @param arrScrollImg    加载的内容的数组
 *  @param placeHolderImg  缓存加载的图片
 *  @param backgroundColor 背景颜色
 *  @param timeInterval    自动轮播的时间间隔
 *  @param tapEvent        触摸具体的某个内容的处理
 *  @param scrollEvent     滚动每每一个内容的处理
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor timeInterval:(NSTimeInterval)timeInterval imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;

/**
 *  初始化支持滑动和自动轮播的背景图片的滚动条
 *
 *  @param frame           frame
 *  @param arrScrollImg    加载的内容的数组
 *  @param placeHolderImg  缓存加载的图片
 *  @param backgroundImage 背景图片
 *  @param timeInterval    自动轮播的时间间隔
 *  @param tapEvent        触摸具体的某个内容的处理
 *  @param scrollEvent     滚动每每一个内容的处理
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage timeInterval:(NSTimeInterval)timeInterval imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;

/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImg:(NSArray *)arrImg;

/**************************************2016-02-17新增网络图片、本地图片混合方法*****************************************************/

/**
 *  初始化支持滑动和自动轮播的背景颜色的滚动条
 *
 *  @param frame           frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  缓存加载的图片
 *  @param backgroundColor 背景颜色
 *  @param timeInterval    自动轮播的时间间隔
 *  @param tapEvent        触摸具体的某个内容的处理
 *  @param scrollEvent     滚动每每一个内容的处理
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor timeInterval:(NSTimeInterval)timeInterval imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;

/**
 *  初始化支持滑动和自动轮播的背景图片的滚动条
 *
 *  @param frame           frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  缓存加载的图片
 *  @param backgroundImage 背景图片
 *  @param timeInterval    自动轮播的时间间隔
 *  @param tapEvent        触摸具体的某个内容的处理
 *  @param scrollEvent     滚动每每一个内容的处理
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage timeInterval:(NSTimeInterval)timeInterval imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;

/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImgInfo:(NSArray *)arrImgInfo;

@end
