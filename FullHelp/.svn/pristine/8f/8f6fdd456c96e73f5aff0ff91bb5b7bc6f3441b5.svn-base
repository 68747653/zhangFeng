//
//  UIImage+HHSoft.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-7-3.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HHSoft)
/**
 *  按照给定的尺寸等比例缩放图片
 *
 *  @param sourceImage           源图片文件
 *  @param size                  指定的尺寸
 *  @param compressImageErrorMsg nil:压缩成功 其他的返回的都是压缩失败的原因
 *
 *  @return 返回一个新的图片
 */
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size compressErrorMsg:(NSString **)compressImageErrorMsg;
/**
 *  按照给定的宽度等比例缩放图片
 *
 *  @param sourceImage           源图片文件
 *  @param defineWidth           指定的宽度
 *  @param compressImageErrorMsg nil:压缩成功 其他的返回的都是压缩失败的原因
 *
 *  @return 返回一个新的图片
 */
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth compressErrorMsg:(NSString **)compressImageErrorMsg;

@end
