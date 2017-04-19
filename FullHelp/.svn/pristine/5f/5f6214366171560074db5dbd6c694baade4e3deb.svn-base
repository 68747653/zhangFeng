//
//  HeaderView.m
//  ShiShiCai
//
//  Created by hhsoft on 2016/12/30.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "HeaderView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
@interface HeaderView ()



@property (nonatomic, copy) HeaderViewImageTap headerImageTap;
@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.avatarStr = @"";
//        self.nameStr = @"";
        [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame headerImageTap:(HeaderViewImageTap)headerImageTap{
    self = [self initWithFrame:frame];
    if (self) {
        self.headerImageTap = headerImageTap;
    }
    return self;
}
-(void)setupSubviews{
    self.userInteractionEnabled=YES;
    self.layer.masksToBounds = YES;
    
    _backgroundImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImgView.layer.masksToBounds = YES;
    [self addSubview:_backgroundImgView];
    
    _avatarImageView=[[UIImageView alloc] init];
    _avatarImageView.bounds=CGRectMake(0, 0, 60, 60);
    _avatarImageView.layer.cornerRadius=CGRectGetWidth(_avatarImageView.bounds)/2;
    _avatarImageView.layer.masksToBounds=YES;
    _avatarImageView.contentMode=UIViewContentModeScaleAspectFill;
    _avatarImageView.center=CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    _avatarImageView.backgroundColor=[UIColor whiteColor];
    _avatarImageView.image = [GlobalFile HHSoftDefaultImg1_1];
//    [self addSubview:_avatarImageView];
    UITapGestureRecognizer *imgTapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    _avatarImageView.userInteractionEnabled=YES;
    [_avatarImageView addGestureRecognizer:imgTapGR];
    
    _nameLabel=[[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_avatarImageView.frame)+5, CGRectGetWidth(self.bounds)-20, 30) fontSize:14 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
//    [self addSubview:_nameLabel];
}
- (void)setAvatarStr:(NSString *)avatarStr {
    _avatarStr =avatarStr;
    if ([_avatarStr containsString:[GlobalFile domainName]]) {
        UIImage *cacheImage=[[HHSoftSDImageCache sharedImageCache] imageFromDiskCacheForKey:_avatarStr];
        if (!cacheImage) {
            cacheImage=[GlobalFile HHSoftDefaultImg1_1];
        }
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_avatarStr] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_avatarStr] placeholderImage:cacheImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, HHSoftSDImageCacheType cacheType, NSURL *imageURL) {
            if (image && !error) {
                _avatarImageView.image=image;
            }
        }];
    }else {
        _avatarImageView.image = [UIImage imageWithContentsOfFile:_avatarStr];
    }
    
    //    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_avatarStr] placeholderImage:[GlobalFile defaultGroupPhotoImage]];
}
- (void)setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    _nameLabel.text = _nameStr;
}
- (void)setNameAttributedText:(NSAttributedString *)nameAttributedText {
    _nameAttributedText = nameAttributedText;
    _nameLabel.attributedText = _nameAttributedText;
}
- (void)setBackGroundImage:(UIImage *)backGroundImage {
    _backGroundImage = backGroundImage;
    _backgroundImgView.image = _backGroundImage;
}
- (void)setNameColor:(UIColor *)nameColor {
    _nameColor = nameColor;
    self.nameLabel.textColor = _nameColor;
}
-(void)imageTap:(UITapGestureRecognizer *)tapGR{
    if (self.headerImageTap) {
        self.headerImageTap();
    }
}
@end
