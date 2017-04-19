//
//  AdvertBottomView.h
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertInfo;

typedef void(^BottomCollectAdvertBlock)(NSInteger isCollect);
typedef void(^BottomPraiseAdvertBlock)(NSInteger isPraise);
typedef void(^BottomCommentAdvertBlock)();
typedef void(^BottomTelAdvertBlock)();
typedef void(^BottomRedAdvertBlock)();

@interface AdvertBottomView : UIView
@property (nonatomic,strong) AdvertInfo *advertInfo;
-(instancetype)initWithFrame:(CGRect)frame BottomCollectAdvertBlock:(BottomCollectAdvertBlock)collectAdvertBlock BottomPraiseAdvertBlock:(BottomPraiseAdvertBlock)praiseAdvertBlock BottomCommentAdvertBlock:(BottomCommentAdvertBlock)commentAdvertBlock BottomTelAdvertBlock:(BottomTelAdvertBlock)telAdvertBlock BottomRedAdvertBlock:(BottomRedAdvertBlock)redAdvertBlock;
@end
