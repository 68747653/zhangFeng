//
//  ActivityView.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
typedef void (^ChooseActivity)(id info);
@class ActivityInfo;
@interface ActivityView : UIView
@property (nonatomic, strong) HHSoftLabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ActivityInfo *activityInfo;
- (instancetype)initWithFrame:(CGRect)frame chooseActivity:(ChooseActivity)chooseActivity;
@end
