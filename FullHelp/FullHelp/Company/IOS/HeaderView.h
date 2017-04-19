//
//  HeaderView.h
//  ShiShiCai
//
//  Created by hhsoft on 2016/12/30.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
typedef void(^HeaderViewImageTap)();
@interface HeaderView : UIView
@property (nonatomic, copy) NSString *avatarStr;
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, strong) NSAttributedString *nameAttributedText;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic,strong) HHSoftLabel *nameLabel;
@property(nonatomic,strong) UIImageView *backgroundImgView;
@property (nonatomic, strong) UIColor *nameColor;

@property (nonatomic, strong) UIImage *backGroundImage;

- (instancetype)initWithFrame:(CGRect)frame headerImageTap:(HeaderViewImageTap)headerImageTap;
@end
