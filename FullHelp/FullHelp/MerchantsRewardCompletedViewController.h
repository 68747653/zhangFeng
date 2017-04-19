//
//  MerchantsRewardCompletedViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

@interface MerchantsRewardCompletedViewController : HHSoftBaseViewController
-(instancetype)initWithMark:(NSInteger)mark InfoID:(NSInteger)infoID;
-(void)reloadRewardData;
@end
