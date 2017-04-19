//
//  PayHelper.m
//  HHChat
//
//  Created by hhsoft on 16/6/24.
//  Copyright © 2016年 luigi. All rights reserved.
//

#import "PayHelper.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import <HHSoftFrameWorkKit/SVProgressHUD.h>
#import "HHSoftHeader.h"
@implementation PayHelper
    //处理支付宝支付的结果
+(void)handParsePay:(NSURL *)url type:(PayWayType)type application:(UIApplication *)application{
    if (type==PayWayTypeAliPay) {
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSString *code=[resultDic objectForKey:@"resultStatus"];
                if ([code isEqualToString:@"9000"]) {
                    [self paySucess];
                }else if ([code isEqualToString:@"6001"]) {
                     [SVProgressHUD dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付提示" message:@"您取消了支付" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertController addAction:deleteAction];
                    
                    [[self currentController] presentViewController:alertController animated:YES completion:nil];
                }else{
                     [SVProgressHUD dismiss];
                        //交易失败
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付提示" message:@"支付宝支付失败" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertController addAction:deleteAction];
                    
                    [[self currentController] presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }
    }else if (type==PayWayTypeWXPay) {
        AppDelegate *appDelegate=(AppDelegate *)application.delegate;
        [WXApi handleOpenURL:url delegate:(id)appDelegate];
    }
}
    //微信支付成功后的处理
+(void)wxPaySuccessWithOnResp:(BaseResp *)resp{
      [SVProgressHUD dismiss];
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        if (response.errCode==WXSuccess) {
            [self paySucess];
        }else{
            NSString *errMessageStr = @"微信支付失败！";
            switch (response.errCode) {
                case WXErrCodeUserCancel:{
                    errMessageStr = @"您已取消微信支付！";
                }
                    break;
                case WXErrCodeSentFail:{
                    errMessageStr = @"微信支付发送失败！";
                }
                    break;
                case WXErrCodeAuthDeny:{
                    errMessageStr = @"您已拒绝微信支付！";
                }
                    break;
                case WXErrCodeUnsupport:{
                    errMessageStr = @"您的版本不支持微信支付,请升级到最新版本！";
                }break;
                default:
                    break;
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付提示" message:@"您取消了支付" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
            
            [[self currentController] presentViewController:alertController animated:YES completion:nil];
        }
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付提示" message:@"微信支付失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cancelAction];
        
        [[self currentController] presentViewController:alertController animated:YES completion:nil];
    }
}
+(void)paySucess{
     [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccessHandNotification object:nil];
}
+(UIViewController *)currentController{
    UITabBarController *tabbarController=(UITabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    UIViewController *current=[(UINavigationController *)tabbarController.selectedViewController topViewController];
    return current;
}
@end
