//
//  UITabBarItem+HHSoft.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-30.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (HHSoft)

/**
 *  设置item的标题 未选中的图片 选中的图片 未选中的文本颜色 选中的文本颜色
 *
 *  @param title           标题
 *  @param image           未选中的图片
 *  @param selectedImage   选中的图片
 *  @param normalTextColor 未选中的文本颜色
 *  @param selectTextColor 选中的文本颜色
 *
 *  @return
 */
-(id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage normalTextColor:(UIColor *)normalTextColor selectTextColor:(UIColor *)selectTextColor;

@end
