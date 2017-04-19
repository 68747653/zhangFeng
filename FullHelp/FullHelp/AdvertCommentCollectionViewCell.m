//
//  AdvertCommentCollectionViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertCommentCollectionViewCell.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/UIImage+HHSoft.h>
#import "GlobalFile.h"
#import "ImageInfo.h"

@interface AdvertCommentCollectionViewCell()
@property (nonatomic, strong) UIImageView *commentImageView;
@end

@implementation AdvertCommentCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _commentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _commentImageView.layer.masksToBounds=YES;
        _commentImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_commentImageView];
    }
    return self;
}
- (void)setImageInfo:(ImageInfo *)imageInfo{
    _imageInfo = imageInfo;
    if (imageInfo.imageSource.length) {
        [_commentImageView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageSource] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    }else if (imageInfo.imageBig.length){
        [_commentImageView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageBig] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    }else if (imageInfo.imageThumb.length){
        [_commentImageView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageThumb] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    }else{
        _commentImageView.image = [GlobalFile HHSoftDefaultImg1_1];
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _commentImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
@end
