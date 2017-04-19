//
//  AccountManageViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

@class AccountInfo;

typedef NS_ENUM(NSInteger,ViewType) {
    ViewTypeWithMyWallet    ,   //我的钱包
    ViewTypeWithWithdrawal  ,   //提现
};

typedef void(^SelectedAccountSucceedBlock)(AccountInfo *accountInfo);
typedef void(^DeleteAccountSucceedBlock)();

@interface AccountManageViewController : HHSoftBaseViewController

-(instancetype)initWithViewType:(ViewType)viewType accountInfo:(AccountInfo *)accountInfo selectedAccountSucceedBlock:(SelectedAccountSucceedBlock)selectedAccountSucceedBlock deleteAccountSucceedBlock:(DeleteAccountSucceedBlock)deleteAccountSucceedBlock;

@end
