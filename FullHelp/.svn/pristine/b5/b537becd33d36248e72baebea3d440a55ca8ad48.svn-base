//
//  StartPageViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "StartPageViewController.h"
#import "AppDelegate.h"
#import "HHSoftHeader.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>

@interface StartPageViewController ()

@end

@implementation StartPageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载启动页
    [self showStartImage];
}

//展示启动广告页
- (void)showStartImage {
    NSString *fileName = @"homeav.jpg";
    NSString *filePath = [HHHomeImageCachePath stringByAppendingPathComponent:fileName];
    UIImage *startImg = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *startImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height)];
    startImgView.backgroundColor = [UIColor redColor];
    startImgView.image = startImg;
    startImgView.tag = 9000;
    [self.view addSubview:startImgView];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideImage) userInfo:nil repeats:NO];
}

- (void)hideImage {
    UIImageView *img = (UIImageView *)[self.view viewWithTag:9000];
    [img removeFromSuperview];
    [self.view removeFromSuperview];
    [UIApplication sharedApplication].keyWindow.rootViewController = [AppDelegate getRootViewController];
}

@end
