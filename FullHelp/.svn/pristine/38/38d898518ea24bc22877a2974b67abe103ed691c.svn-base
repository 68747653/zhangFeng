//
//  HHSoftBarButtonItem.h
//  MedicalCareFreeDoctor
//
//  Created by hhsoft on 2016/11/3.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ItemClickBlock)();
@interface HHSoftBarButtonItem : UIBarButtonItem
/**
 带尖头的返回按钮  相似度和系统的90% 默认白色
 */
-(instancetype)initBackButtonWithBackBlock:(ItemClickBlock)itemClickBlock;
/**
 带尖头的返回按钮  相似度和系统的90% 默认黑色
 */
- (instancetype)initBackButtonWithWhiteBackBlock:(ItemClickBlock)itemClickBlock;
/**
 带尖头的返回按钮  相似度和系统的90% 自定义图片
 */
- (instancetype)initBackButtonWithWhiteImgStr:(NSString *)backImgStr backBlock:(ItemClickBlock)itemClickBlock;

/**
 带回调的UIBarButtonItem

 @param title 标题
 @param itemClickBlock 回调事件
 */
- (instancetype)initWithitemTitle:(NSString *)title itemClickBlock:(ItemClickBlock)itemClickBlock;

/**
 带回调的UIBarButtonItem
 
 @param imageStr 图片
 @param itemClickBlock 回调事件
 */
- (instancetype)initWithImageStr:(NSString *)imageStr itemClickBlock:(ItemClickBlock)itemClickBlock;

@end
