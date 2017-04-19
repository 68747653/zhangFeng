//
//  HotRedPacketListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "HotRedPacketListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftPageControl.h>
#import <HHSoftFrameWorkKit/HHSoftAutoCircleScrollView.h>
#import "AdvertInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "RedPacketAdvertCell.h"
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "IndustryInfo.h"
#import "WKWebViewController.h"
#import "RedPacketAdvertDetailViewController.h"
@interface HotRedPacketListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic,strong) HHSoftAutoCircleScrollView *advertScrollView;
@property (nonatomic,strong) HHSoftPageControl *pageControl;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrTopAdvert;
@property (nonatomic, strong) NSMutableArray *advertImgArray;
@property (nonatomic, assign)  CGFloat headerViewH;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;
@end

@implementation HotRedPacketListViewController
- (instancetype) init {
    if (self = [super init]) {
        _headerViewH = [HHSoftAppInfo AppScreen].width/2;
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getHotRedPacketAdvert];
    
}
- (void)getHotRedPacketAdvert {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getHotRedPacketAdvertListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize successed:^(NSInteger code, NSMutableArray *arrTopAdvert, NSMutableArray *arrData) {
        switch (code) {
            case 100:
            {
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                    self.arrTopAdvert = arrTopAdvert;
                }
                [self.arrData addObjectsFromArray:arrData];
                
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }else {
                    [self.dataTableView reloadData];
                }
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                }else {
                    [_dataTableView stopAnimating];
                }
                _dataTableView.showsInfiniteScrolling=_arrData.count==_pageIndex*_pageSize?YES:NO;
                if (_pageIndex == 1) {
                    _advertImgArray = [[NSMutableArray alloc] init];
                    for (AdvertInfo *advertInfo in arrTopAdvert) {
                        if (advertInfo.advertImg.length) {
                            [_advertImgArray addObject:advertInfo.advertImg];
                        }else{
                            [_advertImgArray addObject:@"123"];
                        }
                    }
                    if (arrTopAdvert.count>0) {
                        if (_advertImgArray.count>1) {
                            _advertScrollView.scrollEnabled = YES;
                            _pageControl.numberOfPages = _advertImgArray.count;
                            
                        }else{
                            _advertScrollView.scrollEnabled = NO;
                            _pageControl.numberOfPages = 0;
                        }
                        [_advertScrollView updateArrScrollImg:_advertImgArray];
                        self.pageControl.currentPage=0;
                    }
                }
            }
                break;
            case 101: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"暂无数据" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getHotRedPacketAdvert];
                    }];
                }else {
                    [self showErrorView:@"暂无数据"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setShowsInfiniteScrolling:NO];
            }
                break;
            default: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getHotRedPacketAdvert];
                    }];
                }else {
                    [self showErrorView:@"网络异常"];
                }
            }
                break;
        }
    } failed:^(NSError *error) {
        if (!_isLoadMore&&!_isPullToRefresh) {
            [self hideLoadingView];
            [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                [self hideLoadingView];
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getHotRedPacketAdvert];
            }];
        }else {
            [self showErrorView:@"网络异常"];
            if (_isLoadMore) {
                _pageIndex--;
            }
            [_dataTableView stopAnimating];
        }
    }];
}
#pragma mark ------ 设置导航栏
- (void)setNavigationItem {
    self.navigationItem.title = @"热门推荐";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
#pragma mark ------ headerView
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _headerViewH)];
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
            if (self.arrTopAdvert) {
                AdvertInfo *advertInfo = self.arrTopAdvert[currentIndex];
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
#pragma mark ----------------- tableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        _dataTableView.tableHeaderView = self.headerView;
        _dataTableView.backgroundColor = self.view.backgroundColor;
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.pageIndex = 1;
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore = NO;
            [_weakself getHotRedPacketAdvert];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.pageIndex += 1;
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore = YES;
            [_weakself getHotRedPacketAdvert];
        }];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([HHSoftAppInfo AppScreen].width-20)/2+40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 20)];
    HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-85)/2, 5, 85, 20) fontSize:15 text:@"推荐项目" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:1 numberOfLines:1];
    [headerView addSubview:nameLabel];
    
    CGFloat width = ([HHSoftAppInfo AppScreen].width-20-85-10)/2;
    
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, width, 4)];
    UIImage *leftImg = [[UIImage imageNamed:@"left_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.5, 0.5, 0.5, 5)];
    leftImgView.image = leftImg;
    [headerView addSubview:leftImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+5, 13, width, 4)];
    UIImage *rightImg = [[UIImage imageNamed:@"right_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.5, 5, 0.5, 0.5)];
    rightImgView.image = rightImg;
    [headerView addSubview:rightImgView];
    
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"Identifier";
    RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[RedPacketAdvertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeHotAdvert];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.advertInfo = self.arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AdvertInfo *advertInfo = self.arrData[indexPath.row];
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:advertInfo.advertID];
    redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
