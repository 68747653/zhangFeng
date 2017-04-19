//
//  UIViewController+NavigationBar.m
//  ShiShiCai
//
//  Created by hhsoft on 2017/1/3.
//  Copyright © 2017年 www.huahansoft.com. All rights reserved.
//

#import "UIViewController+NavigationBar.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "HHSoftBarButtonItem.h"
#import <objc/runtime.h>
@interface UIViewController ()

@end
@implementation UIViewController (NavigationBar)
//分类不能使用set方法，此处只为删除警告
- (void)setHhsoftNavigationBar:(UINavigationBar *)hhsoftNavigationBar {}
- (void)setHhsoftNaigationItem:(UINavigationItem *)hhsoftNaigationItem {}
static const char * key = "keyScrollView";
- (UIScrollView *)keyScrollView{
    return objc_getAssociatedObject(self, key);
}
- (void)setKeyScrollView:(UIScrollView *)keyScrollView{
    objc_setAssociatedObject(self, key, keyScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static const char * keyBar = "hhsoftNavigationBar";
- (UINavigationBar *)hhsoftNavigationBar {
    return objc_getAssociatedObject(self, keyBar);
}
static const char * keyItem = "hhsoftNavigationItem";
- (UINavigationItem *)hhsoftNaigationItem {
    return objc_getAssociatedObject(self, keyItem);
}
static const char * isLeftAlphaKey = "isLeftAlpha";
- (BOOL)isLeftAlpha{
    
    return [objc_getAssociatedObject(self,isLeftAlphaKey) boolValue];
}
- (void)setIsLeftAlpha:(BOOL)isLeftAlpha{
    
    objc_setAssociatedObject(self, isLeftAlphaKey, @(isLeftAlpha), OBJC_ASSOCIATION_ASSIGN);
}
static const char * isRightAlphaKey = "isRightAlpha";
- (BOOL)isRightAlpha{
    
    return [objc_getAssociatedObject(self,isRightAlphaKey) boolValue];
}
- (void)setIsRightAlpha:(BOOL)isRightAlpha{
    
    objc_setAssociatedObject(self, isRightAlphaKey, @(isRightAlpha), OBJC_ASSOCIATION_ASSIGN);
}

static const char * isTitleAlphaKey = "isTitleAlpha";
- (BOOL)isTitleAlpha{
    
    return [objc_getAssociatedObject(self,isTitleAlphaKey) boolValue];
}
- (void)setIsTitleAlpha:(BOOL)isTitleAlpha{
    
    objc_setAssociatedObject(self, isTitleAlphaKey, @(isTitleAlpha), OBJC_ASSOCIATION_ASSIGN);
}
- (void)addLucencyNavigationBar {
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 64)];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationBar.subviews.firstObject setAlpha:0];
    navigationBar.topItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithWhiteBackBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:navigationBar];
    objc_setAssociatedObject(self, keyBar, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, keyItem, navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static CGFloat alpha = 0;
- (void)showNavigationBarByOffy:(CGFloat)offy headerHeight:(CGFloat)headerHeight{
    alpha =  offy/headerHeight;
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    
    self.hhsoftNaigationItem.leftBarButtonItem.customView.alpha = self.isLeftAlpha?alpha:1;
    self.hhsoftNaigationItem.titleView.alpha = self.isTitleAlpha?alpha:1;
    self.hhsoftNaigationItem.rightBarButtonItem.customView.alpha = self.isRightAlpha?alpha:1;
}
- (void)showZeroNavigationBarByOffy:(CGFloat)offy headerHeight:(CGFloat)headerHeight{
    alpha =  offy/headerHeight;
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    //设置导航条上的标签是否跟着透明
    if (offy >= 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.hhsoftNaigationItem.leftBarButtonItem.customView.alpha = 1;
            self.hhsoftNaigationItem.titleView.alpha = 1;
            self.hhsoftNaigationItem.rightBarButtonItem.customView.alpha = 1;
        }];
    }else {
        self.hhsoftNaigationItem.leftBarButtonItem.customView.alpha = 0;
        self.hhsoftNaigationItem.titleView.alpha = 0;
        self.hhsoftNaigationItem.rightBarButtonItem.customView.alpha = 0;
    }
    [self.hhsoftNavigationBar.subviews.firstObject setAlpha:alpha];
}
@end
