//
//  PredictRedViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PredictRedViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "ActivityTimeInfo.h"
#import "HHSoftTopMenuView.h"
#import "PredictRedListViewController.h"

@interface PredictRedViewController () <HHSoftTopMenuViewDelegate, HHSoftTopMenuViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) HHSoftTopMenuView *topMenuView;
/** 这个scrollView的作用：存放所有子控制器的view */
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSString *activityTime;
@property (nonatomic, strong) NSMutableArray *arrActivityTime;

@end

@implementation PredictRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.title = @"预报红包";
    [self loadData];
}

#pragma mark --- 数据加载
- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _activityTime = @"";
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getPredictRedPacketListWithIndustryID:[UserInfoEngine getUserInfo].userIndustryID pageIndex:_pageIndex pageSize:_pageSize time:_activityTime];
}

- (void)getPredictRedPacketListWithIndustryID:(NSInteger)industryID pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize time:(NSString *)time {
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] getPredictRedPacketListWithIndustryID:industryID page:pageIndex pageSize:pageSize time:time successed:^(NSInteger code, NSMutableArray *arrActivityTime, NSMutableArray *arrActivityRed) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _arrActivityTime = arrActivityTime;
                
                [self.view addSubview:self.topMenuView];
                //设置子控制器
                [self setupChildsViewController];
                
                [self setupScrollView];
            }
                break;
                
            case 101: {
                //没有数据
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getPredictRedPacketListWithIndustryID:industryID pageIndex:pageIndex pageSize:pageSize time:time];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getPredictRedPacketListWithIndustryID:industryID pageIndex:pageIndex pageSize:pageSize time:time];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getPredictRedPacketListWithIndustryID:industryID pageIndex:pageIndex pageSize:pageSize time:time];
        }];
    }];
}

- (HHSoftTopMenuView *)topMenuView {
    if (!_topMenuView) {
        _topMenuView = [[HHSoftTopMenuView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 40) indicatorLayerSize:CGSizeMake([HHSoftAppInfo AppScreen].width/3.0, 2)];
        _topMenuView.backgroundColor = [UIColor whiteColor];
        _topMenuView.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        _topMenuView.highlightedTextColor = [GlobalFile themeColor];
        _topMenuView.indicatorColor = [GlobalFile themeColor];
        _topMenuView.fontSize = 14.0;
        _topMenuView.highlightFontSize = 14.0;
        _topMenuView.menuItemWidth = [HHSoftAppInfo AppScreen].width/3.0;
        _topMenuView.menuDelegate = self;
        _topMenuView.menuDataSource = self;
    }
    return _topMenuView;
}

#pragma mark --- 设置子控制器
- (void)setupChildsViewController {
    for (ActivityTimeInfo *activityTimeInfo in self.arrActivityTime) {
        _activityTime = activityTimeInfo.activityTime;
        PredictRedListViewController *predictRedListViewController = [[PredictRedListViewController alloc] initWithActivityTime:_activityTime];
        [self addChildViewController:predictRedListViewController];
    }
}

- (void)setupScrollView {
    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - 40)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * [HHSoftAppInfo AppScreen].width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)setScrollViewContentOffsetWithIndex:(NSInteger)index {
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [HHSoftAppInfo AppScreen].width * index;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark --- HHSoftTopMenuViewDelegate & HHSoftTopMenuViewDataSource
- (NSString *)hhsoftTopMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView titleForColumn:(NSInteger)column {
    ActivityTimeInfo *activityTimeInfo = _arrActivityTime[column];
    return activityTimeInfo.activityTime;
}

- (NSInteger)numberOfcolumsInMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView {
    return _arrActivityTime.count;
}

- (NSInteger)defaultSelectCoumnsInMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView {
    return 0;
}

- (void)hhsoftTopMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView didSelectMenuIndex:(NSInteger)index {
    [self setScrollViewContentOffsetWithIndex:index];
}

#pragma mark --- UIScrollViewDelegate
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *willShowChildViewController = self.childViewControllers[index];
    [self.topMenuView selectMenuIndex:index];
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildViewController.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView身上
    //    CGRect rect = scrollView.bounds;
    willShowChildViewController.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildViewController.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        // 点击按钮
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        [self.topMenuView selectMenuIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
