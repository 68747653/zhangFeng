//
//  GameInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
@interface GameInfo : NSObject

@property (nonatomic, assign) NSInteger gameID;
@property (nonatomic, copy) NSString *gameName;

/**
 游戏链接
 */
@property (nonatomic, copy) NSString *gameUrl;

/**
 缩略图
 */
@property (nonatomic, copy) NSString *gameThumImg;

/**
 浏览时长
 */
@property (nonatomic, assign) NSInteger gameBrowseTime;

/**
 游戏红包ID
 */
@property (nonatomic, assign) NSInteger gameRedID;

/**
 广告ID
 */
@property (nonatomic, assign) NSInteger advertID;

/**
 广告图片
 */
@property (nonatomic, copy) NSString *advertImg;

/**
 是否领取0未领取，1已领取
 */
@property (nonatomic, assign) BOOL isReceive;
    @property (nonatomic, strong) UserInfo *userInfo;

@end
