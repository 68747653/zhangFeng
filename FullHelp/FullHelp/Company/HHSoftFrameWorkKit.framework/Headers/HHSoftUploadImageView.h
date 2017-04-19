//
//  HHSoftUploadImageView.h
//  FrameTest
//
//  Created by dgl on 15-7-3.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHSoftUploadImageInfo;

typedef void(^DeleteImageBlock)(NSInteger imgViewIndex);
typedef void(^WatchBigImageBlock)(NSInteger imgViewIndex);


@interface HHSoftUploadImageView : UIImageView
/**
 *  ImageView中包含的信息
 */
@property (nonatomic,strong) HHSoftUploadImageInfo *hhsoftUploadImageInfo;
/**
 *  是否已加载图片
 */
@property (nonatomic,assign) BOOL isLoadImage;

@property (nonatomic,assign) NSInteger imgViewIndex;

-(void)loadImageImageViewAddWatchBigImageBlock:(WatchBigImageBlock)watchBigImageBlock deleteImageBlock:(DeleteImageBlock)deleteImageBlock;



@end
