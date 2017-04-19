//
//  CategoryView.h
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/20.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RedPacketInfo;
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
typedef void (^ChooseCategory)(id info);
@interface CategoryView : UIView
@property (nonatomic, strong) RedPacketInfo *redPacketInfo;


@property (nonatomic, strong) UIImageView *classImgView;
@property (nonatomic, strong) HHSoftLabel *nameLabel;
/**
 *  初始化类别View
 *
 *  @param frame          frame
 *  @param imgSize        图片大小
 *  @param isShowName     是否显示名称
 *  @param chooseCategory block
 *  @param isRound        是否是圆的
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
                      imgSize:(CGSize)imgSize
                   isShowName:(BOOL)isShowName
                      isRound:(BOOL)isRound
               chooseCategory:(ChooseCategory)chooseCategory;
@end
