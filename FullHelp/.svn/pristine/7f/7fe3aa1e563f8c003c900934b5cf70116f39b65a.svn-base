//
//  AddTabBar.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddTabBar.h"
#import "GlobalFile.h"
#import "AddViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "HHSoftHeader.h"
@interface AddTabBar ()
/** 发布按钮 */
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation AddTabBar
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RemoveEffectViewNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeEffectViewNotification) name:RemoveEffectViewNotification object:nil];
        // 设置背景图片
        [self setBackgroundColor:[UIColor whiteColor]];
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon.png"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon.png"] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick {
    AddViewController *publish = [[AddViewController alloc] init];
    [self.window addSubview:publish.view];
    UITabBarController *mainTabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = mainTabBarController.viewControllers[mainTabBarController.selectedIndex];
    HHSoftBaseViewController *viewController = nav.viewControllers[0];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.tag = 800000;
    effectView.frame = CGRectMake(0, 0,[HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height);
    [viewController.view addSubview:effectView];
    publish.effectView = effectView;
    self.effectView = effectView;
}

/**
 * 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // tabBar的尺寸
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的位置
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 按钮索引
    int index = 0;
    
    // 按钮的尺寸
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    // 设置4个TabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        // 计算按钮的X值
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) { // 给后面2个button增加一个宽度的X值
            tabBarButtonX += tabBarButtonW;
        }
        
        // 设置按钮的frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        // 增加索引
        index++;
    }
}
#pragma mark ------ 移除毛玻璃效果通知
- (void)removeEffectViewNotification {
    [self.effectView removeFromSuperview];
    self.effectView = nil;
}

@end
