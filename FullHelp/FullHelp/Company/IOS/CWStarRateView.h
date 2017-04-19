//
//  CWStarRateView.h
//  StarRateDemo
//
//  Created by WANGCHAO on 14/11/4.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
//如果是评论的时候,starRateType=StarRateViewTypeComment;如果是在页面显示的时候starRateType=StarRateViewTypeShow;
typedef NS_ENUM(NSInteger, StarRateViewType) {
    StarRateViewTypeComment         ,//评论页
    StarRateViewTypeShow            ,//展示
};

@class CWStarRateView;

@protocol CWStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface CWStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO

@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property(nonatomic,assign) StarRateViewType starRateType;

@property (nonatomic, weak) id<CWStarRateViewDelegate>delegate;
/**
 *  初始化星星
 *
 *  @param frame         frame
 *  @param numberOfStars 几个星星
 *
 *  @return  instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
