//
//  HHSoftMutiPhotoImageCell.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 16/7/6.
//  Copyright © 2016年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSoftUploadImageInfo.h"

typedef enum : NSUInteger {
    MethodTargetSize=0,
    MethodRealitySize=1,
} CompressageImageSaveMethod;

/**
 * 选中图片以后的数组Block
 *
 *  @param arrHHSoftUploadImageInfo 选择图片以后的数组
 */
typedef void(^SelectPhotoArrBlock)(NSMutableArray *arrHHSoftUploadImageInfo);
/**
 *  <#Description#>
 *
 *  @param uploadImageInfo <#uploadImageInfo description#>
 */
typedef void(^SelectSinglePhotoBlock)(HHSoftUploadImageInfo *uploadImageInfo);

typedef void(^DeletePhotoBlock)(NSInteger uploadImageID,NSInteger imgViewIndex);

typedef void (^SingleImageViewPressed)(NSInteger uploadImageID,NSInteger imgViewIndex);
/**
 *  点击选择图片按钮后的block
 */
typedef void(^SelectUploadImageViewPressed)();

@interface HHSoftMutiPhotoImageCell : UITableViewCell

/**
 *  初始化Cell
 *
 *  @param style                  Cell的样式
 *  @param reuseIdentifier        Cell的标识
 *  @param selectPhotoImage       选择文件按钮的图片
 *  @param selectPhotoImageCorner 选择文件按钮的弧度
 *  @param compressImageSize      压缩后文件的尺寸
 *  @param showImageSize          展示文件的控件的尺寸
 *  @param columnCount            一行展示的图片个数
 *  @param maxUploadImageCount    最大上传数量
 *  @param targetController    要实现此功能的Controller
 *
 *  @return TableCell
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
  selectPhotoImage:(UIImage *)selectPhotoImage
selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
 compressImageSize:(CGSize)compressImageSize
     showImageSize:(CGSize)showImageSize
maxUploadImageCount:(NSInteger)maxUploadImageCount
  targetController:(UIViewController *)targetController
selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
  deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod
alreadySelectImageCount:(NSInteger)alreadySelectImageCount;
/**
 *  初始化点击图片自定义方法的Cell
 *
 *  @param style                  Cell的样式
 *  @param reuseIdentifier        Cell的标识
 *  @param selectPhotoImage       选择文件按钮的图片
 *  @param selectPhotoImageCorner 选择文件按钮的弧度
 *  @param compressImageSize      压缩后文件的尺寸
 *  @param showImageSize          展示文件的控件的尺寸
 *  @param maxUploadImageCount    最大上传图片数量
 *  @param targetController       要实现此功能的Controller
 *  @param selectPhotoArrBlock    选择文件后的数组的Block
 *  @param deletePhotoBlock       删除图片后的Block
 *  @param selectSinglePhotoBlock 选中单图后的Block
 *  @param singleImageViewPessed  当isShowBigImageView为No时，执行的方法
 *  @param isShowBigImageView     是否点击小图弹出来查看大图（默认Yes）
 *
 *  @return
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
  selectPhotoImage:(UIImage *)selectPhotoImage
selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
 compressImageSize:(CGSize)compressImageSize
     showImageSize:(CGSize)showImageSize
maxUploadImageCount:(NSInteger)maxUploadImageCount
  targetController:(UIViewController *)targetController
selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
  deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
singleImageViewPressed:(SingleImageViewPressed)singleImageViewPessed
isShowBigImageView:(BOOL)isShowBigImageView
compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod
alreadySelectImageCount:(NSInteger)alreadySelectImageCount;
/**
 *  初始化点击图片自定义方法的Cell
 *
 *  @param style                  Cell的样式
 *  @param reuseIdentifier        Cell的标识
 *  @param selectPhotoImage       选择文件按钮的图片
 *  @param selectPhotoImageCorner 选择文件按钮的弧度
 *  @param compressImageSize      压缩后文件的尺寸
 *  @param showImageSize          展示文件的控件的尺寸
 *  @param maxUploadImageCount    最大上传图片数量
 *  @param targetController       要实现此功能的Controller
 *  @param selectPhotoArrBlock    选择文件后的数组的Block
 *  @param deletePhotoBlock       删除图片后的Block
 *  @param selectSinglePhotoBlock 选中单图后的Block
 *  @param singleImageViewPessed  当isShowBigImageView为No时，执行的方法
 *  @param isShowBigImageView     是否点击小图弹出来查看大图（默认Yes）
 *  @param SelectImageViewPressed 点击选择图片按钮后的操作（只是作用于键盘消失等等，单图选择还在起着作用）
 *  @return
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
  selectPhotoImage:(UIImage *)selectPhotoImage
selectPhotoImageCorner:(CGFloat)selectPhotoImageCorner
 compressImageSize:(CGSize)compressImageSize
     showImageSize:(CGSize)showImageSize
maxUploadImageCount:(NSInteger)maxUploadImageCount
  targetController:(UIViewController *)targetController
selectPhotoArrBlock:(SelectPhotoArrBlock)selectPhotoArrBlock
  deletePhotoBlock:(DeletePhotoBlock)deletePhotoBlock
selectSinglePhotoBlock:(SelectSinglePhotoBlock)selectSinglePhotoBlock
singleImageViewPressed:(SingleImageViewPressed)singleImageViewPessed
isShowBigImageView:(BOOL)isShowBigImageView
compressImageSaveMethod:(CompressageImageSaveMethod)compressageImageSaveMethod
selectImageViewPressed:(SelectUploadImageViewPressed)selectUploadImageViewPressed
alreadySelectImageCount:(NSInteger)alreadySelectImageCount;

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
