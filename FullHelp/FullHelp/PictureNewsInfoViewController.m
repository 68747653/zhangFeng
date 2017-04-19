//
//  PictureNewsInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PictureNewsInfoViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftSDImageCache.h>
#import "GlobalFile.h"
#import "NewsInfo.h"
#import "HomeNetWorkEngine.h"
#import "ImageInfo.h"
#import "UserInfoEngine.h"
#import "HHSoftBarButtonItem.h"
#import "AttentionNetWorkEngine.h"
#import "UserInfo.h"

@interface PictureNewsInfoViewController () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger newsID, infoID;
@property (nonatomic, strong) UIView *imgDescView;
@property (nonatomic, strong) NewsInfo *newsInfo;

@property (nonatomic, strong) UIScrollView *scrollImgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIBarButtonItem *collectionButton;

@end

@implementation PictureNewsInfoViewController

- (instancetype)initWithNewsID:(NSInteger)newsID infoID:(NSInteger)infoID {
    if (self = [super init]) {
        self.newsID = newsID;
        self.infoID = infoID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"资讯详情";
    //右上角收藏
    _collectionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collection_unselect"] style:UIBarButtonItemStylePlain target:self action:@selector(collectionRightBarButtonItemPressed)];
    _collectionButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = _collectionButton;
    self.navigationItem.rightBarButtonItem.tintColor = [GlobalFile themeColor];
    [self.view addSubview:self.imgDescView];
    [self loadData];
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
                _newsInfo = newsInfo;
                [self setupScrollView];
                if (newsInfo.newsIsCollect) {
                    _collectionButton.image = [UIImage imageNamed:@"collection_select"];
                } else {
                    _collectionButton.image = [UIImage imageNamed:@"collection_unselect"];
                }
                if (newsInfo.newsArrImageInfo.count) {
                    [self setImgDataCurrentIndex:0];
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

- (void)setImgDataCurrentIndex:(NSInteger)currentIndex {
    ImageInfo *imageInfo = self.newsInfo.newsArrImageInfo[currentIndex];
    NSString *descStr;
    if (imageInfo.imageDesc.length) {
        descStr = [NSString stringWithFormat:@"%@/%@%@", @(currentIndex + 1), @(self.newsInfo.newsArrImageInfo.count), imageInfo.imageDesc];
    } else {
        descStr = [NSString stringWithFormat:@"%@/%@", @(currentIndex + 1), @(self.newsInfo.newsArrImageInfo.count)];
    }
    CGSize size = [descStr boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, 1000)];
    CGFloat height;
    if (size.height > 24) {
        height = size.height + 20;
    } else {
        height = 44;
    }
    self.imgDescView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - height - 44, [HHSoftAppInfo AppScreen].width, height);
    HHSoftLabel *imgDescLabel = (HHSoftLabel *)[self.imgDescView viewWithTag:789];
    imgDescLabel.frame = CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width - 30, CGRectGetHeight(self.imgDescView.frame) - 20);
    imgDescLabel.text = descStr;
}

- (UIView *)imgDescView {
    if (!_imgDescView) {
        _imgDescView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, [HHSoftAppInfo AppScreen].width, 44)];
        _imgDescView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        HHSoftLabel *imgDescLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width - 30, CGRectGetHeight(_imgDescView.frame) - 20) fontSize:12.0 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        imgDescLabel.tag = 789;
        [_imgDescView addSubview:imgDescLabel];
    }
    return _imgDescView;
}

- (void)setupScrollView {
    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.newsInfo.newsArrImageInfo.count * [HHSoftAppInfo AppScreen].width, 0);
    for (NSInteger i = 0; i < self.newsInfo.newsArrImageInfo.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [HHSoftAppInfo AppScreen].width, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64)];
        imgView.tag = 600 + i;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imgView];
    }
    [self.view addSubview:scrollView];
    [self.view bringSubviewToFront:self.imgDescView];
    self.scrollImgView = scrollView;
    
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
#pragma mark --- UIScrollViewDelegate
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (self.newsInfo.newsArrImageInfo.count) {
        [self setImgDataCurrentIndex:index];
        ImageInfo *imageInfo = self.newsInfo.newsArrImageInfo[index];
        NSArray *arrWidthHeight = [[[[[imageInfo.imageBig componentsSeparatedByString:@"_"] lastObject] componentsSeparatedByString:@"."] firstObject] componentsSeparatedByString:@"x"];
        CGFloat widthHeight = (CGFloat)[[arrWidthHeight lastObject] integerValue] / [[arrWidthHeight firstObject] integerValue];
        UIImageView *imgView = (UIImageView *)[scrollView viewWithTag:600 + index];
        imgView.frame = CGRectMake(index * [HHSoftAppInfo AppScreen].width, (CGRectGetHeight(scrollView.frame) - [HHSoftAppInfo AppScreen].width * widthHeight) / 2, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * widthHeight);
        UIImage *cacheImage=[[HHSoftSDImageCache sharedImageCache] imageFromDiskCacheForKey:imageInfo.imageBig];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageBig] placeholderImage:cacheImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, HHSoftSDImageCacheType cacheType, NSURL *imageURL) {
            if (image && !error) {
                imgView.image=image;
            }
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollImgView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        // 点击按钮
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (self.newsInfo.newsArrImageInfo.count) {
            [self setImgDataCurrentIndex:index];
            ImageInfo *imageInfo = self.newsInfo.newsArrImageInfo[index];
            NSArray *arrWidthHeight = [[[[[imageInfo.imageBig componentsSeparatedByString:@"_"] lastObject] componentsSeparatedByString:@"."] firstObject] componentsSeparatedByString:@"x"];
            CGFloat widthHeight = (CGFloat)[[arrWidthHeight lastObject] integerValue] / [[arrWidthHeight firstObject] integerValue];
            UIImageView *imgView = (UIImageView *)[scrollView viewWithTag:600 + index];
            imgView.frame = CGRectMake(index * [HHSoftAppInfo AppScreen].width, (CGRectGetHeight(scrollView.frame) - [HHSoftAppInfo AppScreen].width * widthHeight) / 2, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * widthHeight);
            UIImage *cacheImage=[[HHSoftSDImageCache sharedImageCache] imageFromDiskCacheForKey:imageInfo.imageBig];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageBig] placeholderImage:cacheImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, HHSoftSDImageCacheType cacheType, NSURL *imageURL) {
                if (image && !error) {
                    imgView.image=image;
                }
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
