//
//  MainNavgationController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MainNavgationController.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationBar+HHSoft.h>
@interface MainNavgationController ()

@end

@implementation MainNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏标题文字属性
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    // 文字颜色
    textAttributesDict[NSForegroundColorAttributeName] = [HHSoftAppInfo defaultDeepSystemColor];
    // 文字大小
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
    [self.navigationBar setTitleTextAttributes:textAttributesDict];
    [self.navigationBar setBackgroundImage:[GlobalFile imageWithColor:[UIColor whiteColor] size:CGSizeMake([HHSoftAppInfo AppScreen].width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:[HHSoftAppInfo defaultDeepSystemColor]];
    [self.navigationBar setBackButtonColor:[HHSoftAppInfo defaultDeepSystemColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
