//
//  HHSoftInputLabel.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-11.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import "HHSoftLabel.h"

/**
 *  点击后的回调函数
 */
typedef void(^HHSoftInputLabelPressSuccessedBlock)();


@interface HHSoftInputLabel : HHSoftLabel
/**
 *  回调函数
 */
@property(nonatomic,strong) HHSoftInputLabelPressSuccessedBlock pressedSuccessedBlock;

/**
 *  初始化带回调函数的初始化方法
 *
 *  @param frame        位置
 *  @param fontsize     字体大小
 *  @param text         文本内容
 *  @param textcolor    字体颜色
 *  @param alignment    文字展示方式
 *  @param lines        行数
 *  @param successBlock 点击后的回调函数
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontsize text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)lines withPressSuccessBlock:(HHSoftInputLabelPressSuccessedBlock)successBlock;

/**
 *  初始化带回调函数的初始化方法
 *
 *  @param frame        位置
 *  @param fontsize     字体大小
 *  @param text         文本内容
 *  @param textcolor    字体颜色
 *  @param alignment    文字展示方式
 *  @param lines        行数
 *  @param breakModel   文本断行方式
 *  @param successBlock 点击后的回调函数
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontsize text:(NSString *)text textColor:(UIColor *)textcolor textAlignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)breakModel withPressSuccessBlock:(HHSoftInputLabelPressSuccessedBlock)successBlock;





@end
