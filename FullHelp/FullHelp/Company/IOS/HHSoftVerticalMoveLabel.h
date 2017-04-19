//
//  HHSoftVerticalMoveLabel.h
//  HHSoftProduct
//
//  Created by hhsoft on 2016/12/28.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickMessageBlock)(NSInteger clickIndex);
@interface HHSoftVerticalMoveLabel : UIView

/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 字体
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 切换消息所需时间 （需小于stayDuration）
 */
@property (nonatomic,assign) NSTimeInterval   scrollDuration;

/**
 消息在当前界面显示的时间（需大于scrollDuration）
 */
@property (nonatomic,assign) NSTimeInterval   stayDuration;

/**
 需要显示的信息(至少有一个值)
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *arrMessage;

/**
 点击消息回调
 */
@property (nonatomic, copy) ClickMessageBlock clickMessageBlock;

/**
 设置内容
 */
- (void)setTextColor:(UIColor *)textColor textFont:(UIFont *)textFont scrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration;

/**
 开始
 */
- (void)start;

/**
 停止 (点击界面返回按钮一定要调用此方法，否则计时器无法释放)
 */
- (void)stop;
@end
