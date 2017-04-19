//
//  HHSoftShareTool.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-10.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHSoftFrameWorkKit/HHSoftShareView.h>


typedef enum : NSUInteger {
    ShareSuccess=0,
    ShareError=1,
    ShareCancel=2,
    ShareFail=3
} ShareResponseCode;

typedef void(^ShareResponse)(ShareResponseCode responseCode,SharePlatFormType sharePlatFormType);

@interface HHSoftShareTool : NSObject

+(id)sharedHHSoftShareTool;
-(BOOL)hhsoftShareHandlerOpenUrl:(NSURL *)url key:(NSDictionary *)dictKey;
-(BOOL)hhsoftShareOpenURL:(NSURL *)url key:(NSDictionary *)dictKey;

-(void)shareMessage:(NSString *)message shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse;

-(void)shareImage:(UIImage *)thumbImage imageData:(NSData *)imgData message:(NSString *)message shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse;

-(void)shareLinkContentWithTitle:(NSString *)title description:(NSString *)description thumgImage:(UIImage *)thumgImage linkUrl:(NSString *)linkUrl shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse;

-(void)sinaWeiBoSendLinkContent:(NSString *)title description:(NSString *)description imageData:(NSData *)imgData linkUrl:(NSString *)linkUrl accessToken:(NSString *)accessToken shareResponse:(ShareResponse)shareResponse;

@end
