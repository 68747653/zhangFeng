//
//  HomeViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "HomeViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "UIViewController+NavigationBar.h"
#import "HHSoftBarButtonItem.h"
#import "HHSoftGraphicMixedButton.h"
#import "UserInfo.h"
#import "HomeInfo.h"
#import "HomeNetWorkEngine.h"
#import "UserInfoEngine.h"
#import <HHSoftFrameWorkKit/HHSoftPageControl.h>
#import <HHSoftFrameWorkKit/HHSoftAutoCircleScrollView.h>
#import "AdvertInfo.h"
#import "CategoryView.h"
#import "HHSoftVerticalMoveLabel.h"
#import "NewsInfo.h"
#import "ActivityView.h"
#import "RedPacketAdvertCell.h"
#import "ActivityInfo.h"
#import "HotRedPacketListViewController.h"
#import "GrabRedPacketListViewController.h"
#import "NewRedPacketListViewController.h"
#import "HomeRedPacketCell.h"
#import "RedPacketAdvertDetailViewController.h"
#import "HomeRedPacketView.h"
#import "RegionViewController.h"
#import "RedPacketView.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "RedPacketInfo.h"
#import "OpenRedPacketInfoViewController.h"
#import "NewsViewController.h"
#import "IndustryInfo.h"
#import "HHSoftHeader.h"
#import "RegionInfo.h"
#import "RedPacketNeedsListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import "TodayRedPacketListViewController.h"
#import "SceneRedPacketViewController.h"
#import "GameListViewController.h"
#import "WKWebViewController.h"
#import "SearchHistoryViewController.h"
#import "PredictRedViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HomeRedPackerViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic,strong) HHSoftGraphicMixedButton *cityButton;
@property (nonatomic, strong) HomeInfo *homeInfo;
@property (nonatomic, strong) NSMutableArray *advertImgArray;
@property (nonatomic,strong) HHSoftAutoCircleScrollView *advertScrollView;
@property (nonatomic,strong) HHSoftPageControl *pageControl;
@property (nonatomic, assign)  CGFloat headerViewH;
@property (nonatomic, assign)  CGFloat activityViewH;
@property (nonatomic, strong) UIScrollView *redPacketScrollView;
@property (nonatomic, strong) UIView *newsView;
@property (nonatomic, strong) HHSoftVerticalMoveLabel *newsLabel;
@property (nonatomic, strong) UIView *activityView;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, copy) NSString *countDownStr;
@property (nonatomic, strong) HHSoftLabel *countDownLabel;
@property (nonatomic, strong) RedPacketView *redPacketView;
/**
 活动剩余时间
 */
@property (nonatomic, assign) NSInteger restTime;
@property (nonatomic, assign) BOOL showBarWhenPush;

@end

@implementation HomeViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ChooseIndustryInfoNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_showBarWhenPush) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    _showBarWhenPush = YES;
}
- (void)chooseIndustryInfoNotification {
    _cityButton.buttonTitle = [NSString stringWithFormat:@"%@%@",[RegionInfo getRegionInfo].provinceName,[IndustryInfo getIndustryInfo].industryName];
    [self getHomeData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _showBarWhenPush = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseIndustryInfoNotification) name:ChooseIndustryInfoNotification object:nil];
    _headerViewH = [HHSoftAppInfo AppScreen].width/2;
    _activityViewH = ([HHSoftAppInfo AppScreen].width-5)/2/5*4;
    [self.dataTableView reloadData];
    [self setNavigationItem];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getHomeData];
}
#pragma mark ------ 获取首页数据
- (void)getHomeData {
    [[[HomeNetWorkEngine alloc] init] getHomeDataWithUserID:[UserInfoEngine getUserInfo].userID industryID:[IndustryInfo getIndustryInfo].industryID successed:^(NSInteger code, HomeInfo *homeInfo) {
        
        switch (code) {
            case 100:
            {
                self.view.backgroundColor = [GlobalFile backgroundColor];
                [self hideLoadingView];
                _homeInfo = homeInfo;
                [self.dataTableView reloadData];
                _advertImgArray = [[NSMutableArray alloc] init];
                for (AdvertInfo *advertInfo in homeInfo.arrAdvert) {
                    if (advertInfo.advertImg.length) {
                        [_advertImgArray addObject:advertInfo.advertImg];
                    }else{
                        [_advertImgArray addObject:@"123"];
                    }
                }
                if (homeInfo.arrAdvert.count>0&&homeInfo.arrAdvert.count!=1) {
                    _advertScrollView.scrollEnabled = YES;
                    _pageControl.numberOfPages = _advertImgArray.count;

                }
                else if (homeInfo.arrAdvert.count==1) {
                    _advertScrollView.scrollEnabled = NO;
                    _pageControl.numberOfPages = 0;
                }
                else if (!homeInfo.arrAdvert.count) {
                    _advertScrollView.scrollEnabled = NO;
                    _pageControl.numberOfPages = 0;
                    [_advertImgArray addObject:@"123"];
                }

                [_advertScrollView updateArrScrollImg:_advertImgArray];

                if (homeInfo.arrRedClass.count&&!_redPacketScrollView) {
                    [_headerView addSubview:self.redPacketScrollView];
                }
                [_newsView removeFromSuperview];
                _newsView = nil;
                if (homeInfo.arrNews.count && !_newsView) {
                    [_headerView addSubview:self.newsView];
                }
                [_activityView removeFromSuperview];
                _activityView = nil;
                if (homeInfo.arrActivity.count && !_activityView) {
                    [_headerView addSubview:self.activityView];
                }
                //弹出注册红包
                if ([UserInfoEngine getUserInfo].userRedNum > 0) {
                    RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
                    redPacketInfo.sendUserInfo.userHeadImg = @"Icon.png";
                    redPacketInfo.sendUserInfo.userNickName = [HHSoftAppInfo AppName];
                    redPacketInfo.redPacketMemo = @"注册红包";
                    _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                        _showBarWhenPush = NO;
                        _redPacketView.redPacketInfo.redPacketAmount = amount;
                        OpenRedPacketInfoViewController*openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                        openRedPacketInfoViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:openRedPacketInfoViewController animated:YES];
                        [_redPacketView removeFromSuperview];
                    }];
                    _redPacketView.redPacketType = RedPacketTypeRegister;
                    _redPacketView.redPacketInfo = redPacketInfo;
                    [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
                    UserInfo *userInfo = [UserInfoEngine getUserInfo];
                    userInfo.userRedNum = 0;
                    [UserInfoEngine setUserInfo:userInfo];
                }
                
                //切换行业
                HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
                if ([[defaults objectForKey:IsOpenAgin] isEqualToString:@"0"]) {
                    [defaults saveObject:@"1" forKey:IsOpenAgin];
                    if ([UserInfoEngine getUserInfo].userIndustryID != [IndustryInfo getIndustryInfo].industryID) {
                        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:@"当前所在行业与您的行业不一致,是否要切换" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            IndustryInfo *info = [[IndustryInfo alloc] init];
                            info.industryID = [UserInfoEngine getUserInfo].userIndustryID;
                            info.industryName = [UserInfoEngine getUserInfo].userIndustryName;
                            [IndustryInfo setIndustryInfo:info];
                            [[NSNotificationCenter defaultCenter] postNotificationName:ChooseIndustryInfoNotification object:nil];
                            
                        }];
                        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:confirm];
                        [alertController addAction:cancle];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }
            }
                break;
            case 103:{
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:@"该用户已禁用" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self hideLoadingView];
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getHomeData];
                }];
            }
                break;
            default:{
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self hideLoadingView];
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getHomeData];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadError] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self hideLoadingView];
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getHomeData];
        }];
    }];
}
#pragma mark ------ 设置导航栏
- (void)setNavigationItem {
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile colorWithRed:250 green:250 blue:250 alpha:1];
    [self addLucencyNavigationBar];
    
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    textAttributesDict[NSForegroundColorAttributeName] = [HHSoftAppInfo defaultDeepSystemColor];
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [self.hhsoftNavigationBar setTitleTextAttributes:textAttributesDict];
    [self.hhsoftNavigationBar setTintColor:[HHSoftAppInfo defaultDeepSystemColor]];
    [self.hhsoftNavigationBar setBackgroundImage:[GlobalFile imageWithColor:[UIColor whiteColor] size:CGSizeMake([HHSoftAppInfo AppScreen].width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.hhsoftNavigationBar setShadowImage:[UIImage new]];
    
    _cityButton = [[HHSoftGraphicMixedButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40) imgSize:CGSizeMake(19, 25)];
    _cityButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cityButton.buttonTitle = [NSString stringWithFormat:@"%@%@",[RegionInfo getRegionInfo].provinceName,[IndustryInfo getIndustryInfo].industryName];
    [_cityButton setImage:[UIImage imageNamed:@"city_arrow.png"] forState:UIControlStateNormal];
    [_cityButton setImage:[UIImage imageNamed:@"city_arrow.png"] forState:UIControlStateHighlighted];
    [_cityButton addTarget:self action:@selector(selectCityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.hhsoftNaigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_cityButton];
    //搜索UITextField
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, [HHSoftAppInfo AppScreen].width-105, 30)];
    searchTextField.layer.cornerRadius = 3;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    searchTextField.font = [UIFont systemFontOfSize:13];
    searchTextField.textColor = [HHSoftAppInfo defaultLightSystemColor];
    searchTextField.delegate = self;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    NSDictionary *dicAtt = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
    NSAttributedString *placaholder = [[NSAttributedString alloc] initWithString:@"搜索广告、供应商、关键词" attributes:dicAtt];
    searchTextField.attributedPlaceholder = placaholder;
    self.searchTextField = searchTextField;
    //搜索框view
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5, 30, 15)];
    searchImgView.contentMode = UIViewContentModeCenter;
    searchImgView.image = [UIImage imageNamed:@"search.png"];
    searchTextField.leftView = searchImgView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.hhsoftNaigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchTextField];
}
#pragma mark ------ headerView
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _headerViewH+90+10+40+10+_activityViewH+20+10)];
        [_headerView addSubview:self.advertScrollView];
        [_headerView addSubview:self.pageControl];
        
        if (_advertImgArray.count>1) {
            _advertScrollView.scrollEnabled = YES;
        }else{
            _advertScrollView.scrollEnabled = NO;
        }

    }
    return _headerView;
}
#pragma mark --- 广告轮播
-(HHSoftAutoCircleScrollView *)advertScrollView{
    if (_advertScrollView==nil) {
        _advertScrollView = [[HHSoftAutoCircleScrollView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _headerViewH) arrScrollImg:@[@""] placeHolderimg:[GlobalFile HHSoftDefaultImg2_1] backgroundImage:nil timeInterval:3 imgTap:^(NSInteger currentIndex) {
            //广告点击回调
            if (self.homeInfo.arrAdvert) {
                AdvertInfo *advertInfo = self.homeInfo.arrAdvert[currentIndex];
                switch (advertInfo.advertType) {
                    case 0: {//无动作
                    }
                        break;
                        
                    case 1:  //图文详情
                    case 2: {//外部链接
                        WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:advertInfo.linkUrl WkWebType:WKWebTypeWithAdvertType MessageTitle:advertInfo.advertTitle];
                        wkWebViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:wkWebViewController animated:YES];
                    }
                        break;
                        
                    case 3: {//现金红包详情
                        RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:advertInfo.advertID];
                        redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        } scrollEvent:^(NSInteger currentIndex) {
            self.pageControl.currentPage =currentIndex;
        }];
    }
    return _advertScrollView;
}
#pragma mark --- 初始化pageControl
-(HHSoftPageControl *)pageControl{
    if (_pageControl==nil) {
        _pageControl = [[HHSoftPageControl alloc] initWithFrame:CGRectMake(0,_headerViewH-30, [HHSoftAppInfo AppScreen].width, 30) pageCount:_advertImgArray.count currentPageImage:[UIImage imageNamed:@"page_bannerselect.png"] pageIndicatorImage:[UIImage imageNamed:@"page_banneruncheck.png"] dotWidth:6.5 dotHeigth:6.5];
        _pageControl.userInteractionEnabled = NO;
        if (_advertImgArray.count>1) {
            _pageControl.numberOfPages = _advertImgArray.count;
        }else{
            _pageControl.numberOfPages = 0;
            self.pageControl.currentPage=0;
        }
    }
    return _pageControl;
}
#pragma mark ------ 红包类别
- (UIScrollView *)redPacketScrollView {
    if (!_redPacketScrollView) {
        _redPacketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerViewH, [HHSoftAppInfo AppScreen].width, 90)];
        _redPacketScrollView.contentSize = CGSizeMake(90*self.homeInfo.arrRedClass.count, 0);
        _redPacketScrollView.backgroundColor = [UIColor whiteColor];
        _redPacketScrollView.showsHorizontalScrollIndicator = NO;
        for (NSInteger i=0; i<self.homeInfo.arrRedClass.count; i++) {
            CategoryView *categoryView = [[CategoryView alloc] initWithFrame:CGRectMake(i*90, 0, 90, 90) imgSize:CGSizeMake(60, 60) isShowName:YES isRound:NO chooseCategory:^(id info) {
                RedPacketInfo *redPacketInfo = info;
                switch (redPacketInfo.redPacketID) {
                    case 1: {//预报红包
                        PredictRedViewController *predictRedViewController = [[PredictRedViewController alloc] init];
                        predictRedViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:predictRedViewController animated:YES];
                    }
                        break;
                        
                    case 2:
                    {
                        //今日红包
                        TodayRedPacketListViewController*todayRedPacketListViewController = [[TodayRedPacketListViewController alloc] init];
                        todayRedPacketListViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:todayRedPacketListViewController animated:YES];
                    }
                        break;
                    case 3:
                    {
                        //需求红包
                        RedPacketNeedsListViewController*redPacketNeedsListViewController = [[RedPacketNeedsListViewController alloc] initWithNeedsType:NeedsTypeMerchant];
                        redPacketNeedsListViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:redPacketNeedsListViewController animated:YES];
                        
                    }
                        break;
                    case 4:
                    {
                        //公示公告
                        RedPacketNeedsListViewController*redPacketNeedsListViewController = [[RedPacketNeedsListViewController alloc] initWithNeedsType:NeedsTypeSupplier];
                        redPacketNeedsListViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:redPacketNeedsListViewController animated:YES];
                        

                    }
                        break;
                    case 5:
                    {
                        //游戏红包
                        GameListViewController*gameListViewController = [[GameListViewController alloc] init];
                        gameListViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:gameListViewController animated:YES];
                    }
                    break;
                    case 6:
                    {
                        SceneRedPacketViewController*sceneRedPacketViewController = [[SceneRedPacketViewController alloc] init];
                        sceneRedPacketViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:sceneRedPacketViewController animated:YES];
                    }
                    break;
                    case 7: {//行业资讯
                        NewsViewController *newsViewController = [[NewsViewController alloc] init];
                        newsViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:newsViewController animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }];
            categoryView.redPacketInfo = self.homeInfo.arrRedClass[i];
            [_redPacketScrollView addSubview:categoryView];
            
        }
    }
    return _redPacketScrollView;
}
#pragma mark ------ 滚动新闻view
- (UIView *)newsView {
    if (!_newsView) {
        _newsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_redPacketScrollView.frame)+10, [HHSoftAppInfo AppScreen].width, 40)];
        _newsView.backgroundColor = [UIColor whiteColor];
        UIImageView *trumpetImgView = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, 10, 20, 20)];
        trumpetImgView.image = [UIImage imageNamed:@"trumpet.png"];
        [_newsView addSubview:trumpetImgView];
        
        
        NSMutableArray *arrNewsTitle = [NSMutableArray array];
        for (NewsInfo *newsInfo in self.homeInfo.arrNews) {
            [arrNewsTitle addObject:newsInfo.newsTitle];
        }
        _newsLabel = [[HHSoftVerticalMoveLabel alloc] initWithFrame:CGRectMake(40, 0, [HHSoftAppInfo AppScreen].width-50, 40)];
        
        _newsLabel.arrMessage = arrNewsTitle;
        [_newsLabel setTextColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:14] scrollDuration:0.5 stayDuration:2];
        __weak typeof(self) WeakSelf  = self;
        _newsLabel.clickMessageBlock = ^(NSInteger index){
//            MenuController*enuController = [[MenuController alloc] init];
//            [WeakSelf.navigationController pushViewController:enuController animated:YES];
            NewsViewController *newsViewController = [[NewsViewController alloc] init];
            newsViewController.hidesBottomBarWhenPushed = YES;
            [WeakSelf.navigationController pushViewController:newsViewController animated:YES];
        };
        [_newsLabel start];
        [_newsView addSubview:_newsLabel];
    }
    return _newsView;
}
- (UIView *)activityView {
    if (!_activityView) {
        CGFloat width = ([HHSoftAppInfo AppScreen].width-5)/2;
        _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_newsView.frame)+10, [HHSoftAppInfo AppScreen].width, _activityViewH+25)];
        
        
        for (NSInteger i = 0; i<self.homeInfo.arrActivity.count; i++) {
            ActivityView *activityView = [[ActivityView alloc] initWithFrame:CGRectMake((width+5)*i, 0, width, _activityViewH+25) chooseActivity:^(id info) {
                ActivityInfo *activityInfo = info;
                if (activityInfo.activityType == 1) {
                    //限时活动
                    GrabRedPacketListViewController*grabRedPacketListViewController = [[GrabRedPacketListViewController alloc] init];
                    grabRedPacketListViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:grabRedPacketListViewController animated:YES];
                }
                else if (activityInfo.activityType == 2) {
                    //新活动
                    NewRedPacketListViewController*newRedPacketListViewController = [[NewRedPacketListViewController alloc] init];
                    newRedPacketListViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:newRedPacketListViewController animated:YES];
                }
            }];
            activityView.activityInfo = self.homeInfo.arrActivity[i];
            [_activityView addSubview:activityView];
            if (i==0) {
                _countDownLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(activityView.titleLabel.frame)+5, 0, width-(CGRectGetMaxX(activityView.titleLabel.frame)+5), 25) fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
                [activityView addSubview:_countDownLabel];
            }
            
        }
        ActivityInfo *firstActivity = self.homeInfo.arrActivity[0];
        _restTime = firstActivity.countDown;
        _countDownStr = [NSString stringWithFormat:@"%@",[self timeformatFromSeconds:_restTime]];
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:UITrackingRunLoopMode];
        [_countDownTimer fire];
    }
    return _activityView;
}
#pragma mark ------ 倒计时
- (void)startTimeCountDown {
    if (_restTime>0) {
        _restTime--;
        _countDownStr = [NSString stringWithFormat:@"%@",[self timeformatFromSeconds:_restTime]];
        _countDownLabel.attributedText = [self changeCountDownLabelTextWithStr:_countDownStr];
        if (_restTime == 0) {
            [_countDownTimer invalidate];
            _countDownTimer = nil;
        }
    }
    else {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}
#pragma mark ----------------- TableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-49) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.tableHeaderView = self.headerView;
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeInfo.arrRedAdvert.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%4==2) {
        return ([HHSoftAppInfo AppScreen].width-30)/2/4*5+95;
    }else if (indexPath.row%4==3) {
        return [HHSoftAppInfo AppScreen].width-20+95;
    }
    return ([HHSoftAppInfo AppScreen].width-20)/2+95;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%4==2) {
        static NSString *string=@"IdentifierTwo";
        HomeRedPacketCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell=[[HomeRedPacketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.firstView.delegate = self;
            cell.secondView.delegate = self;
        }
        cell.arrAdvert = self.homeInfo.arrRedAdvert[indexPath.row];
        return cell;
    }
    if (indexPath.row%4==3) {
        static NSString *string=@"Identifier1_1";
        RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell=[[RedPacketAdvertCell alloc] initWithHomeAdvertStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeHome1_1];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.advertInfo = self.homeInfo.arrRedAdvert[indexPath.row];
        return cell;
    }
    static NSString *string=@"Identifier";
    RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[RedPacketAdvertCell alloc] initWithHomeAdvertStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeHome2_1];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.advertInfo = self.homeInfo.arrRedAdvert[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id data  = self.homeInfo.arrRedAdvert[indexPath.row];
    if ([data isKindOfClass:[AdvertInfo class]]) {
        [self jumpToRedPacketAdvertDetailViewControllerWithAdvertInfo:(AdvertInfo *)data];
    }
}
#pragma mark ------ 跳转广告详情
- (void)jumpToRedPacketAdvertDetailViewControllerWithAdvertInfo:(AdvertInfo *)advertInfo {
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:advertInfo.advertID];
    redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
}
#pragma mark -- 城市选择按钮监听
-(void)selectCityButtonClick{
    RegionViewController*regionViewController = [[RegionViewController alloc] initWithViewType:BackHomeType pID:0 layerID:1];
    regionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:regionViewController animated:YES];
}
#pragma mark ------ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsety = scrollView.contentOffset.y;
    [self showZeroNavigationBarByOffy:offsety headerHeight:_headerViewH-64];
    if (offsety >= (_headerViewH-64)/5*3) {
        [_cityButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        [_cityButton setImage:[UIImage imageNamed:@"city_arrow_black.png"] forState:UIControlStateNormal];
    }
    else {
        [_cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cityButton setImage:[UIImage imageNamed:@"city_arrow.png"] forState:UIControlStateNormal];
        [_cityButton setImage:[UIImage imageNamed:@"city_arrow.png"] forState:UIControlStateHighlighted];
    }
}
#pragma mark ------ UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchHistoryViewController *searchHistoryViewController = [[SearchHistoryViewController alloc] init];
    searchHistoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchHistoryViewController animated:YES];
    return NO;
}
#pragma mark ------ HomeRedPackerViewDelegate
- (void)homeRedPackerView:(HomeRedPacketView *)homeRedPackerView advertInfo:(AdvertInfo *)advertInfo {
    [self jumpToRedPacketAdvertDetailViewControllerWithAdvertInfo:advertInfo];
}
#pragma mark ------ 根据秒计算天时分秒
-(NSString*)timeformatFromSeconds:(NSInteger)seconds
{
    _hour = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds/3600%24]];
    _minute = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",(seconds%3600)/60]];
    _second = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds%60]];
    NSString *time = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@:%@:%@",_hour,_minute,_second]];
    return time;
}
- (NSMutableAttributedString *)changeCountDownLabelTextWithStr:(NSString *)str {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange hourRange = NSMakeRange(0, 2);
    NSDictionary *dicHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[HHSoftAppInfo defaultDeepSystemColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:dicHour range:hourRange];
    
    NSRange minuteRange = NSMakeRange(3, 2);
    NSDictionary *minuteHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[HHSoftAppInfo defaultDeepSystemColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:minuteHour range:minuteRange];
    
    NSRange secondRange = NSMakeRange(6, 2);
    NSDictionary *secondHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[HHSoftAppInfo defaultDeepSystemColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:secondHour range:secondRange];
    
    _countDownLabel.attributedText = attributed;
    return  attributed;
}
@end
