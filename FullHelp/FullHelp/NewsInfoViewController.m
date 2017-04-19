//
//  NewsInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "NewsInfoViewController.h"
#import <WebKit/WebKit.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "UserCenterNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AttentionNetWorkEngine.h"
#import "HomeNetWorkEngine.h"
#import "NewsInfo.h"

@interface NewsInfoViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger newsID, infoID;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIBarButtonItem *collectionButton;

@end

@implementation NewsInfoViewController

- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithUrl:(NSString *)url newsID:(NSInteger)newsID infoID:(NSInteger)infoID {
    if (self = [super init]) {
        self.url = url;
        self.newsID = newsID;
        self.infoID = infoID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加观察者 监听加载进度
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"资讯详情";
    [self setNavgationBar];
    
    [self loadData];
}

- (void)setNavgationBar {
    //右上角收藏
    _collectionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collection_unselect"] style:UIBarButtonItemStylePlain target:self action:@selector(collectionRightBarButtonItemPressed)];
    _collectionButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = _collectionButton;
    self.navigationItem.rightBarButtonItem.tintColor = [GlobalFile themeColor];
}

#pragma mark --- 收藏按钮点击事件
- (void)collectionRightBarButtonItemPressed {
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    _collectionButton.enabled = NO;
    [self addOrCancelCollectInfoWithUserID:[UserInfoEngine getUserInfo].userID CollectType:2 KeyID:_newsID];
}

#pragma mark --- 收藏接口
- (void)addOrCancelCollectInfoWithUserID:(NSInteger)userID
                             CollectType:(NSInteger)collectType
                                   KeyID:(NSInteger)keyID {
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
                _collectionButton.enabled = YES;
                if (newsInfo.newsIsCollect) {
                    _collectionButton.image = [UIImage imageNamed:@"collection_select"];
                } else {
                    _collectionButton.image = [UIImage imageNamed:@"collection_unselect"];
                }
                [self.view addSubview:self.wkWebView];
                [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newsInfo.newsLinkUrl]]];
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


- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64)];
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
