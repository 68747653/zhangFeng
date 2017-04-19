//
//  HHSoftPhotoBrowser.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-7-13.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    TypePop=1,
    TypePush=2
} ShowType;

@interface HHSoftPhotoBrowser : NSObject

+(id)shared;

@property (nonatomic,strong) NSMutableArray *arrPhotoURLs;


-(void)showPhotos:(NSMutableArray *)arrPhotoURLs currentPhotoIndex:(NSUInteger)currentIndex
                                                inTargetController:(UIViewController *)taregetController;

@end
