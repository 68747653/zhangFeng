//
//  MyAdvertViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MyAdvertViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "HHSoftTopMenuView.h"
#import "AdvertViewController.h"
#import "MenuInfo.h"

@interface MyAdvertViewController () <HHSoftTopMenuViewDelegate, HHSoftTopMenuViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) HHSoftTopMenuView *topMenuView;
/** 这个scrollView的作用：存放所有子控制器的view */
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation MyAdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.title = @"我的广告";
    [self loadData];
}

#pragma mark --- 数据加载
- (void)loadData {
    _arrData = [self getMyAdvertData];
    [self.view addSubview:self.topMenuView];
    //设置子控制器
    [self setupChildsViewController];
    
    [self setupScrollView];
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
    NSArray *arr = [NSArray arrayWithObjects:@(ShowAdvertType), @(WillShowAdvertType), @(OffShelvesAdvertType), nil];
    for (NSInteger i = 0; i < _arrData.count; i++) {
        AdvertViewController *advertViewController = [[AdvertViewController alloc] initWithAdvetType:[arr[i] integerValue]];
        [self addChildViewController:advertViewController];
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
    scrollView.showsHorizontalScrollIndicator = NO;
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
    MenuInfo *menuInfo = _arrData[column];
    return menuInfo.menuName;
}

- (NSInteger)numberOfcolumsInMenuView:(HHSoftTopMenuView *)hhsoftTopMenuView {
    return _arrData.count;
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

/**
 我的广告
 
 @return arrData
 */
- (NSMutableArray *)getMyAdvertData {
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"展示中"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"即将上架"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"已下架"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2, nil];

    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
