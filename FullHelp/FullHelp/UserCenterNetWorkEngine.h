//
//  UserCenterNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>

@class UserInfo, PointsInfo;

//我的
typedef void(^GetUserCenterSuccessed)(NSInteger code, UserInfo *userInfo);

//个人信息
typedef void(^GetUserInfoSuccessed)(NSInteger code, UserInfo *userInfo);

//修改个人信息
typedef void(^EditUserInfoSuccessed)(NSInteger code, NSString *headImgStr);

//修改地址
typedef void(^EditUserAddressSuccessed)(NSInteger code);

//修改手机号
typedef void(^EditUserLoginNameSuccessed)(NSInteger code);

//修改密码
typedef void(^EditUserOldPasswordSuccessed)(NSInteger code);

//申请开通红包
typedef void(^UserApplyRedSuccessed)(NSInteger code);

//关闭打赏红包
typedef void(^UserColseRedSuccessed)(NSInteger code);

//咨询记录（商家/代货商）
typedef void(^GetConsultRecordListSuccessed)(NSInteger code,NSMutableArray *arrRecordList);
//我的发布列表
typedef void(^GetMyDemandNoticeListSuccessed)(NSInteger code,NSMutableArray *arrDemandNoticeList);
//我的发布删除
typedef void(^DeleteDemandNoticeInfoSuccessed)(NSInteger code);
//删除咨询记录
typedef void(^DeleteConsultRecordInfoSuccessed)(NSInteger code);

//联系我们
typedef void(^GetRegionIndustryListSuccessed)(NSInteger code, NSMutableArray *arrRegion);

//地区行业客服列表
typedef void(^GetCustomListSuccessed)(NSInteger code, NSMutableArray *arrCustomServicer);

//获取通知栏推送状态
typedef void(^GetIsPushSuccessed)(NSInteger code, UserInfo *userInfo);

//修改通知栏推送状态
typedef void(^EditIsPushSuccessed)(NSInteger code);

//获取用户积分数据
typedef void(^GetUserPointListSuccessed)(NSInteger code, PointsInfo *pointsInfo);

//签到
typedef void(^AddSignInfoSuccessed)(NSInteger code);

//获取积分规则列表
typedef void(^GetPointRuleListSuccessed)(NSInteger code, NSMutableArray *arrRule);

//积分申请提现
typedef void(^AddPointsWithdrawalsSuccessed)(NSInteger code);
//意见反馈
typedef void(^AddFeedBackSuccessed)(NSInteger code);
//获取消息列表
typedef void (^GetMessageListSuccessed)(NSInteger code, NSMutableArray *arrData);
//单个删除系统消息
typedef void (^DeleteSingleSystemUserSuccessed)(NSInteger code);
//清空系统消息
typedef void (^EmptySystemUserInfoSuccessed)(NSInteger code);
//获取系统消息详情
typedef void (^GetSystemInfoSuccessed)(NSInteger code, NSString *messageContent);
//我的打赏申请（商家/代理商）
typedef void (^GetApplyredListSuccessed)(NSInteger code, NSMutableArray *arrData);
//删除申请打赏信息
typedef void(^DeleteApplyRedInfoSuccessed)(NSInteger code);
//修改申请打赏状态
typedef void(^EditApplyRedInfoSuccessed)(NSInteger code);

//获取分享地址
typedef void (^GetShareAddressSuccessed)(NSInteger code, NSString *shareAddress);

//我的广告
typedef void (^GetRedAdvertListSuccessed)(NSInteger code, NSMutableArray *arrData);

//获取数据失败
typedef void(^GetDataFailed)(NSError *error);

@interface UserCenterNetWorkEngine : HHSoftNetWorkEngine

#pragma mark --- 获取用户积分列表
/**
 获取用户积分列表
 
 @param userID    用户ID
 @param pageIndex 页数
 @param pageSize  每页条数
 @param successed successed
 @param failed    failed
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserPointListWithUserID:(NSInteger)userID
                                       pageIndex:(NSInteger)pageIndex
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetUserPointListSuccessed)successed
                                          failed:(GetDataFailed)failed;

/**
 签到
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addSignInfoWithUserID:(NSInteger)userID
                                  successed:(AddSignInfoSuccessed)successed
                                     failed:(GetDataFailed)failed;

/**
 积分申请提现
 
 @param userID      用户ID
 @param points      提现积分
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addPointsWithdrawalsWithUserID:(NSInteger)userID
                                              points:(NSInteger)points
                                           successed:(AddPointsWithdrawalsSuccessed)successed
                                              failed:(GetDataFailed)failed;
#pragma mark --- 获取积分规则列表
/**
 获取积分规则列表
 
 @param pageIndex 页数
 @param pageSize  每页条数
 @param successed successed
 @param failed    failed
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getPointRuleListPageIndex:(NSInteger)pageIndex
                                       pageSize:(NSInteger)pageSize
                                      successed:(GetPointRuleListSuccessed)successed
                                         failed:(GetDataFailed)failed;

/**
 我的

 @param userID    用户ID
 @param successed 成功
 @param failed    失败

 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserCenterWithUserID:(NSInteger)userID
                                    successed:(GetUserCenterSuccessed)successed
                                       failed:(GetDataFailed)failed;

/**
 个人信息
 
 @param userID    用户ID
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserInfoWithUserID:(NSInteger)userID
                                  successed:(GetUserInfoSuccessed)successed
                                     failed:(GetDataFailed)failed;

/**
 修改个人信息
 
 @param userID      用户ID
 @param mark        1：头像，2：昵称，3：姓名，4：出生日期 5：店名1：验证原手机号吗· 2：修改手机号
 @param userInfoStr 对应的mark值
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserInfoWithUserID:(NSInteger)userID
                                        mark:(NSInteger)mark
                                 userInfoStr:(NSString *)userInfoStr
                                   successed:(EditUserInfoSuccessed)successed
                                      failed:(GetDataFailed)failed;

/**
 修改地址
 
 @param userID           用户ID
 @param lat              纬度
 @param lng              经度
 @param addressDetail    店铺地址
 @param houseNumber      门牌号
 @param successed        成功
 @param failed           失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserAddressWithWithUserID:(NSInteger)userID
                                                lat:(CGFloat)lat
                                                lng:(CGFloat)lng
                                      addressDetail:(NSString *)addressDetail
                                        houseNumber:(NSString *)houseNumber
                                          successed:(EditUserAddressSuccessed)successed
                                             failed:(GetDataFailed)failed;

/**
 修改手机号
 
 @param userID     用户ID
 @param mark       1：验证原手机号吗· 2：修改手机号
 @param userTel    用户手机号
 @param verifyCode 验证码
 @param successed  成功
 @param failed     失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserTelWithWithUserID:(NSInteger)userID
                                           mark:(NSInteger)mark
                                        userTel:(NSString *)userTel
                                     verifyCode:(NSString *)verifyCode
                                      successed:(EditUserLoginNameSuccessed)successed
                                         failed:(GetDataFailed)failed;

/**
 修改密码
 
 @param userID     用户ID
 @param newPwd     新密码
 @param oldPwd     旧密码
 @param successed  成功
 @param failed     失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserPwdWithUserID:(NSInteger)userID
                                     newPwd:(NSString *)newPwd
                                     oldPwd:(NSString *)oldPwd
                                  successed:(EditUserOldPasswordSuccessed)successed
                                     failed:(GetDataFailed)failed;

/**
 申请开通打赏红包
 
 @param userID    用户ID
 @param mark      1：开通红包打赏 2：设置红包打赏
 @param redNum    红包总数量
 @param redAmount 红包单个金额
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userApplyeRedWithUserID:(NSInteger)userID
                                         mark:(NSInteger)mark
                                       redNum:(NSInteger)redNum
                                    redAmount:(CGFloat)redAmount
                                    successed:(UserApplyRedSuccessed)successed
                                       failed:(GetDataFailed)failed;

/**
 关闭打赏红包
 
 @param userID    用户ID
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userColseRedWithUserID:(NSInteger)userID
                                   successed:(UserColseRedSuccessed)successed
                                      failed:(GetDataFailed)failed;

/**
 咨询记录（商家/代货商）

 @param userID    用户id
 @param userType  用户类型【1：商家 2：供货商】
 @param pageIndex 第几页
 @param pageSize  页数
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getConsultRecordListWithUserID:(NSInteger)userID
                                           UserType:(NSInteger)userType
                                          PageIndex:(NSInteger)pageIndex
                                           PageSize:(NSInteger)pageSize
                                            Succeed:(GetConsultRecordListSuccessed)succeed
                                             Failed:(GetDataFailed)failed;

/**
 我的发布列表

 @param userID    用户id
 @param userType  用户类型【1：商家 2：供货商】
 @param pageIndex 第几页
 @param pageSize  页数
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getMyDemandNoticeListWithUserID:(NSInteger)userID
                                            UserType:(NSInteger)userType
                                           PageIndex:(NSInteger)pageIndex
                                            PageSize:(NSInteger)pageSize
                                             Succeed:(GetMyDemandNoticeListSuccessed)succeed
                                              Failed:(GetDataFailed)failed;

/**
 我的发布删除

 @param userID         商家/供货商ID
 @param demandNoticeID 需求/公示公告ID
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteDemandNoticeInfoWithUserID:(NSInteger)userID
                                       DemandNoticeID:(NSInteger)demandNoticeID
                                              Succeed:(DeleteDemandNoticeInfoSuccessed)succeed
                                               Failed:(GetDataFailed)failed;

/**
 删除咨询记录
 
 @param userType       用户类型【1：商家 2;供货商】
 @param consultRecordID 记录id
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteConsultRecordInfoWithUserType:(NSInteger)userType
                                         ConsultRecordID:(NSInteger)consultRecordID
                                                 Succeed:(DeleteDemandNoticeInfoSuccessed)succeed
                                                  Failed:(GetDataFailed)failed;

/**
 联系我们
 
 @param userType      1:商家 2;代货商
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRegionIndustryListWithUserType:(NSInteger)userType
                                              successed:(GetRegionIndustryListSuccessed)successed
                                                 failed:(GetDataFailed)failed;

/**
 地区行业客服列表
 
 @param industryID  行业ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getCustomListWithIndustryID:(NSInteger)industryID
                                        successed:(GetCustomListSuccessed)successed
                                           failed:(GetDataFailed)failed;

/**
 获取通知栏推送状态
 
 @param userID    用户ID
 @param deviceToken 设备号
 @param deviceType  设备类型【0：安卓，1：IOS】
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getIsPushWithUserID:(NSInteger)userID
                              deviceToken:(NSString *)deviceToken
                               deviceType:(NSInteger)deviceType
                                successed:(GetIsPushSuccessed)successed
                                   failed:(GetDataFailed)failed;

/**
 修改通知栏推送状态
 
 @param userID    用户ID
 @param deviceToken 设备号
 @param deviceType  设备类型【0：安卓，1：IOS】
 @param isPush    用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editIsPushWithUserID:(NSInteger)userID
                               deviceToken:(NSString *)deviceToken
                                deviceType:(NSInteger)deviceType
                                    isPush:(NSInteger)isPush
                                 successed:(EditIsPushSuccessed)successed
                                    failed:(GetDataFailed)failed;

/**
 意见反馈

 @param userID          用户id
 @param feedBackType    1：功能异常 2，使用建议 3：功能需求 4.系统闪退 5： 检举投诉）
 @param telPhone        手机号码
 @param feedBackContent 反馈内容
 @param succeed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
-(NSURLSessionTask *)addFeedBackWithUserID:(NSInteger)userID
                              FeedBackType:(NSInteger)feedBackType
                                  TelPhone:(NSString *)telPhone
                           FeedBackContent:(NSString *)feedBackContent
                                  FilePath:(NSMutableArray *)filePath
                                   Succeed:(AddFeedBackSuccessed)succeed
                                    Failed:(GetDataFailed)failed;
/**
 获取系统消息列表
 
 @param userID   用户ID
 @param page     页数
 @param pageSize 每页显示的条数
 @param successed successed
 @param failed  failed
 
 @return  value
 */
- (NSURLSessionTask *)getMessageListWithUserID:(NSInteger)userID
                                          page:(NSInteger)page
                                      pageSize:(NSInteger)pageSize
                                     successed:(GetMessageListSuccessed)successed
                                        failed:(GetDataFailed)failed;
/**
 单个删除系统消息
 
 @param infoID      系统消息ID
 @param userID      用户ID
 @param successed   succeed
 @param getDataFail failed
 
 @return value
 */
-(NSURLSessionTask *)deleteSingleSystemWithInfoID:(NSInteger)infoID
                                           UserID:(NSInteger)userID
                  DeleteSingleSystemUserSuccessed:(DeleteSingleSystemUserSuccessed)successed
                                      GetDataFail:(GetDataFailed)getDataFail;
/**
 清空系统消息
 
 @param userID  用户ID
 @param succeed succeed
 @param fail    failed
 
 @return value
 */
-(NSURLSessionTask *)emptySystemUserInfoWithUserID:(NSInteger)userID
                                           succeed:(EmptySystemUserInfoSuccessed)succeed
                                              Fail:(GetDataFailed)fail;
/**
 获取系统消息详情
 
 @param systemID 系统消息ID
 @param successed successed
 @param failed    failed
 
 @return value
 */
- (NSURLSessionTask *)getSystemInfoWithSystemID:(NSInteger)systemID
                                         userID:(NSInteger)userID
                                      successed:(GetSystemInfoSuccessed)successed
                                         failed:(GetDataFailed)failed;

/**
 我的广告
 
 @param userID            用户ID
 @param page              第几页
 @param pageSize          每页显示几条
 @param isShelvesStr      是否上架：0：已下架，1：展示中，即将上架传空
 @param successed         成功
 @param failed            失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRedAdvertListWithUserID:(NSInteger)userID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                    isShelvesStr:(NSString *)isShelvesStr
                                       successed:(GetRedAdvertListSuccessed)successed
                                          failed:(GetDataFailed)failed;

/**
 分享地址
 
 @param successed         成功
 @param failed            失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getShareAddressSuccessed:(GetShareAddressSuccessed)successed
                                        failed:(GetDataFailed)failed;

/**
 我的打赏申请（商家/代理商）

 @param userID    用户id
 @param page      第几页
 @param pageSize  页数
 @param mark      打赏状态【-1:全部（默认） 1：申请中，2：已打赏，3：已拒绝】
 @param userType  角色类型（ 1：商家 2：供货商）
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getApplyRedListWithUserID:(NSInteger)userID
                                          Page:(NSInteger)page
                                      PageSize:(NSInteger)pageSize
                                          Mark:(NSInteger)mark
                                      UserType:(NSInteger)userType
                                        InfoID:(NSInteger)infoID
                                       Succeed:(GetMessageListSuccessed)successed
                                        Failed:(GetDataFailed)failed;

/**
 删除申请打赏信息

 @param userType   用户类型【1：商家 2：代理商】
 @param applyredID 打赏申请id
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteApplyRedInfoWithUserType:(NSInteger)userType
                                         ApplyredID:(NSInteger)applyredID
                                            Succeed:(DeleteApplyRedInfoSuccessed)successed
                                             Failed:(GetDataFailed)failed;

/**
 修改申请打赏状态

 @param userID       供货商id
 @param userType     1:商家 2:供货商
 @param applyRedID   未通过原因
 @param noPassReason 1：同意打赏 2：拒绝打赏
 @param mark         打赏id
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)editApplyRedInfoWithUserID:(NSInteger)userID
                                       UserType:(NSInteger)userType
                                     ApplyRedID:(NSInteger)applyRedID
                                   NoPassReason:(NSString *)noPassReason
                                           Mark:(NSInteger)mark
                                          Succeed:(EditApplyRedInfoSuccessed)successed
                                           Failed:(GetDataFailed)failed;

@end
