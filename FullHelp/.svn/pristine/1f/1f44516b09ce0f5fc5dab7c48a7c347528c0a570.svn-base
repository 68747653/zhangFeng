//
//  HHSoftPlayerView.h
//  JuZiJie
//
//  Created by hhsoft on 2016/11/17.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoNewsInfoViewController.h"

@class AVPlayer;

@interface HHSoftPlayerView : UIView

/** 
 player 
 */
@property (nonatomic,strong) AVPlayer *player;

/** 
 开始暂停按钮 
 */
@property (nonatomic, strong) UIButton *playOrPauseButton;

/** 
 需要播放的视频资源 
 */
@property (nonatomic, copy) NSString *urlString;

/* 
 包含在哪一个控制器中 
 */
@property (nonatomic, strong) VideoNewsInfoViewController *contrainerViewController;
@property (nonatomic, strong) UIView *contrainerView;
/**
 是否小屏播放
 */
@property (nonatomic, assign) BOOL isMinScreenPlay;

- (instancetype)initWithFrame:(CGRect)frame;

/** 
 toolView上暂停按钮的点击事件 
 */
- (void)playOrPauseButtonPress:(UIButton *)sender;

- (void)canclePlay;

@end
