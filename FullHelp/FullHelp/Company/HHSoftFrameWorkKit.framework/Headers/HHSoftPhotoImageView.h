//
//  HHSoftPhotoImageView.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15/9/26.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSoftUploadImageInfo.h"
#import "HHSoftPhotoImageCell.h"


typedef void(^SelectPhotoArrBlock)(NSMutableArray *arrHHSoftUploadImageInfo);

typedef void(^SelectSinglePhotoBlock)(HHSoftUploadImageInfo *uploadImageInfo);

typedef void(^DeletePhotoBlock)(NSInteger uploadImageID,NSInteger imgViewIndex);

typedef void (^SingleImageViewPressed)(NSInteger uploadImageID,NSInteger imgViewIndex);

/**
 *  点击选择图片按钮后的block
 */
typedef void(^SelectUploadImageViewPressed)();

@interface HHSoftPhotoImageView : UIView

-(id)initWithselectPhotoImage:(UIImage *)selectPhotoImage selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
                        compressImageSize:(CGSize)compressImageSize
                            showImageSize:(CGSize)showImageSize
                        maxUploadImageCount:(NSInteger)maxUploadImageCount
                            targetController:(UIViewController *)targetController
                        selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
                            deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
                        selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
                        singleImageViewPressed:(SingleImageViewPressed)singleImageViewPessed
                            isShowBigImageView:(BOOL)isShowBigImageView
                        singleRowImageCount:(NSInteger)singleRowImageCount
                    compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod;

-(id)initWithselectPhotoImage:(UIImage *)selectPhotoImage selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
            compressImageSize:(CGSize)compressImageSize
                showImageSize:(CGSize)showImageSize
          maxUploadImageCount:(NSInteger)maxUploadImageCount
             targetController:(UIViewController *)targetController
          selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
             deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
       selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
          singleRowImageCount:(NSInteger)singleRowImageCount
        compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod;

-(id)initWithselectPhotoImage:(UIImage *)selectPhotoImage selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
            compressImageSize:(CGSize)compressImageSize
                showImageSize:(CGSize)showImageSize
          maxUploadImageCount:(NSInteger)maxUploadImageCount
             targetController:(UIViewController *)targetController
          selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
             deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
       selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
       singleImageViewPressed:(SingleImageViewPressed)singleImageViewPessed
           isShowBigImageView:(BOOL)isShowBigImageView
          singleRowImageCount:(NSInteger)singleRowImageCount
      compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod
 selectUploadImageViewPressed:(SelectUploadImageViewPressed)selectUploadImageViewPressed;



/**
 *  给TableCell赋值
 *
 *  @param arrHHSoftUplaodImageInfo 切记：一定是HHSoftUploadInfo的数组
 */
-(void)setArrarImage:(NSMutableArray *)arrHHSoftUplaodImageInfo;
/**
 *  不让删除按钮和上传图片按钮展示
 */
-(void)setSelectImageViewHidden;

@end
