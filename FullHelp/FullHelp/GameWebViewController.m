//
//  GameWebViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GameWebViewController.h"
#import "GlobalFile.h"
#import <WebKit/WebKit.h>
#import "GameInfo.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GameAdvertView.h"
#import "HHSoftBarButtonItem.h"
#import "RedPacketInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "RedPacketView.h"
#import "OpenRedPacketInfoViewController.h"
#import "MainTabBarController.h"
#import "MainNavgationController.h"
#import "RedPacketAdvertDetailViewController.h"
@interface GameWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) GameInfo *gameInfo;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger browseTime;
@property (nonatomic, strong) RedPacketView *redPacketView;
@property (nonatomic, strong) GameAdvertView *advertView;
@end

@implementation GameWebViewController
- (instancetype) initWithGameInfo:(GameInfo *)gameInfo {
    if (self = [super init]) {
        self.gameInfo = gameInfo;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _advertView = [[GameAdvertView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) clickBlock:^{
        RedPacketAdvertDetailViewController*redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] init];
        [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
        [_advertView removeFromSuperview];
    }];
    _advertView.advertImg = self.gameInfo.advertImg;
   [[UIApplication sharedApplication].keyWindow addSubview:_advertView];
    
    self.navigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        if (_browseTime>_gameInfo.gameBrowseTime&&!_gameInfo.isReceive) {
            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
            redPacketInfo.sendUserInfo.userHeadImg = _gameInfo.userInfo.userHeadImg;
            redPacketInfo.sendUserInfo.userNickName = _gameInfo.userInfo.userNickName;
            redPacketInfo.redPacketMemo = @"游戏红包";
            _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                _redPacketView.redPacketInfo.redPacketAmount = amount;
                OpenRedPacketInfoViewController*openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                MainTabBarController *mainTabBarController = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                MainNavgationController *nav = mainTabBarController.viewControllers[mainTabBarController.selectedIndex];
                [nav pushViewController:openRedPacketInfoViewController animated:YES];
                [_redPacketView removeFromSuperview];
            }];
            _redPacketView.redPacketType = RedPacketTypeGame;
            _redPacketView.advertID = _gameInfo.gameRedID;
            _redPacketView.redPacketInfo = redPacketInfo;
            [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];

        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCountDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:UITrackingRunLoopMode];
    [_countDownTimer fire];
    
    self.navigationItem.title = self.gameInfo.gameName;
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.gameInfo.gameUrl]]];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
}
#pragma mark ------ 倒计时
- (void)startTimeCountDown {
    _browseTime++;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
