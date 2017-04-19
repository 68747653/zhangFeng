//
//  CommentInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UserInfo;
@interface CommentInfo : NSObject

/**
 评论ID
 */
@property (nonatomic,assign) NSInteger commentID;

/**
 评分
 */
@property (nonatomic,assign) CGFloat commentScore;

/**
 评论时间
 */
@property (nonatomic,copy) NSString *commentAddTime;

/**
 评论内容
 */
@property (nonatomic,copy) NSString *commentContent;

/**
 用户信息
 */
@property (nonatomic,strong) UserInfo *userInfo;

/**
 评论图集
 */
@property (nonatomic,strong) NSMutableArray *arrCommentGallery;

@end
