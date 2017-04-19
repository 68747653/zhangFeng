//
//  QrCodeScanViewController.h
//  FrameTest
//
//  Created by dgl on 15-7-15.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanQrCodeSuccess)(NSString *qrCodeString);
typedef void(^ScanQrCodeFail)();


@interface QrCodeScanViewController : UIViewController

/**
 *  初始化扫描二维码的界面
 *
 *  @param scanQrCodeSuccess 扫描成功后的处理
 *  @param scanQrCodeFail    扫描失败后的处理
 *
 *  @return 
 */
-(id)initWithScanQrCodeSuccess:(ScanQrCodeSuccess)scanQrCodeSuccess ScanQrCodeFail:(ScanQrCodeFail)scanQrCodeFail;

@end
