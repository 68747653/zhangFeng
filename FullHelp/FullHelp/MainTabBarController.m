//
//  MainTabbarController.m
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/19.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "CashRedPacketViewController.h"
#import "SpecialRedPacketViewController.h"

#import "UserCenterViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/UINavigationBar+HHSoft.h>
#import "GlobalFile.h"
#import "AddTabBar.h"
#import "MainNavgationController.h"
@interface MainTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *addButton;

@end
@implementation MainTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    
    // 添加所有的子控制器
    [self setupChildViewControllers];
    
    [self setupTabBar];
}
/**
 * 处理TabBar
 */
- (void)setupTabBar
{
    [self setValue:[[AddTabBar alloc] init] forKeyPath:@"tabBar"];
}
/**
 * 添加所有的子控制器
 */
- (void)setupChildViewControllers {
    [self setupChildViewController:[[HomeViewController alloc] init] title:@"首页" image:@"tabbar_item0.png" selectedImage:@"tabbar_item0_highlight.png" tag:0];
    
    [self setupChildViewController:[[CashRedPacketViewController alloc] init] title:@"现金红包" image:@"tabbar_item1.png" selectedImage:@"tabbar_item1_highlight.png" tag:1];
    
    [self setupChildViewController:[[SpecialRedPacketViewController alloc] init] title:@"专场红包" image:@"tabbar_item2.png" selectedImage:@"tabbar_item2_highlight.png" tag:2];
    
    [self setupChildViewController:[[UserCenterViewController alloc] init]  title:@"我的" image:@"tabbar_item3.png" selectedImage:@"tabbar_item3_highlight.png" tag:3];

}
/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSUInteger)tag
{
    
    // 包装一个导航控制器
    MainNavgationController*nav = [[MainNavgationController alloc] initWithRootViewController:viewController];
    
    
//    nav.navigationBar.shadowImage = [UIImage new];
//    nav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //返回按钮图片
    //    [nav.navigationItem setBackBarButtonCustome:[UIImage imageNamed:@"navigationItem_back"]];
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [HHSoftAppInfo defaultDeepSystemColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [GlobalFile themeColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    [nav.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    nav.tabBarItem.title = title;
    nav.tabBarItem.tag = tag;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
