//
//  HHSoftShareView.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SharePlatFormType) {
    SharePlatFormQQFriend=1,
    SharePlatFormQQSpace=1<<1,
    SharePlatFormWXFriend=1<<2,
    SharePlatFormWXSpace=1<<3,
    SharePlatFormSinaWeiBo=1<<4,
    SharePlatFormMessage=1<<5
} ;


typedef void(^ShareButtonPressed)(SharePlatFormType sharePlatFormType);
typedef void(^ShareCancelButtonPressed)();


@interface HHSoftShareView : UIView
//分享
-(id)initWithShareType:(SharePlatFormType)sharePlatFromType shareButtonPressedWithShareTypeBlock:(ShareButtonPressed)shareButtonPressed shareCancelButtonTitle:(NSString *)shareCancelButtonTitle shareCancelButtonPressed:(ShareCancelButtonPressed)shareCancelButtonPressed;
//分享，自定义分享位置的背景色
-(id)initWithShareType:(SharePlatFormType)sharePlatFromType
        shareViewBackGroundColor:(UIColor *)backgroundColor
        shareButtonPressedWithShareTypeBlock:(ShareButtonPressed)shareButtonPressed
        shareCancelButtonTitle:(NSString *)shareCancelButtonTitle
        shareCancelButtonPressed:(ShareCancelButtonPressed)shareCancelButtonPressed;





@end
