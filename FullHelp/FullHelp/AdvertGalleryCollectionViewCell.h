//
//  AdvertGalleryCollectionViewCell.h
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageInfo;
@interface AdvertGalleryCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) ImageInfo *imageInfo;
- (instancetype)initWithFrame:(CGRect)frame;

@end
