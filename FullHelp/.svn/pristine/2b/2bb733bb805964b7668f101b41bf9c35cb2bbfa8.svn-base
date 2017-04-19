//
//  AccountNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>
#import "WXApiObject.h"

@class AccountInfo, WithdrawalViewModel, UserInfo;

//我的钱包信息
typedef void(^GetUserAccountInfoSuccessed)(NSInteger code, AccountInfo *accountInfo);

//获取账户列表
typedef void(^GetMyAccountListSuccessed)(NSInteger code, NSMutableArray *arrData);

//获取银行列表
typedef void(^GetBankListSuccessed)(NSInteger code, NSMutableArray *arrData);

//添加提现账户
typedef void (^AddUserAccountSuccessed)(NSInteger code);

//设置默认账户
typedef void (^SetDefaultAccountSuccessed)(NSInteger code);

//删除账户
typedef void (^DeleteAccountSuccessed)(NSInteger code);

//修改提现密码
typedef void (^UpdateWithdrawalsPwdSuccessed)(NSInteger code);

//申请提现获取用户余额和默认账户
typedef void(^GetUserFeesAndDefaultSuccessed)(NSInteger code, WithdrawalViewModel *withdrawalViewModel);

//申请提现
typedef void(^SubmitUserApplyAmountSuccess)(NSInteger code);

//获取资金流水列表
typedef void(^GetAccountChangeListSuccessed)(NSInteger code, NSMutableArray *arrData);

//收到/发出的红包
typedef void (^GetUserRedRecordSuccessed)(NSInteger code, UserInfo *userInfo);


//充值
typedef void(^AddRechargeSuccessed)(NSInteger code, NSString *alipayResult, PayReq *payReq);
//获取充值列表
typedef void(^GetRechargeRecordListSuccessed)(NSInteger code, NSMutableArray *arrData);

//获取数据失败
typedef void (^GetDataFailed)(NSError *error);

@interface AccountNetWorkEngine : HHSoftNetWorkEngine

/**
 我的钱包信息
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserAccountInfoWithUserID:(NSInteger)userID
                                         successed:(GetUserAccountInfoSuccessed)successed
                                            failed:(GetDataFailed)failed;

/**
 账户列表
 
 @param userID      用户ID
 @param page        第几页
 @param pageSize    每页显示几条
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getMyAccountListWithUserID:(NSInteger)userID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetMyAccountListSuccessed)successed
                                          failed:(GetDataFailed)failed;

/**
 银行列表
 
 @param page        第几页
 @param pageSize    每页显示几条
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getBankListWithPage:(NSInteger)page
                                 pageSize:(NSInteger)pageSize
                                successed:(GetBankListSuccessed)successed
                                   failed:(GetDataFailed)failed;

/**
 添加提现账户
 
 @param userID      用户ID
 @param accountNo   账户
 @param accountType 账户类型【 1：支付宝，2：微信 3：银行卡】
 @param trueName    真实姓名
 @param verifyCode  验证码
 @param isDefault   是否默认[0:否,1:是]
 @param bankName    银行名称
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addUserAccountWithUserID:(NSInteger)userID
                                     accountNo:(NSString *)accountNo
                                   accountType:(NSInteger)accountType
                                      trueName:(NSString *)trueName
                                    verifyCode:(NSString *)verifyCode
                                     isDefault:(NSInteger)isDefault
                                      bankName:(NSString *)bankName
                                     successed:(AddUserAccountSuccessed)successed
                                        failed:(GetDataFailed)failed;

/**
 设置默认账户
 
 @param accountID       账户ID
 @param successed       成功
 @param failed          失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)setDefaultAccountWithUserAccountID:(NSInteger)accountID
                                               successed:(SetDefaultAccountSuccessed)successed
                                                  failed:(GetDataFailed)failed;

/**
 删除账户
 
 @param accountID       账户ID
 @param userID          用户ID
 @param successed       成功
 @param failed          失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)deleteAccountWithUserAccountID:(NSInteger)accountID
                                              userID:(NSInteger)userID
                                           successed:(DeleteAccountSuccessed)successed
                                              failed:(GetDataFailed)failed;


/**
 修改提现密码
 
 @param userID         用户ID
 @param verifyCode     验证码
 @param withdrawalsPwd 提现密码
 @param successed      成功
 @param failed         失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)updateWithdrawalsPwdWithUserID:(NSInteger)userID
                                          verifyCode:(NSString *)verifyCode
                                      withdrawalsPwd:(NSString *)withdrawalsPwd
                                           successed:(UpdateWithdrawalsPwdSuccessed)successed
                                              failed:(GetDataFailed)failed;


/**
 申请提现获取用户余额和默认账户
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserFeesAndDefaultWithUserID:(NSInteger)userID
                                            successed:(GetUserFeesAndDefaultSuccessed)successed
                                               failed:(GetDataFailed)failed;

/**
 申请提现

 @param userID      用户ID
 @param accountID   账户ID
 @param applyAmount 申请金额
 @param applyPwd    提现密码【MD5一次加密】
 @param successed   成功
 @param failed      失败

 @return NSURLSessionTask
 */
- (NSURLSessionTask *)submitUserApplyAmountWithUserID:(NSInteger)userID
                                            accountID:(NSInteger)accountID
                                          applyAmount:(CGFloat)applyAmount
                                             applyPwd:(NSString *)applyPwd
                                            successed:(SubmitUserApplyAmountSuccess)successed
                                               failed:(GetDataFailed)failed;

/**
 资金流水
 
 @param userID    用户ID
 @param page      第几页
 @param pageSize  每页显示几条
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getAccountChangeListWithUserID:(NSInteger)userID
                                                page:(NSInteger)page
                                            pageSize:(NSInteger)pageSize
                                           successed:(GetAccountChangeListSuccessed)successed
                                              failed:(GetDataFailed)failed;

/**
 充值
 
 @param userID              用户ID
 @param payType             【1：支付宝 2：微信】
 @param rechargeAmount      充值金额
 @param successed           成功
 @param failed              失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addRechargeWithUserID:(NSInteger)userID
                                    payType:(NSInteger)payType
                             rechargeAmount:(CGFloat)rechargeAmount
                                  successed:(AddRechargeSuccessed)successed
                                     failed:(GetDataFailed)failed;

/**
 充值记录
 
 @param userID    用户ID
 @param page      第几页
 @param pageSize  每页显示几条
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRechargeRecordListWithUserID:(NSInteger)userID
                                                 page:(NSInteger)page
                                             pageSize:(NSInteger)pageSize
                                            successed:(GetRechargeRecordListSuccessed)successed
                                               failed:(GetDataFailed)failed;

/**
 收到/发出的红包
 
 @param userID    用户ID
 @param page      第几页
 @param pageSize  每页显示几条
 @param mark      1:收到红包 2：发出红包
 @param redType   0 :全部 1：今日红包 2：口令红包 3：需求红包 4：游戏红包 5:登录红包 6:专场红包 7:电话红包 8:申请打赏红包
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserRedRecordListWithUserID:(NSInteger)userID
                                                page:(NSInteger)page
                                            pageSize:(NSInteger)pageSize
                                                mark:(NSInteger)mark
                                             redType:(NSInteger)redType
                                           successed:(GetUserRedRecordSuccessed)successed
                                              failed:(GetDataFailed)failed;


@end
