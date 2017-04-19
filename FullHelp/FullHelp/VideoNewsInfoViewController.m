//
//  VideoNewsInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "VideoNewsInfoViewController.h"
#import <WebKit/WebKit.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftScrollView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftTextView.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "NewsInfo.h"
#import "ImageInfo.h"
#import "HHSoftPlayerView.h"
#import "HomeNetWorkEngine.h"
#import "UserInfoEngine.h"
#import "HHSoftBarButtonItem.h"
#import "AttentionNetWorkEngine.h"
#import "UserInfo.h"
#import "UIViewController+NavigationBar.h"

@interface VideoNewsInfoViewController () <WKNavigationDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger newsID, infoID;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NewsInfo *newsInfo;
@property (nonatomic, strong) HHSoftPlayerView *playerView;

@property (nonatomic, strong) UIBarButtonItem *collectionButton;
@property (nonatomic, copy) NSString *newsImage;

@end

@implementation VideoNewsInfoViewController

- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithNewsID:(NSInteger)newsID newsImage:(NSString *)newsImage infoID:(NSInteger)infoID {
    if (self = [super init]) {
        self.newsID = newsID;
        self.newsImage = newsImage;
        self.infoID = infoID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"资讯详情";
    //设置导航控制器的代理为self
    self.navigationController.delegate = self;
    //添加观察者 监听加载进度
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self loadData];
}

#pragma mark --- UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

- (void)setNavgationBar {
    [self addLucencyNavigationBar];
    [self.hhsoftNavigationBar.subviews.firstObject setAlpha:0];
    self.isRightAlpha = NO;
    //右上角收藏
    _collectionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collection_unselect"] style:UIBarButtonItemStylePlain target:self action:@selector(collectionRightBarButtonItemPressed)];
    _collectionButton.enabled = NO;
    self.hhsoftNaigationItem.rightBarButtonItem = _collectionButton;
    self.hhsoftNaigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithWhiteBackBlock:^{
        [self.playerView canclePlay];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.hhsoftNavigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark --- 收藏按钮点击事件
- (void)collectionRightBarButtonItemPressed {
    [self showWaitView:@"请稍等..."];
    
    [self addOrCancelCollectInfoWithUserID:[UserInfoEngine getUserInfo].userID CollectType:2 KeyID:_newsID];
}

#pragma mark --- 收藏接口
- (void)addOrCancelCollectInfoWithUserID:(NSInteger)userID
                             CollectType:(NSInteger)collectType
                                   KeyID:(NSInteger)keyID {
    self.view.userInteractionEnabled = NO;
    _collectionButton.enabled = NO;
    self.op = [[[AttentionNetWorkEngine alloc] init] addCollectOrCancelCollectWithUserID:userID collectType:collectType keyID:keyID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        _collectionButton.enabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"关注成功"];
                _collectionButton.image = [UIImage imageNamed:@"collection_select"];
            }
                break;
                
            case 101: {
                [self showErrorView:@"关注失败"];
            }
                break;
                
            case 103: {
                [self showSuccessView:@"取消关注成功"];
                _collectionButton.image = [UIImage imageNamed:@"collection_unselect"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"取消关注失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        _collectionButton.enabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

- (void)loadData {
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getNewsInfoWithUserID:[UserInfoEngine getUserInfo].userID newsID:_newsID infoID:_infoID];
}

- (void)getNewsInfoWithUserID:(NSInteger)userID newsID:(NSInteger)newsID infoID:(NSInteger)infoID {
    self.op = [[[HomeNetWorkEngine alloc] init] getNewsInfoWithUserID:userID newsID:newsID infoID:infoID successed:^(NSInteger code, NewsInfo *newsInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _newsInfo = newsInfo;
                [self.view addSubview:self.wkWebView];
                [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newsInfo.newsContent]]];
                [self.view addSubview:self.headerView];
                [self setNavgationBar];
                _collectionButton.enabled = YES;
                if (newsInfo.newsIsCollect) {
                    _collectionButton.image = [UIImage imageNamed:@"collection_select"];
                } else {
                    _collectionButton.image = [UIImage imageNamed:@"collection_unselect"];
                }
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getNewsInfoWithUserID:userID newsID:newsID infoID:infoID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getNewsInfoWithUserID:userID newsID:newsID infoID:infoID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getNewsInfoWithUserID:userID newsID:newsID infoID:infoID];
        }];
    }];
}

- (UIImageView *)headerView {
    if (!_headerView) {
//        CGSize size = [_newsInfo.newsTitle boundingRectWithfont:[UIFont systemFontOfSize:16.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, 1000)];
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * 2 / 3)];
        _headerView.userInteractionEnabled = YES;
        UIImageView *videoBackImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * 2 / 3)];
        videoBackImgView.layer.masksToBounds = YES;
        videoBackImgView.contentMode = UIViewContentModeScaleAspectFill;
        [videoBackImgView sd_setImageWithURL:[NSURL URLWithString:_newsImage] placeholderImage:[UIImage imageNamed:@"common_videobackground"]];
        videoBackImgView.userInteractionEnabled = YES;
        
        UIImageView *videoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        videoImgView.center = videoBackImgView.center;
        videoImgView.image = [UIImage imageNamed:@"news_video"];
        videoImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
        [videoImgView addGestureRecognizer:tap];
        [videoBackImgView addSubview:videoImgView];
        [_headerView addSubview:videoBackImgView];
        
//        HHSoftLabel *titleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(videoBackImgView.frame) + 10, [HHSoftAppInfo AppScreen].width - 30, 20) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
//        [_headerView addSubview:titleLabel];
//        CGSize titleSize = [_newsInfo.newsTitle boundingRectWithfont:[UIFont systemFontOfSize:16.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, 1000)];
//        titleLabel.frame = CGRectMake(15, CGRectGetMaxY(videoBackImgView.frame) + 10, [HHSoftAppInfo AppScreen].width - 30, titleSize.height);
//        titleLabel.text = _newsInfo.newsTitle;
    }
    return _headerView;
}

- (HHSoftPlayerView *)playerView {
    if (!_playerView) {
        //更改frame时也要更改全屏转小屏之后的frame
        _playerView = [[HHSoftPlayerView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * 2 / 3)];
        _playerView.contrainerViewController = self;
    }
    return _playerView;
}

- (void)tapImageView {
    [self.headerView addSubview:self.playerView];
    self.playerView.contrainerView = self.headerView;
    self.playerView.urlString = _newsInfo.newsLinkUrl;
}

- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].width * 2 / 3, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-[HHSoftAppInfo AppScreen].width * 2 / 3)];
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
    }
    return _wkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.wkWebView.frame), 4)];
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        [self.wkWebView addSubview:_progressView];
    }
    return _progressView;
}

#pragma mark --- 页面开始加载时
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
#pragma mark --- 内容开始返回时
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}
#pragma mark --- 页面加载完成时
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self hideLoadingView];
    [webView stopLoading];
}
#pragma mark --- 页面加载失败时
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self hideLoadingView];
    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]]];
    }];
    [webView stopLoading];
}

#pragma mark --- Observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object==self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
