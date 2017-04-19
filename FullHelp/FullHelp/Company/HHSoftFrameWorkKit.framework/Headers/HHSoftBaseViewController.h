//
//  HHSoftBaseViewController.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-1.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSoftLoadingView.h"
#import "HHSoftShareView.h"
#import "SVProgressHUD.h"
#import "HHSoftAFNetworking.h"


@interface HHSoftBaseViewController : UIViewController
@property (nonatomic,strong)    NSURLSessionTask *op;
@property (nonatomic,strong) HHSoftShareView *shareView;

/**
 *  WatiView
 *
 *  @param msg 请等待提示信息
 */
-(void)showWaitView:(NSString *)msg;
-(void)showWaitView:(NSString *)msg withBackGroundColor:(UIColor *)backgroundColor withForeGroundColor:(UIColor *)foreGroundColor withAnimationType:(SVProgressHUDAnimationType)progressHUDAnimationType viewFont:(UIFont *)font;
-(void)setWaitViewFont:(UIFont *)font;
-(void)hideWaitView;
-(void)showSuccessView:(NSString *)msg;
-(void)showErrorView:(NSString *)msg;


/**
 *  AlertView 提示框
 *
 *  @param text 提示信息
 */
-(void)showAlertView:(NSString *)text;
-(void)showAlertView:(NSString *)text delegate:(id)a_delegate;



/**
 *  显示正在加载的动画
 *
 *  @param text        显示的文字
 *  @param imagesArray 需要显示动画的图片数组,(数组里边存放的是UIImage对象)
 *  @param duration    每次动画的持续时间
 */
- (void)showLoadingViewWithText:(NSString *)text
                animationImages:(NSArray *)imagesArray
              animationDuration:(NSTimeInterval)duration;
/**
 *  加载失败显示的内容
 *
 *  @param text      显示的标题
 *  @param failImage 显示的图片
 *  @param failTouch 失败后的处理
 */
-(void)showLoadDataFailViewInView:(UIView *)targetView WithText:(NSString *)text failImage:(UIImage *)failImage failTouch:(HHSoftViewLoadDataFailedTouch)failTouch;


/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView;


/**
 *  显示分享界面
 *
 *  @param shareType          分享类型 可以传多个（ShareQQFriend|ShareQQSpace|ShareMessage|ShareSinaWeiBo）
 *  @param shareButtonPressed 分享按钮点击后的处理
 */
-(void)showShareViewWithShareType:(SharePlatFormType)shareType shareButtonPressed:(ShareButtonPressed)shareButtonPressed shareCancelButtonTitle:(NSString *)shareCancelButtonTitle shareCancelButtonPressed:(ShareCancelButtonPressed)shareCancelButtonPressed;
/**
 *  显示分享界面
 *
 *  @param shareType          分享类型 可以传多个（ShareQQFriend|ShareQQSpace|ShareMessage|ShareSinaWeiBo）
 *  @param shareButtonPressed 分享按钮点击后的处理
 *  @param backGroundColor    分享视图的背景色
 */
-(void)showShareViewWithShareType:(SharePlatFormType)shareType shareViewBackgroundColor:(UIColor *)backGroundColor shareButtonPressed:(ShareButtonPressed)shareButtonPressed shareCancelButtonTitle:(NSString *)shareCancelButtonTitle shareCancelButtonPressed:(ShareCancelButtonPressed)shareCancelButtonPressed;
/*-------------版本更新说明--------------------*/
-(NSString *)frameWorkKitVersion;
-(NSString *)frameWorkKitVersionUpdateContent;







@end
