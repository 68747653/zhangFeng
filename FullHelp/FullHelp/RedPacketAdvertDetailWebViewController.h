//
//  RedPacketAdvertDetailWebViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>
typedef void(^RedPacketAdvertDetailWebViewControllerDropDownBlock)();
@interface RedPacketAdvertDetailWebViewController : HHSoftBaseViewController
-(instancetype)initWithWebURL:(NSString *)webURL DropDownBlock:(RedPacketAdvertDetailWebViewControllerDropDownBlock)dropDownBlock;
@end
