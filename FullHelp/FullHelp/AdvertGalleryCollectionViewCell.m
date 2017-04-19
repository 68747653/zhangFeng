//
//  AdvertGalleryCollectionViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertGalleryCollectionViewCell.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import "ImageInfo.h"

@interface AdvertGalleryCollectionViewCell ()
@property (nonatomic, strong) UIImageView *galleryImageView;

@end

@implementation AdvertGalleryCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGoodsRowCollectionViewCellWithFrame:frame];
    }
    return self;
}
- (void)initGoodsRowCollectionViewCellWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor whiteColor];
    //图片
    _galleryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _galleryImageView.contentMode = UIViewContentModeScaleAspectFill;
    _galleryImageView.layer.masksToBounds = YES;
    [self addSubview:_galleryImageView];
}
-(void)setImageInfo:(ImageInfo *)imageInfo{
    _imageInfo = imageInfo;
    //图片
    [_galleryImageView sd_setImageWithURL:[NSURL URLWithString:_imageInfo.imageBig] placeholderImage:[GlobalFile HHSoftDefaultImg5_8]];
    
}

@end
