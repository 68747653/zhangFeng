//
//  HHSoftShareTool.m
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-4-10.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import "HHSoftShareTool.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <MessageUI/MessageUI.h>

static HHSoftShareTool *hhsoftShareTool;
static NSString *qqHandelKey=@"tencent1105973612";
static NSString *tencentKey=@"1105973612";

@interface HHSoftShareTool()<WXApiDelegate,WeiboSDKDelegate,QQApiInterfaceDelegate>
@property (nonatomic,strong) NSString *shareMessage;
@property (nonatomic,strong) UIImage *thumbImage;
@property (nonatomic,strong) NSData *imgData;
@property (nonatomic,strong) NSString *shareTitle;
@property (nonatomic,strong) NSString *shareDescription;
@property (nonatomic,strong) NSString *linkUrl;
@property (nonatomic,assign) NSInteger shareType;
@property (nonatomic,assign) int wxShareType;
@property (nonatomic,strong) ShareResponse shareResponse;
@property (nonatomic,strong) NSString* wbtoken;
@property(nonatomic,strong)TencentOAuth *tencentOAuth;
@property (nonatomic,assign) NSInteger tencentSharePlateForm;

@end

@implementation HHSoftShareTool

+(id)sharedHHSoftShareTool{
    @synchronized(self){
        if (nil==hhsoftShareTool) {
            hhsoftShareTool=[[HHSoftShareTool alloc]  init];
        }
    }
    return hhsoftShareTool;
}

-(BOOL)hhsoftShareHandlerOpenUrl:(NSURL *)url key:(NSDictionary *)dictKey{
    BOOL can=NO;
    NSString *str=[NSString stringWithFormat:@"%@",url];
    NSString *weiXinID=[dictKey objectForKey:@"wxid"];
    NSString *sinaWeiBoKey=[dictKey objectForKey:@"sinaweibokey"];
    if ([str rangeOfString:weiXinID].length) {
        if ([WXApi handleOpenURL:url delegate:self]) {
            can=YES;
        }else{
            can=NO;
        }
    }
    else if ([str rangeOfString:sinaWeiBoKey].length){
        if ([WeiboSDK handleOpenURL:url delegate:self]) {
            can=YES;
        }
        else
        {
            can=NO;
        }
    }
    else if ([str rangeOfString:qqHandelKey].length){
        if ([QQApiInterface handleOpenURL:url delegate:self]) {
            can=YES;
        }
        else
        {
            can=NO;
        }
    }
    return can;
}
-(BOOL)hhsoftShareOpenURL:(NSURL *)url key:(NSDictionary *)dictKey{
    BOOL can=NO;
    NSString *str=[NSString stringWithFormat:@"%@",url];
    NSString *weiXinID=[dictKey objectForKey:@"wxid"];
    NSString *sinaWeiBoKey=[dictKey objectForKey:@"sinaweibokey"];
    if ([str rangeOfString:weiXinID].length) {
        if ([WXApi handleOpenURL:url delegate:self]) {
            can=YES;
        }else{
            can=NO;
        }
    }
    else if ([str rangeOfString:sinaWeiBoKey].length){
        if ([WeiboSDK handleOpenURL:url delegate:self]) {
            can=YES;
        }else
        {
            can=NO;
        }
    }
    else if ([str rangeOfString:qqHandelKey].length){
        if ([QQApiInterface handleOpenURL:url delegate:self]) {
            can=YES;
        }
        else
        {
            can=NO;
        }
    }
    return can;
}

-(void)shareMessage:(NSString *)message shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse
{
    _shareMessage=message;
    _shareType=0;
    _shareResponse=shareResponse;
    switch (sharePlatFormType) {
        case SharePlatFormWXFriend:
            //微信好友
            [self wxSendMessage:WXSceneSession text:message];
            break;
        case SharePlatFormWXSpace:
            //微信朋友圈
            [self wxSendMessage:WXSceneTimeline text:message];
            break;
        case SharePlatFormSinaWeiBo:
            //新浪微博
            [self sinaWeiBoSendMessage:message];
            break;
        case SharePlatFormQQFriend:
            //QQ好友
            _tencentSharePlateForm=0;
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            [self tencentShareMessage:message];
            break;
        case SharePlatFormQQSpace:
            //QQ空间
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            _tencentSharePlateForm=1;
            [self tencentShareMessage:message];
            break;
        default:
            break;
    }
}

-(void)shareImage:(UIImage *)thumbImage imageData:(NSData *)imgData  message:(NSString *)message shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse
{
    _thumbImage=thumbImage;
    _imgData=imgData;
    _shareType=1;
    _shareResponse=shareResponse;
    switch (sharePlatFormType) {
        case SharePlatFormWXFriend:
            //微信好友
            [self wxSendImage:WXSceneSession thumbImage:thumbImage sendImageData:imgData];
            break;
        case SharePlatFormWXSpace:
            //微信朋友圈
            [self wxSendImage:WXSceneTimeline thumbImage:thumbImage sendImageData:imgData];
            break;
        case SharePlatFormSinaWeiBo:
            //新浪微博
            [self sinaWeiBoSendImage:imgData message:message];
            break;
        case SharePlatFormQQFriend:
            //QQ好友
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            _tencentSharePlateForm=0;
            [self tencentShareImage:imgData title:message description:message];
            break;
        case SharePlatFormQQSpace:
            //QQ空间
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            _tencentSharePlateForm=1;
            [self tencentShareImage:imgData title:message description:message];
            break;
        default:
            break;
    }
}
-(void)shareLinkContentWithTitle:(NSString *)title description:(NSString *)description thumgImage:(UIImage *)thumgImage linkUrl:(NSString *)linkUrl shareplatForm:(SharePlatFormType)sharePlatFormType shareResponse:(ShareResponse)shareResponse
{
    _shareTitle=title;
    _shareDescription=description;
    _thumbImage=thumgImage;
    _linkUrl=linkUrl;
    _shareType=2;
    _shareResponse=shareResponse;
    switch (sharePlatFormType) {
        case SharePlatFormWXFriend:
            //微信好友
            [self wxSendLinkContent:WXSceneSession title:title description:description thumbImage:thumgImage linkUrl:linkUrl];
            break;
        case SharePlatFormWXSpace:
            //微信朋友圈
            [self wxSendLinkContent:WXSceneTimeline title:title description:description thumbImage:thumgImage linkUrl:linkUrl];
            break;
        case SharePlatFormSinaWeiBo:
            //新浪微博
            [self sinaWeiBoSendLinkContent:title description:description imageData:UIImageJPEGRepresentation(thumgImage, 1.0) linkUrl:linkUrl];
            break;
        case SharePlatFormQQFriend:
            //QQ好友
            _tencentSharePlateForm=0;
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            [self tencentShareLinkContent:UIImageJPEGRepresentation(thumgImage, 1.0) title:title description:description linkUrl:linkUrl];
            break;
        case SharePlatFormQQSpace:
            //QQ空间
            _tencentSharePlateForm=1;
            if (nil==_tencentOAuth) {
                _tencentOAuth=[[TencentOAuth alloc] initWithAppId:tencentKey andDelegate:nil];
            }
            [self tencentShareLinkContent:UIImageJPEGRepresentation(thumgImage, 1.0) title:title description:description linkUrl:linkUrl];
            break;
        default:
            break;
    }
}
#pragma mark -微信分享
/**
 *  发送纯文本
 */
-(void)wxSendMessage:(int)scene text:(NSString *)sendText
{
    _wxShareType=scene;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = sendText;
    req.bText = YES;
    req.scene = scene;
    [WXApi sendReq:req];
}
/**
 *  发送纯图片
 */
-(void)wxSendImage:(int)scene thumbImage:(UIImage *)thumbImage sendImageData:(NSData *)sendImageData
{
    _wxShareType=scene;
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImage];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = sendImageData;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_APP";
    message.messageExt = @"华韩软件";
    message.messageAction = @"<action>dotalist</action>";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}
/**
 *  发送外链文章
 *
 */
- (void)wxSendLinkContent:(int)scene title:(NSString *)sendTitle description:(NSString *)sendDescription thumbImage:(UIImage *)thumbImage linkUrl:(NSString *)urlString
{
    _wxShareType=scene;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = sendTitle;
    message.description = sendDescription;
    [message setThumbImage:thumbImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

-(void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        SharePlatFormType ssShareType;
        if (_wxShareType==WXSceneSession) {
            ssShareType=SharePlatFormWXFriend;
        }
        else{
            ssShareType=SharePlatFormWXSpace;
        }
        if (resp.errCode==0) {
            //分享成功
            _shareResponse(ShareSuccess,ssShareType);
        }
        else if (resp.errCode==1){
            //普通错误类型
            _shareResponse(ShareError,ssShareType);
        }
        else if (resp.errCode==-2){
            //取消
            _shareResponse(ShareCancel,ssShareType);
        }
        else if (resp.errCode==-3){
            //发送失败
            _shareResponse(ShareFail,ssShareType);
        }
    }else if ([resp isKindOfClass:[QQBaseResp class]]) {
        NSInteger code = [((QQBaseResp*)resp).result integerValue];
        if (code==0) {
            //分享成功
            _shareResponse(ShareSuccess,0);
        }
        else if (code==-4){
            //取消
            _shareResponse(ShareCancel,0);
        }
        else if (resp.errCode==-3){
            //发送失败
            _shareResponse(ShareFail,0);
        }
    }
}
#pragma mark -新浪微博分享
-(void)sinaWeiBoSendMessage:(NSString *)shareMessage
{
    WBMessageObject *message = [WBMessageObject message];
    message.text =shareMessage;
    [self sinaWeiBoShare:message];
    
}
-(void)sinaWeiBoSendImage:(NSData *)imageData message:(NSString *)sendTitle
{
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    message.text=sendTitle;
    image.imageData = imageData;
    message.imageObject = image;
    [self sinaWeiBoShare:message];
}
-(void)sinaWeiBoSendLinkContent:(NSString *)title description:(NSString *)description imageData:(NSData *)imgData linkUrl:(NSString *)linkUrl accessToken:(NSString *)accessToken shareResponse:(ShareResponse)shareResponse{
    _shareResponse=shareResponse;
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    image.imageData = imgData;
    message.imageObject = image;
    message.text = [description stringByAppendingString:linkUrl];
    if (accessToken.length) {
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:nil access_token:accessToken];
        BOOL aa = [WeiboSDK sendRequest:request];
        NSLog(@"%d",aa);
    }else{
        [self sinaWeiBoShare:message];
    }
}
-(void)sinaWeiBoSendLinkContent:(NSString *)title description:(NSString *)description imageData:(NSData *)imgData linkUrl:(NSString *)linkUrl
{
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    image.imageData = imgData;
    message.imageObject = image;
    message.text = [description stringByAppendingString:linkUrl];
    [self sinaWeiBoShare:message];
}
-(void)sinaWeiBoShare:(WBMessageObject *)message
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:_wbtoken];
    BOOL aa = [WeiboSDK sendRequest:request];
    NSLog(@"发送请求结果：%d",aa);
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                _shareResponse(ShareSuccess,SharePlatFormSinaWeiBo);
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                _shareResponse(ShareFail,SharePlatFormSinaWeiBo);
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                _shareResponse(ShareCancel,SharePlatFormSinaWeiBo);
                break;
            default:
                _shareResponse(ShareError,SharePlatFormSinaWeiBo);
                break;
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                _shareResponse(ShareSuccess,SharePlatFormSinaWeiBo);
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                _shareResponse(ShareFail,SharePlatFormSinaWeiBo);
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                _shareResponse(ShareCancel,SharePlatFormSinaWeiBo);
                break;
            default:
                _shareResponse(ShareError,SharePlatFormSinaWeiBo);
                break;
        }
    }
}
#pragma mark -tencent分享
-(void)tencentShareMessage:(NSString *)message
{
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:message];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode sent;
    if (_tencentSharePlateForm==0) {
         sent= [QQApiInterface sendReq:req];
    }
    else{
        sent = [QQApiInterface SendReqToQZone:req];
    }
//    [self dealTencentSendCode:sent];
}
-(void)tencentShareImage:(NSData *)imgData title:(NSString *)title description:(NSString *)description
{
    QQApiImageObject *imgObj=[QQApiImageObject objectWithData:imgData previewImageData:imgData title:title description:description];
    SendMessageToQQReq *req=[SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent;
    if (_tencentSharePlateForm==0) {
        sent= [QQApiInterface sendReq:req];
    }
    else{
        sent = [QQApiInterface SendReqToQZone:req];
    }
//    [self dealTencentSendCode:sent];
}
-(void)tencentShareLinkContent:(NSData *)imgData title:(NSString *)title description:(NSString *)description linkUrl:(NSString *)url
{
    QQApiNewsObject *newsObj=[QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:description previewImageData:imgData];
    SendMessageToQQReq *req=[SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent;
    if (_tencentSharePlateForm==0) {
        sent= [QQApiInterface sendReq:req];
    }
    else{
        sent = [QQApiInterface SendReqToQZone:req];
    }
//    [self dealTencentSendCode:sent];
}
-(void)dealTencentSendCode:(QQApiSendResultCode)code
{
    SharePlatFormType ssShareType;
    if (_tencentSharePlateForm==0) {
        ssShareType=SharePlatFormQQFriend;
    }
    else{
        ssShareType=SharePlatFormQQSpace;
    }
    switch (code) {
        case EQQAPISENDSUCESS:
            _shareResponse(ShareSuccess,ssShareType);
            break;
        case EQQAPISENDFAILD:
            _shareResponse(ShareFail,ssShareType);
            break;
        default:
            _shareResponse(ShareError,ssShareType);
            break;
    }
}

@end
