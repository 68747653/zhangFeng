//
//  NewsListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "NewsListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAutoCircleScrollView.h>
#import <HHSoftFrameWorkKit/HHSoftPageControl.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "NewsInfo.h"
#import "ImageInfo.h"
#import "NewsTableCell.h"
#import "HomeNetWorkEngine.h"
#import "NewsInfoViewController.h"
#import "PictureNewsInfoViewController.h"
#import "VideoNewsInfoViewController.h"
#import "NewsTableCell.h"

@interface NewsListViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData, *arrTopNews;

@property (nonatomic, strong) HHSoftAutoCircleScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *arrScrollImg;
@property (nonatomic, strong) HHSoftPageControl *pageControl;

@property (nonatomic, strong) UIView *headerView, *imageDescView;
@property (nonatomic, strong) HHSoftLoadingView *noDataView;
@property (nonatomic, strong) NewsInfo *newsInfo;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL isPullToRefresh;
/**
 *  是否支持加载更多
 */
@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, assign) NSInteger newsClassID;

@end

@implementation NewsListViewController

- (instancetype)initWithNewsClassID:(NSInteger)newsClassID {
    if (self = [super init]) {
        self.newsClassID = newsClassID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.view addSubview:self.dataTableView];

    [self loadData];
}

- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getNewsListWithNewsClassID:_newsClassID pageIndex:_pageIndex pageSize:_pageSize];
}

- (void)getNewsListWithNewsClassID:(NSInteger)newsClassID pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    self.op = [[[HomeNetWorkEngine alloc] init] getNewsListWithNewsClassID:newsClassID pageIndex:pageIndex pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrNewsClass, NSMutableArray *arrTopNews, NSMutableArray *arrNews) {
        [self hideLoadingView];
        [_noDataView removeFromSuperview];
        _noDataView = nil;
        switch (code) {
            case 100: {
                if (arrTopNews.count) {
                    _arrTopNews = arrTopNews;
                    if (!_arrScrollImg) {
                        _arrScrollImg = [NSMutableArray arrayWithCapacity:0];
                    }
                    [_arrScrollImg removeAllObjects];
                    for (NewsInfo *newsInfo in arrTopNews) {
                        if (newsInfo.newsImageInfo.imageBig.length) {
                            [_arrScrollImg addObject:newsInfo.newsImageInfo.imageBig];
                        }
                    }
                    _dataTableView.tableHeaderView = self.headerView;
                }
                if (!_arrData) {
                    _arrData = [NSMutableArray arrayWithCapacity:0];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:arrNews];
                [self.dataTableView reloadData];
                if (_arrScrollImg.count > 0) {
                    if (_arrScrollImg.count > 1) {
                        self.scrollView.scrollEnabled = YES;
                    } else {
                        self.scrollView.scrollEnabled = NO;
                    }
                    [self.scrollView updateArrScrollImg:_arrScrollImg];
                }
                if (_arrData.count == 0) {
                    [_dataTableView reloadData];
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isPullToRefresh=NO;
                        _isLoadMore=NO;
                        [self.noDataView showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getNewsListWithNewsClassID:newsClassID pageIndex:pageIndex pageSize:pageSize];
                    }];
                } else {
                    if (_isPullToRefresh == NO && _isLoadMore == NO) {
                        [self hideLoadingView];
                    } else {
                        [self.dataTableView stopAnimating];
                    }
                    [self.dataTableView reloadData];
                    
                    if (_arrData.count==_pageIndex*_pageSize) {
                        [_dataTableView setLoadMoreEnabled:YES];
                    } else {
                        [_dataTableView setLoadMoreEnabled:NO];
                    }
                }
            }
                break;
                
            case 101: {
                //没有数据
                if (_isLoadMore == NO && _isPullToRefresh == NO) {
                    [_arrData removeAllObjects];
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self.noDataView showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getNewsListWithNewsClassID:newsClassID pageIndex:pageIndex pageSize:pageSize];
                    }];
                }else{
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                if (_isLoadMore == NO && _isPullToRefresh == NO) {
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getNewsListWithNewsClassID:newsClassID pageIndex:pageIndex pageSize:pageSize];
                    }];
                }else{
                    [self showErrorView:[GlobalFile HHSoftLoadError]];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        if (_isLoadMore == NO && _isPullToRefresh == NO) {
            [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                _isLoadMore = NO;
                _isPullToRefresh = NO;
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getNewsListWithNewsClassID:newsClassID pageIndex:pageIndex pageSize:pageSize];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore == YES) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}

/**
 初始化dataTableView
 
 @return dataTableView
 */
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - 40) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getNewsListWithNewsClassID:_weakself.newsClassID pageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getNewsListWithNewsClassID:_weakself.newsClassID pageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
    }
    return _dataTableView;
}

- (HHSoftLoadingView *)noDataView {
    if (_noDataView == nil) {
        _noDataView = [[HHSoftLoadingView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - 40)];
        _noDataView.textLable.textColor = [UIColor lightGrayColor];
        _noDataView.textLable.font = [UIFont systemFontOfSize:14.f];
        [self.view addSubview:_noDataView];
        [self.view bringSubviewToFront:_noDataView];
    }
    return _noDataView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width / 2.0)];
        [_headerView addSubview:self.scrollView];
        if (_arrScrollImg.count > 1) {
            [_headerView addSubview:self.pageControl];
        }
    }
    return _headerView;
}

/**
 初始化scrollView
 
 @return scrollView
 */
- (HHSoftAutoCircleScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HHSoftAutoCircleScrollView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width / 2.0) arrScrollImg:@[@""] placeHolderimg:[GlobalFile HHSoftDefaultImg2_1] backgroundImage:nil timeInterval:3 imgTap:^(NSInteger currentIndex) {
            NewsInfo *newsInfo = _arrTopNews[currentIndex];
            [self pushToNextViewControllerWith:newsInfo];
        } scrollEvent:^(NSInteger currentIndex) {
            self.pageControl.currentPage = currentIndex;
        }];
    }
    return _scrollView;
}

- (HHSoftPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[HHSoftPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.headerView.frame) - 30, [HHSoftAppInfo AppScreen].width, 30) pageCount:_arrScrollImg.count currentPageImage:[UIImage imageNamed:@"page_bannerselect"] pageIndicatorImage:[UIImage imageNamed:@"page_banneruncheck"] dotWidth:6.5 dotHeigth:6.5];
        _pageControl.userInteractionEnabled = NO;
        if (_arrScrollImg.count > 1) {
            _pageControl.numberOfPages = _arrScrollImg.count;
        } else {
            _pageControl.numberOfPages = 0;
            _pageControl.currentPage = 0;
        }
    }
    return _pageControl;
}

#pragma mark --- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsInfo *newsInfo = _arrData[indexPath.row];
    return [NewsTableCell getCellHeightWith:newsInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsInfo *newsInfo = _arrData[indexPath.row];
    static NSString *newsIdentifier = @"NewsInfoCell";
    NewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIdentifier];
    if (!cell) {
        cell = [[NewsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsIdentifier];
    }
    cell.newsInfo = newsInfo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsInfo *newsInfo = _arrData[indexPath.row];
    [self pushToNextViewControllerWith:newsInfo];
}

- (void)pushToNextViewControllerWith:(NewsInfo *)newsInfo {
    if (newsInfo.newsType == 3) {//图片新闻
        PictureNewsInfoViewController *pictureNewsInfoViewController = [[PictureNewsInfoViewController alloc] initWithNewsID:newsInfo.newsID infoID:0];
        [self.navigationController pushViewController:pictureNewsInfoViewController animated:YES];
    } else if (newsInfo.newsType == 1) {//视频
        ImageInfo *imageInfo = [newsInfo.newsArrImageInfo firstObject];
        VideoNewsInfoViewController *videoNewsInfoViewController = [[VideoNewsInfoViewController alloc] initWithNewsID:newsInfo.newsID newsImage:imageInfo.imageBig infoID:0];
        [self.navigationController pushViewController:videoNewsInfoViewController animated:YES];
    } else {
        NewsInfoViewController *newsDetailViewController = [[NewsInfoViewController alloc] initWithUrl:newsInfo.newsLinkUrl newsID:newsInfo.newsID infoID:0];
        [self.navigationController pushViewController:newsDetailViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
