//
//  CategoryView.m
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/20.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "CategoryView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UIView+HHSoft.h"
#import "RedPacketInfo.h"
@interface CategoryView ()

@property (nonatomic, copy) ChooseCategory chooseCategory;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) BOOL isShowName;
@property (nonatomic, assign) BOOL isRound;

@end
@implementation CategoryView
- (instancetype)initWithFrame:(CGRect)frame
                      imgSize:(CGSize)imgSize
                   isShowName:(BOOL)isShowName
                      isRound:(BOOL)isRound
               chooseCategory:(ChooseCategory)chooseCategory{
    if (self = [super initWithFrame:frame]) {
        _chooseCategory = chooseCategory;
        _imgSize = imgSize;
        _isShowName = isShowName;
        _isRound = isRound;
        [self setUpUI];
    }
    return self;
}
- (void) setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat imgY = (CGRectGetHeight(self.frame)-_imgSize.height-20)/2;
    if (imgY<0) {
        imgY = 0;
    }
    _classImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-_imgSize.width)/2, imgY, _imgSize.width, _imgSize.height)];
    _classImgView.contentMode = UIViewContentModeScaleAspectFill;
    _classImgView.layer.masksToBounds = YES;
    if (_isRound == YES) {
        _classImgView.layer.cornerRadius = _classImgView.bounds.size.width/2;
    }
    [self addSubview:_classImgView];
    
    if (_isShowName) {
        _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_classImgView.frame)+5, CGRectGetWidth(self.frame), 20) fontSize:12 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [self addSubview:_nameLabel];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTap)];
    [self addGestureRecognizer:tap];
}
#pragma mark ------ 选择类别击事件
- (void) categoryTap {
    if (_chooseCategory) {
        if (_redPacketInfo) {
            _chooseCategory(_redPacketInfo);
        }
//        else if (_userInfo) {
//            _chooseCategory(_userInfo);
//        }
//        else if (_schoolInfo) {
//            _chooseCategory(_schoolInfo);
//        }
        
    }
}
- (void)setRedPacketInfo:(RedPacketInfo *)redPacketInfo {
    _redPacketInfo = redPacketInfo;
    [_classImgView sd_setImageWithURL:[NSURL URLWithString:_redPacketInfo.redPacketImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    _nameLabel.text = _redPacketInfo.redPacketClassName;
}
//- (void)setCategoryInfo:(CategoryInfo *)categoryInfo {
//    _categoryInfo = categoryInfo;
//    _classImgView.image = [UIImage imageNamed:_categoryInfo.categoryIcon];
//    _nameLabel.text = _categoryInfo.categoryName;
//}
//- (void)setSchoolInfo:(SchoolInfo *)schoolInfo {
//    _schoolInfo = schoolInfo;
//    [_classImgView sd_setImageWithURL:[NSURL URLWithString:_schoolInfo.schoolImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
//    _nameLabel.text = _schoolInfo.schoolName;
//    [self changeNameLabelFrame];
//}
//- (void)setUserInfo:(UserInfo *)userInfo {
//    _userInfo = userInfo;
//    [_classImgView sd_setImageWithURL:[NSURL URLWithString:_userInfo.userHeadImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
//    _nameLabel.text = [NSString stringWithFormat:@"%@(%@)",_userInfo.userNickName,_userInfo.userCarTypeName];
//    [self changeNameLabelFrame];
//}
- (void)changeNameLabelFrame {
    _nameLabel.y = CGRectGetHeight(self.frame)-20;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0.55];
}
@end
