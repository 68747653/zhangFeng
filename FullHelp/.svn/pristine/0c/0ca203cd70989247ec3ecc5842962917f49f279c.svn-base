//
//  HHSoftButton.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-12.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VerfyCodeButtonPresseBlock)();

@interface HHSoftButton : UIButton


/**
 *  常规的一种初始化方法
 *
 *  @param buttonType 按钮类型
 *  @param frame      frame
 *  @param titleColor 字体颜色
 *  @param size       字体大小
 *
 *  @return UIButton
 */
+ (id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame titleColor:(UIColor *)titleColor titleSize:(CGFloat)size;

/**
 *  图片文字混排的按钮初始化
 *
 *  @param buttonType     按钮类型
 *  @param frame          位置
 *  @param innerImage     图片
 *  @param innerImageRect 图片位置
 *  @param descTextRect   文字位置
 *  @param descText       文字内容
 *  @param textColor      文字字体颜色
 *  @param textFont       文字字体
 *  @param alignment      文字对齐方式
 *
 *  @return UIBUtton
 */
-(id)initWithFrame:(CGRect)frame innerImage:(UIImage *)innerImage innerImageRect:(CGRect)innerImageRect descTextRect:(CGRect)descTextRect descText:(NSString *)descText textColor:(UIColor *)textColor textFont:(UIFont *)textFont textAligment:(NSTextAlignment)alignment;

/**
 *  设置图文混排的选中的图片和选中的文字和字体
 *
 *  @param selectImage 选中的图片
 *  @param descText    选中的标题
 *  @param textColor   选中的文字颜色
 *  @param textFont    选中的文字
 */
-(void)setSelectImage:(UIImage *)selectImage descText:(NSString *)descText textColor:(UIColor *)textColor textFont:(UIFont *)textFont;


/**
 *  获取验证码的按钮初始化
 *
 *  @param frame                     位置
 *  @param timeInterval              过几秒后能重新点击（时间差）
 *  @param normalButtonTitle         可以点击的时候的按钮标题
 *  @param normalButtonFont          可以点击的时候的按钮字体
 *  @param normalButtonTitleColor    可以点击的时候按钮字体颜色
 *  @param countDownButtonFont       倒计时时候按钮的字体
 *  @param countDownButtonTitleColor 倒计时时候按钮的字体颜色
 *  @param block                     可以点击的时候执行的代码
 *
 *  @return UIButton
 */
-(id)initWithFrame:(CGRect)frame canPressButtonTimeInterval:(CGFloat)timeInterval normalButtonTitle:(NSString *)normalButtonTitle normalButtonFont:(UIFont *)normalButtonFont normalButtonTitleColor:(UIColor *)normalButtonTitleColor countDownButtonFont:(UIFont *)countDownButtonFont countDownButtonTitleColor:(UIColor *)countDownButtonTitleColor normalButtonPressWithBlock:(VerfyCodeButtonPresseBlock)block;




@end
