//
//  HHSoftFullScreenViewController.m
//  JuZiJie
//
//  Created by hhsoft on 2016/11/17.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "HHSoftFullScreenViewController.h"

@interface HHSoftFullScreenViewController ()

@end

@implementation HHSoftFullScreenViewController

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

@end
