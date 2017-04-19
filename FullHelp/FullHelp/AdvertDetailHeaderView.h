//
//  AdvertDetailHeaderView.h
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertInfo;

typedef void(^AdvertDetailHeaderViewImageBlock)(NSMutableArray *arrImage, NSInteger index);

@interface AdvertDetailHeaderView : UIView
-(instancetype)initWithFrame:(CGRect)frame AdvertInfo:(AdvertInfo *)advertInfo AdvertDetailHeaderViewImageBlock:(AdvertDetailHeaderViewImageBlock)imageBlock;
@end
