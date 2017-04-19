//
//  WithdrawalViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef void(^WithdrawalSuccessedBlock)();

@interface WithdrawalViewController : HHSoftBaseViewController

//viewType:0，钱包进入；1，设置提现密码进入
- (instancetype)initWithViewType:(NSInteger)viewType withdrawalSuccessedBlock:(WithdrawalSuccessedBlock)withdrawalSuccessedBlock;

@end
