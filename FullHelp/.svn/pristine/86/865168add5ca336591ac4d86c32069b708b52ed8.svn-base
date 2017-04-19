//
// UIScrollView+SVPullToRefresh.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>


@class HHSoftSVPullToRefreshView;

@interface UIScrollView (HHSoftSVPullToRefresh)

typedef NS_ENUM(NSUInteger, HHSoftSVPullToRefreshPosition) {
    SVPullToRefreshPositionTop = 0,
    SVPullToRefreshPositionBottom,
};

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler;
- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler position:(HHSoftSVPullToRefreshPosition)position;
- (void)triggerPullToRefresh;

@property (nonatomic, strong, readonly) HHSoftSVPullToRefreshView *pullToRefreshView;
@property (nonatomic, assign) BOOL showsPullToRefresh;

@end


typedef NS_ENUM(NSUInteger, HHSoftSVPullToRefreshState) {
    SVPullToRefreshStateStopped = 0,
    SVPullToRefreshStateTriggered,
    SVPullToRefreshStateLoading,
    SVPullToRefreshStateAll = 10
};

@interface HHSoftSVPullToRefreshView : UIView

@property (nonatomic, strong) UIColor *arrowColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subtitleLabel;
@property (nonatomic, strong, readwrite) UIColor *activityIndicatorViewColor NS_AVAILABLE_IOS(5_0);
@property (nonatomic, readwrite) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property (nonatomic, readonly) HHSoftSVPullToRefreshState state;
@property (nonatomic, readonly) HHSoftSVPullToRefreshPosition position;

- (void)setTitle:(NSString *)title forState:(HHSoftSVPullToRefreshState)state;
- (void)setSubtitle:(NSString *)subtitle forState:(HHSoftSVPullToRefreshState)state;
- (void)setCustomView:(UIView *)view forState:(HHSoftSVPullToRefreshState)state;

- (void)startAnimating;
- (void)stopAnimating;

// deprecated; use setSubtitle:forState: instead
@property (nonatomic, strong, readonly) UILabel *dateLabel DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) NSDate *lastUpdatedDate DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) NSDateFormatter *dateFormatter DEPRECATED_ATTRIBUTE;

// deprecated; use [self.scrollView triggerPullToRefresh] instead
- (void)triggerRefresh DEPRECATED_ATTRIBUTE;

@end
