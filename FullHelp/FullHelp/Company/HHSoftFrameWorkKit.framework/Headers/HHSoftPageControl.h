//
//  HHSoftPageControl.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-23.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSoftPageControl : UIPageControl

/**
 *  初始化PageControl
 *
 *  @param frame            frame
 *  @param pageCount        一共多少页
 *  @param currentPageImg   当前页的圆点的图片(为nil的时候，默认是红色的)
 *  @param pageIndicatorImg 未出现的页面的小圆点的图片（默认为空心透明）
 *   默认圆点大小为10px
 *  @return PageControl
 */
-(id)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount currentPageImage:(UIImage *)currentPageImg pageIndicatorImage:(UIImage *)pageIndicatorImg;
/**
 *  初始化PageControl
 *
 *  @param frame            frame
 *  @param pageCount        一共多少页
 *  @param currentPageImg   当前页的圆点的图片(为nil的时候，默认是红色的)
 *  @param pageIndicatorImg 未出现的页面的小圆点的图片（默认为空心透明）
 *  @param dotWidth         圆点宽度
 *  @param dotHeight        圆点高度
 *
 *  @return PageControl
 */
-(id)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount currentPageImage:(UIImage *)currentPageImg pageIndicatorImage:(UIImage *)pageIndicatorImg dotWidth:(CGFloat)dotWidth dotHeigth:(CGFloat)dotHeight;

@end
