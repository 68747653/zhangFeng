//
//  HHSoftSearchBar.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-25.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HHSfotSearchBarBeginEditing)(UISearchBar *searchBar);
typedef void(^HHSfotSearchBarTextChange)(UISearchBar *searchBar,NSString *searchText);
typedef void(^HHSfotSearchBarCancelButtonPressed)(UISearchBar *searchBar);
typedef void(^HHSfotSearchBarSearchButtonPressed)(UISearchBar *searchBar,NSString *searchText);

@interface HHSoftSearchBar : UISearchBar

/**
 *  初始化HHSoftSearchBar
 *
 *  @param frame           位置
 *  @param backgroundColor 背景颜色（可以是图片获取的颜色）
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)backgroundColor;
/**
 *  初始化HHSoftSearBar
 *
 *  @param frame                          位置
 *  @param backgroundColor                背景色
 *  @param searchTextFieldBackgroundColor 输入框的背景色
 *  @param borderColor                    输入框的边框颜色
 *  @param borderWidth                    输入框的边框宽度
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)backgroundColor searchTextFieldBackgroundColor:(UIColor *)searchTextFieldBackgroundColor searchTextFieldBorderColor:(UIColor *)borderColor searchTextFieldBorderWidth:(CGFloat)borderWidth;
/**
 *  初始化HHSoftSearBar
 *
 *  @param frame                          位置
 *  @param backgroundColor                背景色
 *  @param searchTextFieldBackgroundColor 输入框的背景色
 *  @param borderColor                    输入框的边框颜色
 *  @param borderWidth                    输入框的边框宽度
 *  @param radius                         输入框的弧度
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)backgroundColor searchTextFieldBackgroundColor:(UIColor *)searchTextFieldBackgroundColor searchTextFieldBorderColor:(UIColor *)borderColor searchTextFieldBorderWidth:(CGFloat)borderWidth searchTextFieldCornerRadius:(CGFloat)radius;

/**
 *  设置搜索框的placeholder和所使用的字体和颜色
 *
 *  @param placeholder     提示语
 *  @param placeFolderFont 提示语使用的字体
 *  @param placeHolderColr 提示语使用的颜色
 */
-(void)setPlaceholder:(NSString *)placeholder placeholderFont:(UIFont *)placeFolderFont placeHolderColor:(UIColor *)placeHolderColr;
/**
 *  设置搜索框的输入的文字的颜色和字体
 *
 *  @param textColor 文本颜色
 *  @param textFont  文本字体
 */
-(void)setTextColor:(UIColor *)textColor textFont:(UIFont *)textFont;
/**
 *  设置搜索框开始输入的时候执行的代码
 *
 *  @param searchBarBeginEditingBlock
 */
-(void)setSearchBarBeginEditing:(HHSfotSearchBarBeginEditing)searchBarBeginEditingBlock;
/**
 *  设置搜索框文本改变的时候执行的代码
 *
 *  @param searchBarTextChangeBlock
 */
-(void)setSearchBarTextChange:(HHSfotSearchBarTextChange)searchBarTextChangeBlock;
/**
 *  设置搜索框取消按钮的时候执行的代码
 *
 *  @param searchBarTextChangeBlock
 */
-(void)setSearchBarCancelButtonPressed:(HHSfotSearchBarCancelButtonPressed)searchBarCancelButtonPressedBlock;
/**
 *  设置搜索框搜索按钮点击的时候执行的代码
 *
 *  @param searchBarSearchButtonPressedBlock
 */
-(void)setSearchBarSearchButtonPressed:(HHSfotSearchBarSearchButtonPressed)searchBarSearchButtonPressedBlock;
/**
 *  设置是否显示编辑按钮（注意：如果为真的话，则在编辑的时候会出现取消按钮）
 *
 *  @param isShow 是否显示：默认不显示
 */
-(void)setCancelButtonShow:(BOOL)isShow;
/**
 *  设置取消按钮的字体颜色和字体
 *
 *  @param color 字体颜色
 *  @param font  字体
 *  @param text  按钮文本
 */
-(void)setCancelButtonTextColor:(UIColor *)color textFont:(UIFont *)font text:(NSString *)text;






@end
