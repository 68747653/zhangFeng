//
//  AddViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "HHSoftHeader.h"
#import "UIButton+HHSoft.h"
#import "UserCenterNetWorkEngine.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "PublishNeedsViewController.h"
#import "MainNavgationController.h"
#import "FeedbackViewController.h"
@interface AddViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat imgWidth = [HHSoftAppInfo AppScreen].width-100;
    CGFloat imgHeight = imgWidth/1.32;
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-imgWidth)/2, 128, imgWidth, imgHeight)];
    topImgView.image = [UIImage imageNamed:@"home_add_appDesc.png"];
    [self.view addSubview:topImgView];
    
    
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon.png"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon.png"] forState:UIControlStateHighlighted];
    [publishButton sizeToFit];
    [publishButton addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishButton];
    publishButton.center = CGPointMake([HHSoftAppInfo AppScreen].width*0.5, [HHSoftAppInfo AppScreen].height-49/2);
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    publishButton.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];

    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:M_PI];
    animation.toValue =  [NSNumber numberWithFloat: 0.f];
    animation.duration  = 0.25;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 1;
    animation.delegate = self;
    self.animation = animation;
    
    NSArray *arrImage = @[@"home_publish.png",@"home_sign_in.png",@"home_feedback.png"];
    NSArray *arrTitle = @[@"发布",@"签到",@"意见反馈"];
    CGFloat margin = 30;
    CGFloat offx = 0;
    CGFloat offy = 0;
    NSInteger numbersForRow = arrImage.count;
    CGFloat width=(self.view.frame.size.width-(numbersForRow+1)*margin)/numbersForRow;
    for (NSInteger i = 0; i < numbersForRow; i++) {
        offx=(i%numbersForRow)*width+(margin*(i%numbersForRow+1));
        offy=CGRectGetMaxY(topImgView.frame)+40+(i/numbersForRow)*(width+5);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(offx, offy, width, width);
        [button setImage:[UIImage imageNamed:arrImage[i]] forState:UIControlStateNormal];
        [button setTitle:arrTitle[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        [button verticalImageAndTitle:10];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    self.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 1;
    }];
}
- (void)signIn {
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    self.op = [[[UserCenterNetWorkEngine alloc] init] addSignInfoWithUserID:[UserInfoEngine getUserInfo].userID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"签到成功"];
            }
                break;
            case 103: {
                [self showErrorView:@"今日已签到过"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍候重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍候重试"];
    }];

}
#pragma mark --- 签到
- (void)buttonPress:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            //发布
            PublishNeedsViewController*publishNeedsViewController = [[PublishNeedsViewController alloc] init];
            MainNavgationController *nav = [[MainNavgationController alloc] initWithRootViewController:publishNeedsViewController];
//            publishNeedsViewController.hidesBottomBarWhenPushed = YES;
            
            [self.view.window.rootViewController presentViewController:nav animated:YES completion:nil];
            [self stopAnimation];
        }
            break;
        case 101:
        {
            [self signIn];
        }
            break;
        case 102:
        {
            //意见反馈
            FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] init];
            MainNavgationController *nav = [[MainNavgationController alloc] initWithRootViewController:feedbackViewController];
            [self.view.window.rootViewController presentViewController:nav animated:YES completion:nil];
            [self stopAnimation];

        }
            break;
            
        default:
            break;
    }
}

- (void)publishClick:(UIButton *)sender {
    [sender.layer addAnimation:self.animation forKey:nil];

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self stopAnimation];
}
- (void)stopAnimation {
    [[NSNotificationCenter defaultCenter]postNotificationName:RemoveEffectViewNotification object:nil];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
