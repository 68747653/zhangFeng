//
//  HHSoftScrollView.h
//  FrameWotk
//
//  Created by dgl on 15-3-21.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "HHSoftScrollImageInfo.h"

typedef void(^HHSoftScrollImgTap)(NSInteger currentIndex);
typedef void(^HHSoftScrollScrollEvent)(NSInteger currentIndex);

@interface HHSoftCircleScrollView : UIScrollView
/**
 *  纯网络图片的图片地址的数组
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImg;
/**
 *  网络图片、本地图片混合存储的图片对象
 */
@property (nonatomic,strong,readonly) NSArray *arrScrollImgInfo;

/**
 *  初始化可循环查看的背景为固定颜色的滚动条
 *
 *  @param frame
 *  @param arrScrollImg    要加载的图片数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundColor ScrollView的背景颜色
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  初始化可循环查看的背景为固定图片的滚动条
 *
 *  @param frame
 *  @param arrScrollImg    要加载的图片数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundImage ScrollView的背景图
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImg:(NSArray *)arrScrollImg placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;

/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImg:(NSArray *)arrImg;

/**************************************2016-02-17新增网络图片、本地图片混合方法*****************************************************/
/**
 *  初始化可循环查看的背景为固定颜色的滚动条
 *
 *  @param frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundColor ScrollView的背景颜色
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundColor:(UIColor *)backgroundColor imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;
/**
 *  初始化可循环查看的背景为固定图片的滚动条
 *
 *  @param frame
 *  @param arrScrollImgInfo    要加载的图片对象（HHSoftScrollImageInfo）数组
 *  @param placeHolderImg  预加载的图片
 *  @param backgroundImage ScrollView的背景图
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame arrScrollImgInfo:(NSArray *)arrScrollImgInfo placeHolderimg:(UIImage *)placeHolderImg backgroundImage:(UIImage *)backgroundImage imgTap:(HHSoftScrollImgTap)tapEvent scrollEvent:(HHSoftScrollScrollEvent)scrollEvent;


/**
 *  更新滚动视图上要展示的图片
 *
 *  @param arrImg 图片数组
 */
-(void)updateArrScrollImgInfo:(NSArray *)arrImgInfo;


@end
