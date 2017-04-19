//
//  VideoNewsInfoViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

@interface VideoNewsInfoViewController : HHSoftBaseViewController
@property (nonatomic, strong) UIImageView *headerView;
- (instancetype)initWithNewsID:(NSInteger)newsID newsImage:(NSString *)newsImage infoID:(NSInteger)infoID;

@end
