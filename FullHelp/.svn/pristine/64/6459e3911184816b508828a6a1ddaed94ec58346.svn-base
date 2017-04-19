//
//  HHSoftPlayerView.m
//  JuZiJie
//
//  Created by hhsoft on 2016/11/17.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "HHSoftPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "HHSoftFullScreenViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "UIViewController+NavigationBar.h"

@interface HHSoftPlayerView ()

/** 
 背景imageView 
 */
@property (nonatomic, strong) UIImageView *imageView;
/** 
 工具条 
 */
@property (nonatomic, strong) UIView *toolView, *headView;
/** 
 退出全屏按钮 
 */
@property (nonatomic, strong) UIButton *backButton;

/** 
 滑动条 
 */
@property (nonatomic, strong) UISlider *progressSlider;
/** 
 时间Label 
 */
@property (nonatomic, strong) HHSoftLabel *timeLabel;
/** 
 总时间label 
 */
@property (nonatomic, strong) HHSoftLabel *allTimeLabel;
/** 
 全屏按钮 
 */
@property (nonatomic, strong) UIButton *fullScreenButton;
/** 
 屏幕中央的开始按钮 
 */
@property (nonatomic, strong) UIButton *playOrPauseBigButton;

/** 
 playerLayer 
 */
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

/** 
 playerItem 
 */
@property (nonatomic,strong) AVPlayerItem *playerItem;

/** 
 是否显示toolView 
 */
@property (nonatomic,assign) BOOL isShowToolView;

/** 
 toolView显示时间的timer 
 */
@property (nonatomic,strong) NSTimer *showTime;

/** 
 slider和播放时间定时器 
 */
@property (nonatomic,strong) NSTimer *progressTimer;

/** 
 全屏播放控制器 
 */
@property (nonatomic,strong) HHSoftFullScreenViewController *fullViewController;

/** 
 播放完毕遮盖View 
 */
@property (nonatomic, strong) UIView *coverView;

@end

@implementation HHSoftPlayerView

- (void)canclePlay {
    [self.player replaceCurrentItemWithPlayerItem:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isMinScreenPlay = YES;
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [UIColor blackColor];
        [self addSubview:_imageView];
        [self addSubview:self.headView];
        [self addSubview:self.toolView];
        [self addSubview:self.coverView];
        [self onInitData];
    }
    return self;
}

- (NSTimer *)progressTimer {
    if (!_progressTimer) {
        _progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    }
    return _progressTimer;
}

- (void)onInitData {
    // 隐藏遮盖版
    self.coverView.hidden = YES;
    
    //imageView添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.imageView addGestureRecognizer:tap];
    // 初始化player 和playerLayer
    self.player = [[AVPlayer alloc] init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    // imageView上添加playerLayer
    [self.imageView.layer addSublayer:self.playerLayer];
    
    // 设置工具栏状态
    self.toolView.alpha = 0;
    self.headView.alpha = 0;
    self.isShowToolView = NO;
    
    // 设置Slider
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    // 设置按钮状态
    self.playOrPauseButton.selected = NO;
}

/** layoutSubViews 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.imageView.bounds;
}

/** 需要播放的视频资源set方法 */
- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    [self playVideo];
}

/** 播放 */
- (void)playVideo {
    self.playOrPauseButton.selected = YES;
    // 替换界面
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
    [self addProgressTimer];
}

/** imageView的tap手势方法 */
-(void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.player.status == AVPlayerStatusUnknown) {
        [self playVideo];
        return;
    }
    self.isShowToolView = !self.isShowToolView;
    if (self.isShowToolView) {
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.alpha = 1;
            self.headView.alpha = 1;
        }];
        if (self.playOrPauseButton.selected) {
            [self addShowTime];
        }
    } else {
        [self removeShowTime];
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.alpha = 0;
            self.headView.alpha = 0;
        }];
    }
}

/** toolView显示时开始计时，5s后隐藏toolView */
- (void)addShowTime {
    self.showTime = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateToolView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:self.showTime forMode:NSRunLoopCommonModes];
}

/** 将toolView隐藏 */
- (void)updateToolView {
    self.isShowToolView = !self.isShowToolView;
    [UIView animateWithDuration:0.5 animations:^{
        self.toolView.alpha = 0;
        self.headView.alpha = 0;
    }];
    NSLog(@"timer显示或者隐藏");
}
- (void)removeShowTime {
    [self.showTime invalidate];
    self.showTime = nil;
}
/** toolView上暂停按钮的点击事件 */
- (void)playOrPauseButtonPress:(UIButton *)sender {
    // 播放状态按钮selected为YES,暂停状态selected为NO。
    sender.selected = !sender.selected;
    if (!sender.selected) {
        self.toolView.alpha = 1;
        self.headView.alpha = 1;
        [self removeShowTime];
        [self.player pause];
        [self removeProgressTimer];
    } else {
        [self addShowTime];
        [self.player play];
        [self addProgressTimer];
    }
}

/** slider定时器添加 */
- (void)addProgressTimer {
    [self progressTimer];
}
/** 移除slider定时器 */
- (void)removeProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
/** 更新slider和timeLabel */
- (void)updateProgressInfo {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    self.timeLabel.text = [self timeToStringWithTimeInterval:currentTime];
    self.allTimeLabel.text = [self timeToStringWithTimeInterval:durationTime];
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
    if (self.progressSlider.value == 1) {
        [self removeProgressTimer];
        self.coverView.hidden = NO;
        NSLog(@"播放完了");
    }
    
}

/** 转换播放时间和总时间的方法 */
- (NSString *)timeToStringWithTimeInterval:(NSTimeInterval)interval {
    NSInteger hours = interval / 60 / 60;
    NSInteger minutes = (NSInteger)(interval / 60) % 60;
    NSInteger seconds = (NSInteger)interval % 60;
    NSString *hoursStr, *minutesStr, *secondsStr;
    if (hours < 10) {
        hoursStr = [NSString stringWithFormat:@"0%@", @(hours)];
    } else {
        hoursStr = [@(hours) stringValue];
    }
    if (minutes < 10) {
        minutesStr = [NSString stringWithFormat:@"0%@", @(minutes)];
    } else {
        minutesStr = [@(minutes) stringValue];
    }
    if (seconds < 10) {
        secondsStr = [NSString stringWithFormat:@"0%@", @(seconds)];
    } else {
        secondsStr = [@(seconds) stringValue];
    }
    NSString *intervalString;
    if (hours > 1) {
        intervalString = [NSString stringWithFormat:@"%@:%@:%@", hoursStr, minutesStr, secondsStr];
    } else {
        intervalString = [NSString stringWithFormat:@"%@:%@", minutesStr, secondsStr];
    }
    return intervalString;
}

/** slider拖动和点击事件 */
- (void)touchDownSlider:(UISlider *)sender {
    // 按下去 移除监听器
    [self removeProgressTimer];
    [self removeShowTime];
}

- (void)valueChangedSlider:(UISlider *)sender {
    // 计算slider拖动的点对应的播放时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * sender.value;
    self.timeLabel.text = [self timeToStringWithTimeInterval:currentTime];
}

- (void)touchUpInside:(UISlider *)sender {
    [self addProgressTimer];
    //计算当前slider拖动对应的播放时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * sender.value;
    // 播放移动到当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self addShowTime];
}

/** 全屏按钮点击事件 */
- (void)fullViewButtonPress:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _backButton.hidden = NO;
        self.contrainerViewController.hhsoftNavigationBar.hidden = YES;
        self.contrainerView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width);
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
        [self.contrainerView setTransform:transform];
        self.contrainerView.center = self.contrainerViewController.view.center;
        self.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width);
        [self layoutFullScreenSubviewsWithFrame:self.frame];
    } else {
        _backButton.hidden = YES;
        self.contrainerViewController.hhsoftNavigationBar.hidden = NO;
        
        [UIView animateWithDuration:0.1 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*2);
            [self.contrainerView setTransform:transform];
            self.contrainerView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width*2/3);
            self.contrainerView.center = CGPointMake(CGRectGetWidth(self.contrainerView.frame)/2, CGRectGetHeight(self.contrainerView.frame)/2);
            self.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width*2/3);
            [self layoutFullScreenSubviewsWithFrame:self.frame];
        }];
        
    }
//    [self videoplayViewSwitchOrientation:sender.selected];
}

/** 弹出全屏播放器 */
- (void)videoplayViewSwitchOrientation:(BOOL)isFull {
    _isMinScreenPlay = !isFull;
    if (isFull) {
        [self.contrainerViewController presentViewController:self.fullViewController animated:NO completion:^{
            [self.fullViewController.view addSubview:self];
            self.center = self.fullViewController.view.center;
            _backButton.hidden = NO;
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = self.fullViewController.view.bounds;
                [self layoutFullScreenSubviewsWithFrame:self.frame];
            } completion:nil];
        }];
    } else {
        [self.fullViewController dismissViewControllerAnimated:NO completion:^{
            [self.contrainerViewController.view addSubview:self];
            _backButton.hidden = YES;
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.frame = CGRectMake(0, 0, self.contrainerViewController.view.bounds.size.width, self.contrainerViewController.view.bounds.size.width * 2 / 3);
                [self layoutFullScreenSubviewsWithFrame:self.frame];
            } completion:nil];
        }];
    }
}

- (void)layoutFullScreenSubviewsWithFrame:(CGRect)frame {
    _imageView.frame = frame;
    _headView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 44);
    HHSoftLabel *headLabel = (HHSoftLabel *)[self.headView viewWithTag:234];
    headLabel.frame = CGRectMake(50, 0, CGRectGetWidth(frame) - 100, 44);
    _toolView.frame = CGRectMake(0, CGRectGetHeight(frame) - 44, CGRectGetWidth(frame), 44);
    _timeLabel.frame = CGRectMake(49, 0, 55, 44);
    _progressSlider.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 5, 0, CGRectGetWidth(frame) - CGRectGetMaxX(_timeLabel.frame) - 5 - 109, 44);
    _allTimeLabel.frame = CGRectMake(CGRectGetMaxX(_progressSlider.frame) + 5, 0, 55, 44);
    _fullScreenButton.frame = CGRectMake(CGRectGetWidth(_toolView.frame) - 44, 0, 44, 44);
    _coverView.frame = frame;
    _playOrPauseBigButton.center = _coverView.center;;
}
#pragma mark - 懒加载代码
- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 44, CGRectGetWidth(self.frame), 44)];
        _toolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        _playOrPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"full_play_btn"] forState:UIControlStateNormal];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"full_pause_btn"] forState:UIControlStateSelected];
        [_playOrPauseButton addTarget:self action:@selector(playOrPauseButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_playOrPauseButton];
        
        _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_playOrPauseButton.frame) + 5, 0, 55, 44) fontSize:13.f text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_toolView addSubview:_timeLabel];
        
        _progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 5, 0, CGRectGetWidth(_toolView.frame) - CGRectGetMaxX(_timeLabel.frame) - 5 - 109, 44)];
        [_progressSlider addTarget:self action:@selector(touchDownSlider:) forControlEvents:UIControlEventTouchDown];
        [_progressSlider addTarget:self action:@selector(valueChangedSlider:) forControlEvents:UIControlEventValueChanged];
        [_progressSlider addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_progressSlider];
        
        _allTimeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_progressSlider.frame) + 5, 0, 55, 44) fontSize:12.f text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_toolView addSubview:_allTimeLabel];
        
        _fullScreenButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_toolView.frame) - 44, 0, 44, 44)];
        [_fullScreenButton setImage:[UIImage imageNamed:@"mini_launchFullScreen_btn"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"full_minimize_btn"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullViewButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_fullScreenButton];
    }
    return _toolView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.frame];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _playOrPauseBigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _playOrPauseBigButton.center = _coverView.center;
        [_playOrPauseBigButton setImage:[UIImage imageNamed:@"replay"] forState:UIControlStateNormal];
        [_playOrPauseBigButton addTarget:self action:@selector(repeatButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_coverView addSubview:_playOrPauseBigButton];
    }
    return _coverView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
        _headView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        HHSoftLabel *headLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(50, 0, CGRectGetWidth(_headView.frame) - 100, 44) fontSize:14.f text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        headLabel.tag = 234;
        [_headView addSubview:headLabel];
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 44, 44)];
        _backButton.hidden = YES;
        [_backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:_backButton];
    }
    return _headView;
}

- (HHSoftFullScreenViewController *)fullViewController {
    if (!_fullViewController) {
        _fullViewController = [[HHSoftFullScreenViewController alloc] init];
    }
    return _fullViewController;
}

- (void)backButtonPress:(UIButton *)sender {
    sender.hidden = YES;
//    _fullScreenButton.selected = NO;
    [self fullViewButtonPress:_fullScreenButton];
//    [self videoplayViewSwitchOrientation:NO];
}

/** 重播按钮点击 */
- (void)repeatButtonPress:(UIButton *)sender {
    self.progressSlider.value = 0;
    [self touchUpInside:self.progressSlider];
    self.coverView.hidden = YES;
    [self playVideo];
}

@end
