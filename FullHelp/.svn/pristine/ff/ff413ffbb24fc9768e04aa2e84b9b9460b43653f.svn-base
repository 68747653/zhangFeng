//
//  HHSoftUnderLineLabel.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-11.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import "HHSoftLabel.h"

/**
 线的位置
 */
typedef enum : NSUInteger {
    HHSoftUnderLine=0,//下划线
    HHSoftStrokeLine=1,//删除线
    HHSoftLeftLine=2,//左侧线
    HHSoftRightLine=3//右侧线
} HHSoftLabelLineType;

@interface HHSoftLineLabel : HHSoftLabel

@property (nonatomic,assign) HHSoftLabelLineType labelLineType;
/**
 *  线的宽度（如果为下划线或者删除线的话为线的高度）
 */
@property (nonatomic,assign) CGFloat labelLineWidth;
/**
 *  线的颜色（RGB+Alpha的数组【R、G、B、Alpha】）
 */
@property (nonatomic,strong) NSArray *arrStrikeThroughRGBAlpha;
/**
 *  当线在左侧的时候，线据左侧的位置
 */
@property (nonatomic,assign) CGFloat labelLeftSpace;
/**
 *  下划线的时候，据底部的距离
 */
@property (nonatomic,assign) CGFloat labelUnderSpace;
/**
 *  线在右侧的时候，据右侧的距离
 */
@property (nonatomic,assign) CGFloat labelRightSpace;
/**
 *  线在左侧的时候，线的高度
 */
@property (nonatomic,assign) CGFloat labelLeftHeight;
/**
 *  线在右侧的时候，线的高度
 */
@property (nonatomic,assign) CGFloat labelRightHeight;


@end
