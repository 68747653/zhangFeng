//
//  HHSoftTextView.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-1.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSoftTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;


/**
 *  初始化控件
 *
 *  @param frame    位置
 *  @param color    文本颜色
 *  @param font     文本字体
 *  @param delegate 代理
 *  @param placeholer      提示语
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame textColor:(UIColor *)color
          textFont:(UIFont *)font
          delegate:(id)delegate
 placeHolderString:(NSString *)placeholer;
/**
 *  初始化控件
 *
 *  @param frame            位置
 *  @param color            文本颜色
 *  @param font             文本字体
 *  @param delegate         代理
 *  @param placeholer       提示语
 *  @param placeHolderColor 提示语颜色
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame textColor:(UIColor *)color
          textFont:(UIFont *)font
          delegate:(id)delegate
 placeHolderString:(NSString *)placeholer
  placeHolderColor:(UIColor *)placeHolderColor;

@end
