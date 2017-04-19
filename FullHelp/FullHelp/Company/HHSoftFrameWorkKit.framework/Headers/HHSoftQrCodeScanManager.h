//
//  HHSoftQrCodeScanManager.h
//  FrameTest
//
//  Created by dgl on 15-7-14.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QrCodeScanViewController.h"


@interface HHSoftQrCodeScanManager : NSObject

+ (HHSoftQrCodeScanManager *)shared;
/**
 *  扫描二维码
 *
 *  @param targetController  展示扫描二维码窗体的controller
 *  @param scanQrCodeSuccess 扫描成功后的处理
 *  @param scanQrcodeFail    扫描失败后的处理
 */
-(void)showQrCodeScanViewInTargetController:(UIViewController *)targetController
                            withScanSuccess:(ScanQrCodeSuccess)scanQrCodeSuccess
                               withScanFail:(ScanQrCodeFail)scanQrcodeFail;

@end
