//
//  HomeRedPacketView.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeRedPacketView;
@class AdvertInfo;
@protocol HomeRedPackerViewDelegate <NSObject>
- (void)homeRedPackerView:(HomeRedPacketView *)homeRedPackerView advertInfo:(AdvertInfo *)advertInfo;
@end


@interface HomeRedPacketView : UIView

@property (nonatomic, strong) AdvertInfo *advertInfo;
@property (nonatomic, weak) id <HomeRedPackerViewDelegate> delegate;
@end
