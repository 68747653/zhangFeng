//
//  RedPacketView.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RedPacketInfo;
typedef NS_ENUM(NSInteger,RedPacketType) {
    RedPacketTypeRegister =0,//注册红包
    RedPacketTypePublishDemand,//发布需求红包
    RedPacketTypeAdvertRed,    //专场红包
    RedPacketTypeAdvertTelRed, //电话红包
    RedPacketTypeToday      ,//今日红包
    RedPacketTypeGame       ,//游戏红包
    RedPacketTypeScene      ,//场景红包
};
typedef void (^OpenRedPacket)(NSString *amount);
@interface RedPacketView : UIView
@property (nonatomic, strong) RedPacketInfo *redPacketInfo;
@property (nonatomic, assign) NSInteger demandID;
@property (nonatomic, assign) RedPacketType redPacketType;
@property (nonatomic, assign) NSInteger advertID;
@property (nonatomic, assign) NSInteger browseTime;
- (instancetype)initWithFrame:(CGRect)frame openRedPacket:(OpenRedPacket)openRedPacket;
- (void)stopAnimation;
@end
