//
//  AccountNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AccountNetWorkEngine.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import <HHSoftFrameWorkKit/HHSoftEncrypt.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "WithdrawalViewModel.h"
#import "AccountInfo.h"
#import "AccountChangeInfo.h"
#import "BankInfo.h"
#import "UserInfo.h"

@implementation AccountNetWorkEngine

/**
 我的钱包信息
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserAccountInfoWithUserID:(NSInteger)userID
                                         successed:(GetUserAccountInfoSuccessed)successed
                                            failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getUserFeesUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        AccountInfo *accountInfo;
        NSInteger code = [self parseGetUserAccountInfoResultToAccountInfoModel:&accountInfo jsonString:responseString];
        successed(code, accountInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger )parseGetUserAccountInfoResultToAccountInfoModel:(AccountInfo **)accountInfoModel jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        AccountInfo *accountInfo = [[AccountInfo alloc]init];
        accountInfo.accountFees = [[resultDict[@"user_fees"] base64DecodedString] floatValue];
        accountInfo.accountIsSetPayPassword = [[resultDict[@"is_payment_pwd"] base64DecodedString] floatValue];
        
        *accountInfoModel = accountInfo;
    }
    return code;
}

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
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue], @"user_id",
                                     [@(page) stringValue], @"page",
                                     [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getMyAccountListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetMyAccountListResulyToArrData:&arrData jsonString:responseString];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetMyAccountListResulyToArrData:(NSMutableArray **)arrData jsonString:(NSString *)jsonStr{
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *dict in arrResult) {
                AccountInfo *accountInfo = [[AccountInfo alloc] init];
                accountInfo.accountID = [[dict[@"user_account_id"] base64DecodedString] integerValue];
                accountInfo.accountIsDefault = [[dict[@"is_default"] base64DecodedString] integerValue];
                accountInfo.accountNo = [dict[@"user_account"] base64DecodedString];
                accountInfo.accountCardHolder = [dict[@"card_master"] base64DecodedString];
                accountInfo.accountType = [[dict[@"account_type"] base64DecodedString] floatValue];
                accountInfo.accountBankName = [dict[@"bank_name"] base64DecodedString];
                
                [*arrData addObject:accountInfo];
            }
        }
    }
    return code;
}

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
                                   failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(page) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getBankListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetBankListResulyToArrData:&arrData jsonString:responseString];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseGetBankListResulyToArrData:(NSMutableArray **)arrData jsonString:(NSString *)jsonStr{
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *dict in arrResult) {
                BankInfo *bankInfo = [[BankInfo alloc] init];
                bankInfo.bankID = [[dict[@"bank_id"] base64DecodedString] integerValue];
                bankInfo.bankName = [dict[@"bank_name"] base64DecodedString];
                
                [*arrData addObject:bankInfo];
            }
        }
    }
    return code;
}

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
                                        failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      accountNo, @"user_account",
                                      [@(accountType) stringValue], @"account_type",
                                      trueName, @"card_master",
                                      verifyCode, @"verify_code",
                                      [@(isDefault) stringValue], @"is_default",
                                      bankName, @"bank_name", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addUserAccountUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseAddUserAccountWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseAddUserAccountWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}

/**
 设置默认账户
 
 @param accountID       账户ID
 @param successed       成功
 @param failed          失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)setDefaultAccountWithUserAccountID:(NSInteger)accountID
                                               successed:(SetDefaultAccountSuccessed)successed
                                                  failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(accountID) stringValue], @"user_account_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile setDefaultAccountUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseAddUserAccountWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

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
                                              failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(accountID) stringValue], @"user_account_id",
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteUserAccountUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseAddUserAccountWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

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
                                              failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      verifyCode, @"verify_code",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:withdrawalsPwd]], @"withdrawals_pwd", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile updateWithdrawalsPasswordUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseAddUserAccountWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}


/**
 申请提现获取用户余额和默认账户
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserFeesAndDefaultWithUserID:(NSInteger)userID
                                            successed:(GetUserFeesAndDefaultSuccessed)successed
                                               failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getUserFeesAndDefaultUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        WithdrawalViewModel *withdrawalViewModel;
        NSInteger code = [self parseGetWithdrawalInfoResultToWithdrawalViewModel:&withdrawalViewModel jsonString:responseString];
        successed(code, withdrawalViewModel);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseGetWithdrawalInfoResultToWithdrawalViewModel:(WithdrawalViewModel **)withdrawalViewModel jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        WithdrawalViewModel *viewModel=[[WithdrawalViewModel alloc] init];
        viewModel.userFees = [[resultDict[@"user_fees"] base64DecodedString] floatValue];
        viewModel.userRate = [[resultDict[@"rate"] base64DecodedString] floatValue];
        viewModel.isSetPayPassword = [[resultDict[@"is_set_pay_pwd"] base64DecodedString] floatValue];
        viewModel.userPhone = [resultDict[@"login_name"] base64DecodedString];
        
        NSDictionary *accountDict = resultDict[@"account_info"];
        
        AccountInfo *accountInfo = [[AccountInfo alloc] init];
        accountInfo.accountID = [[accountDict[@"user_account_id"] base64DecodedString] integerValue];
        accountInfo.accountNo = [accountDict[@"user_account"] base64DecodedString];
        accountInfo.accountType = [[accountDict[@"account_type"] base64DecodedString] integerValue];
        accountInfo.accountCardHolder = [accountDict[@"card_master"] base64DecodedString];
        accountInfo.accountBankName = [accountDict[@"bank_name"] base64DecodedString];
        viewModel.accountInfo = accountInfo;
        
        *withdrawalViewModel = viewModel;
    }
    return code;
}

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
                                               failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [@(userID) stringValue], @"user_id",
                                   [@(applyAmount) stringValue], @"withdrawals_amount",
                                   [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:applyPwd]], @"apply_take_pwd",
                                   [@(accountID) stringValue], @"account_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addWithdrawalsApplyUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseAddUserAccountWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

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
                                              failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue], @"user_id",
                                     [@(page) stringValue], @"page",
                                     [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getAccountChangeListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetAccountChangeListResultToArrData:&arrData jsonString:responseString];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseGetAccountChangeListResultToArrData:(NSMutableArray **)arrData jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *dict in arrResult) {
                AccountChangeInfo *accountChangeInfo = [[AccountChangeInfo alloc] init];
                accountChangeInfo.accountChangeID = [[dict[@"log_id"] base64DecodedString] integerValue];
                accountChangeInfo.accountChangeType = [[dict[@"is_income_str"] base64DecodedString] integerValue];
                accountChangeInfo.accountChangeTitle = [dict[@"log_title"] base64DecodedString];
                accountChangeInfo.accountChangeDesc = [dict[@"log_desc"] base64DecodedString];
                accountChangeInfo.accountChangeTime = [dict[@"add_time"] base64DecodedString];
                accountChangeInfo.accountChangeFees = [[dict[@"account_balance"] base64DecodedString] floatValue];
                accountChangeInfo.accountChangeAmount = [[dict[@"account_change_fees"] base64DecodedString] floatValue];
                
                [*arrData addObject:accountChangeInfo];
            }
        }
    }
    return code;
}

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
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [@(userID) stringValue], @"user_id",
                                    [@(payType) stringValue], @"pay_type",
                                    [GlobalFile stringFromeFloat:rechargeAmount decimalPlacesCount:2], @"recharge_amount", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addRechargeUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *alipayResult;
        PayReq *payReq;
        NSInteger code = [self parseAddRechargeResultToAlipayResult:&alipayResult payReq:&payReq payType:payType jsonStr:responseString];
        successed(code, alipayResult, payReq);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseAddRechargeResultToAlipayResult:(NSString **)alipayResult payReq:(PayReq **)request payType:(NSInteger)payType jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        if (payType == 1) {
            //支付宝
            *alipayResult = [jsonDict[@"result"][@"alipay_result"] base64DecodedString];
        } else if (payType == 2) {
            //微信
            NSDictionary *resultDict = jsonDict[@"result"];
            PayReq *payReq = [[PayReq alloc] init];
            payReq.openID = [resultDict[@"appid"] base64DecodedString];
            payReq.partnerId = [resultDict[@"partnerid"] base64DecodedString];
            payReq.prepayId = [resultDict[@"prepayid"] base64DecodedString];
            payReq.package = [resultDict[@"packageValue"] base64DecodedString];
            payReq.nonceStr = [resultDict[@"noncestr"] base64DecodedString];;
            payReq.timeStamp = [[resultDict[@"timestamp"] base64DecodedString] intValue];
            payReq.sign = [resultDict[@"sign"] base64DecodedString];
            *request = payReq;
        }
    }
    return code;
}

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
                                               failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(page) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getRechargeRecordListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetRechargeRecordListResultToArrData:&arrData jsonString:responseString];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseGetRechargeRecordListResultToArrData:(NSMutableArray **)arrData jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *dict in arrResult) {
                AccountChangeInfo *accountChangeInfo = [[AccountChangeInfo alloc] init];
                accountChangeInfo.accountChangeID = [[dict[@"record_id"] base64DecodedString] integerValue];
                accountChangeInfo.accountChangeType = [[dict[@"recharge_type"] base64DecodedString] integerValue];
                accountChangeInfo.accountChangeTitle = [dict[@"recharge_type_str"] base64DecodedString];
                accountChangeInfo.accountChangeTime = [dict[@"pay_time"] base64DecodedString];
                accountChangeInfo.accountChangeAmount = [[dict[@"recharge_amount"] base64DecodedString] floatValue];
                
                [*arrData addObject:accountChangeInfo];
            }
        }
    }
    return code;
}

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
                                              failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(page) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size",
                                      [@(mark) stringValue], @"mark",
                                      [@(redType) stringValue], @"red_type", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile geUserRedRecordListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseGetUserRedRecordListReslutToUserInfo:&userInfo jsonString:responseString];
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetUserRedRecordListReslutToUserInfo:(UserInfo **)userModel jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        NSDictionary *userDict = resultDict[@"user_info"];
        UserInfo *userInfo = [[UserInfo alloc]init];
        userInfo.userNickName = [userDict[@"nick_name"] base64DecodedString];
        userInfo.userHeadImg = [userDict[@"head_image"] base64DecodedString];
        userInfo.userRedNum = [[userDict[@"red_number_total"] base64DecodedString] integerValue];
        userInfo.userFees = [[userDict[@"red_amount_total"] base64DecodedString] floatValue];
        
        NSArray *arrRedRecord = resultDict[@"red_record_list"];
        if (arrRedRecord.count) {
            for (NSDictionary *dict in arrRedRecord) {
                AccountChangeInfo *accountChangeInfo = [[AccountChangeInfo alloc] init];
                accountChangeInfo.accountChangeID = [[dict[@"red_record_id"] base64DecodedString] integerValue];
                accountChangeInfo.accountChangeTitle = [dict[@"red_type_str"] base64DecodedString];
                accountChangeInfo.accountChangeTime = [dict[@"add_time"] base64DecodedString];
                accountChangeInfo.accountChangeAmount = [[dict[@"red_amount"] base64DecodedString] floatValue];
                
                [userInfo.userArrRedRecord addObject:accountChangeInfo];
            }
        }
        
        *userModel = userInfo;
    }
    return code;
}

@end
