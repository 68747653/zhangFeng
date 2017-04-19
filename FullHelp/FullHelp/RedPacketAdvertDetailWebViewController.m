//
//  RedPacketAdvertDetailWebViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedPacketAdvertDetailWebViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"

@interface RedPacketAdvertDetailWebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,copy) NSString *webURL;
@property (nonatomic,copy) RedPacketAdvertDetailWebViewControllerDropDownBlock dropDownBlock;
@property (nonatomic,strong) HHSoftLabel *hintLabel;

@end

@implementation RedPacketAdvertDetailWebViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithWebURL:(NSString *)webURL DropDownBlock:(RedPacketAdvertDetailWebViewControllerDropDownBlock)dropDownBlock{
    if(self = [super init]){
        _webURL = webURL;
        _dropDownBlock = dropDownBlock;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50)];
    webView.backgroundColor = [GlobalFile backgroundColor];
    webView.scrollView.delegate = self;
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]]];
    [self.view addSubview:webView];
    
    _hintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 30) fontSize:14.0 text:@"下拉返回广告详情" textColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    _hintLabel.alpha = 0;
    [self.view addSubview:_hintLabel];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.hintLabel.alpha = scrollView.contentOffset.y/-70;
    if (scrollView.contentOffset.y > -70) {
        _hintLabel.text = @"下拉返回广告详情";
    }else if (scrollView.contentOffset.y < -70) {
        _hintLabel.text = @"释放返回广告详情";
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < -70) {
        _dropDownBlock();
    }
}

@end
