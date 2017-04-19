//
//  HHSoftLoadingView.h
//  FlightForLove
//
//  Created by hhsoft on 15/11/3.
//  Copyright © 2015年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HHSoftViewLoadDataFailedTouch)();

@interface HHSoftLoadingView : UIView
@property(nonatomic,strong,readonly)UILabel  *textLable;
@property(nonatomic,strong,readonly)UIImageView *imageView;



/**
 *  显示正在加载的动画
 *
 *  @param text        显示的文字
 *  @param imagesArray 需要显示动画的图片数组,(数组里边存放的是UIImage对象)
 *  @param duration    每次动画的持续时间
 */
- (void)showLoadingViewWithText:(NSString *)text
                animationImages:(NSArray  *)imagesArray
              animationDuration:(NSTimeInterval)duration;

/**
 *  加载失败显示的内容
 *
 *  @param text      显示的标题
 *  @param failImage 显示的图片
 *  @param failTouch 失败后的处理
 */
-(void)showLoadDataFailViewWithText:(NSString *)text failImage:(UIImage *)failImage failTouch:(HHSoftViewLoadDataFailedTouch)failTouch;


/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView;
@end
