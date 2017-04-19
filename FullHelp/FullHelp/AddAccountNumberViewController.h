//
//  AddAccountNumberViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef void (^AddAccountNumberSuccessedBlock)();

@interface AddAccountNumberViewController : HHSoftBaseViewController

@property (nonatomic, copy)AddAccountNumberSuccessedBlock addAcountBlock;
@property (nonatomic, copy)AddAccountNumberSuccessedBlock addAccountNumberSuccessedBlock;

- (instancetype)initWithAddAccountNumberSuccessedBlock:(AddAccountNumberSuccessedBlock)addAccountNumberSuccessedBlock;

@end
