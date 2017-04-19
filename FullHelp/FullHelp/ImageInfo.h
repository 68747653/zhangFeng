//
//  ImageInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageInfo : NSObject

/**
 图集ID
 */
@property (nonatomic, assign) NSInteger imageID;

/**
 图集ID
 */
@property (nonatomic,assign) NSInteger galleryID;

/**
 原图
 */
@property (nonatomic, copy) NSString *imageSource;

/**
 大图
 */
@property (nonatomic, copy) NSString *imageBig;

/**
 缩略图
 */
@property (nonatomic, copy) NSString *imageThumb;

/**
 简介
 */
@property (nonatomic, copy) NSString *imageDesc;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@end
