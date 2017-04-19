//
//  HHSoftPickerManager.h
//  FrameTest
//
//  Created by dgl on 15-7-2.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  选择图片或者拍照完成选择使用拍照的图片后，会调用此block
 *
 *  @param compressImage 选择的图片或者拍照后选择使用的图片（压缩后的图片）
 *  @param sourceImage   选择的图片或者拍照后选择使用的图片(原图)
 */
typedef void(^HHSoftPhotoPickerUnionCompelitionBlock)(UIImage *compressImage,UIImage *sourceImage);

/**
 *  用户点击取消时的回调block
 */
typedef void (^HHSoftPhotoPickerCancelBlock)();

@interface HHSoftPhotoPickerManager : NSObject

+ (HHSoftPhotoPickerManager *)shared;

/**
 *  调起选择图片或者拍照
 *
 *  @param inView               UIActionSheet呈现到inView这个视图上
 *  @param fromController       用于呈现UIImagePickerController的控制器
 *  @param compressImageWidth   拍照/相册 过后压缩的图片的宽度
 *  @param compressImageHeight  拍照/相册 过后压缩的图片的高度
 *  @param compressImageClarity 照/相册 过后压缩的图片的质量（清晰度）
 *  @param completion           成后的回调（压缩后的图片和原图）
 *  @param cancelBlock          取消的回调
 */
- (void)showActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
           compressImageWidth:(CGFloat)compressImageWidth
          compressImageHeight:(CGFloat)compressImageHeight
              compressclarity:(CGFloat)compressImageClarity
              unionCompletion:(HHSoftPhotoPickerUnionCompelitionBlock)completion
                  cancelBlock:(HHSoftPhotoPickerCancelBlock)cancelBlock;

/**
 *  调起选择图片或者拍照（可以设置选择图片是否可编辑）
 *
 *  @param inView               UIActionSheet呈现到inView这个视图上
 *  @param fromController       用于呈现UIImagePickerController的控制器
 *  @param compressImageWidth   拍照/相册 过后压缩的图片的宽度
 *  @param compressImageHeight  拍照/相册 过后压缩的图片的高度
 *  @param compressImageClarity 照/相册 过后压缩的图片的质量（清晰度）
 *  @param isImageAllowEditing  拍照或者相册选取图片是否可以编辑
 *  @param completion           成后的回调（压缩后的图片和原图）
 *  @param cancelBlock          取消的回调
 */
- (void)showActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
           compressImageWidth:(CGFloat)compressImageWidth
          compressImageHeight:(CGFloat)compressImageHeight
              compressclarity:(CGFloat)compressImageClarity
          isImageAllowEditing:(BOOL)isImageAllowEditing
              unionCompletion:(HHSoftPhotoPickerUnionCompelitionBlock)completion
                  cancelBlock:(HHSoftPhotoPickerCancelBlock)cancelBlock;

/**
 *  调起选择图片或者拍照(压缩后图片以实际尺寸存储)
 *
 *  @param inView               UIActionSheet呈现到inView这个视图上
 *  @param fromController       用于呈现UIImagePickerController的控制器
 *  @param compressImageWidth   拍照/相册 过后压缩的图片的宽度
 *  @param compressImageHeight  拍照/相册 过后压缩的图片的高度
 *  @param compressImageClarity 照/相册 过后压缩的图片的质量（清晰度）
 *  @param completion           成后的回调（压缩后的图片和原图）
 *  @param cancelBlock          取消的回调
 */
- (void)showRealityDrawingActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
           compressImageWidth:(CGFloat)compressImageWidth
          compressImageHeight:(CGFloat)compressImageHeight
              compressclarity:(CGFloat)compressImageClarity
              unionCompletion:(HHSoftPhotoPickerUnionCompelitionBlock)completion
                  cancelBlock:(HHSoftPhotoPickerCancelBlock)cancelBlock;

/**
 *  调起选择图片或者拍照(压缩后图片以实际尺寸存储)
 *
 *  @param inView               UIActionSheet呈现到inView这个视图上
 *  @param fromController       用于呈现UIImagePickerController的控制器
 *  @param compressImageWidth   拍照/相册 过后压缩的图片的宽度
 *  @param compressImageHeight  拍照/相册 过后压缩的图片的高度
 *  @param compressImageClarity 照/相册 过后压缩的图片的质量（清晰度）
 *  @param isImageAllowEditing  拍照或者相册选取图片是否可以编辑
 *  @param completion           成后的回调（压缩后的图片和原图）
 *  @param cancelBlock          取消的回调
 */
- (void)showRealityDrawingActionSheetInView:(UIView *)inView
                             fromController:(UIViewController *)fromController
                         compressImageWidth:(CGFloat)compressImageWidth
                        compressImageHeight:(CGFloat)compressImageHeight
                            compressclarity:(CGFloat)compressImageClarity
                        isImageAllowEditing:(BOOL)isImageAllowEditing
                            unionCompletion:(HHSoftPhotoPickerUnionCompelitionBlock)completion
                                cancelBlock:(HHSoftPhotoPickerCancelBlock)cancelBlock;

@end
