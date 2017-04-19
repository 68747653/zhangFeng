//
//  WKWebViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "UserCenterNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserLoginNetWorkEngine.h"
#import "WKWebViewController.h"

@interface WKWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) WKWebType wkWebType;
@property (nonatomic, assign) NSInteger messageID;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic,copy) NSString *messageContent;
@property (nonatomic, copy) GetMessageDetailSuccessed successed;

@end

@implementation WKWebViewController
-(void)dealloc{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
-(instancetype)initWithUrl:(NSString *)url WkWebType:(WKWebType)wkWebType MessageTitle:(NSString *)messageTitle{
    if (self = [super init]) {
        _url = url;
        _wkWebType = wkWebType;
        self.navigationItem.title = messageTitle;
    }
    return self;
}
-(instancetype)initWithMessageID:(NSInteger)messageID WkWebType:(WKWebType)wkWebType MessageTitle:(NSString *)messageTitle successed:(GetMessageDetailSuccessed)successed {
    if (self = [super init]) {
        _messageID = messageID;
        _wkWebType = wkWebType;
        self.navigationItem.title = messageTitle;
        self.successed = successed;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加观察者 监听加载进度
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    if (_wkWebType == WKWebTypeWithAdvertType) {
        [self.view addSubview:self.wkWebView];
        [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]]];
    } else if (_wkWebType == WKWebTypeWithAboutOur){
        [self userHelpDetailWithHelpID:1];
    } else if (_wkWebType == WKWebTypeWithRegist){
        [self userHelpDetailWithHelpID:2];
    } else if (_wkWebType == WKWebTypeWithHelp){
        [self userHelpDetailWithHelpID:3];
    } else if (_wkWebType == WKWebTypeWithLevel){
        [self userHelpDetailWithHelpID:4];
    } else if (_wkWebType == WKWebTypeWithMessage){
        [self getSystemInfoWithSystemID:_messageID];
    } else{
        
    }
}
//1关于我们，2注册协议，3使用帮助，4等级规则
- (void)userHelpDetailWithHelpID:(NSInteger)helpID {
    self.op = [[[UserLoginNetWorkEngine alloc] init] getUserHelpWithHelpID:helpID successed:^(NSInteger code, NSString *detailUrl) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _url = detailUrl;
                [self.view addSubview:self.wkWebView];
                [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]]];
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self userHelpDetailWithHelpID:helpID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self userHelpDetailWithHelpID:helpID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self userHelpDetailWithHelpID:helpID];
        }];
    }];
}
//获取系统详情
- (void)getSystemInfoWithSystemID:(NSInteger)messageID {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getSystemInfoWithSystemID:messageID userID:[UserInfoEngine getUserInfo].userID successed:^(NSInteger code, NSString *messageContent) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                if (_successed) {
                    _successed(messageID);
                }
                [self.view addSubview:self.wkWebView];
                [_wkWebView loadHTMLString:messageContent baseURL:nil];
                //                [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:messageContent]]];
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getSystemInfoWithSystemID:messageID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getSystemInfoWithSystemID:messageID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getSystemInfoWithSystemID:messageID];
        }];
    }];
}
-(WKWebView *)wkWebView{
    if (_wkWebView == nil) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64)];
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
    }
    return _wkWebView;
}
-(UIProgressView *)progressView{
    if (nil==_progressView) {
        _progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.wkWebView.frame), 4)];
        _progressView.progressTintColor=[UIColor blueColor];
        _progressView.trackTintColor=[UIColor whiteColor];
        [self.wkWebView addSubview:_progressView];
    }
    return _progressView;
}
#pragma mark --- 页面开始加载时
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
#pragma mark --- 内容开始返回时
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}
#pragma mark --- 页面加载完成时
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self hideLoadingView];
    if (_wkWebType == WKWebTypeWithMessage) {
        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '290%'" completionHandler:nil];
    }
    [webView stopLoading];
}
#pragma mark --- 页面加载失败时
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self hideLoadingView];
    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]]];
    }];
    [webView stopLoading];
}
#pragma mark - Observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object==self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
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
