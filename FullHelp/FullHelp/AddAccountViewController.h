//
//  AddAccountViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef void(^AddAccountSuccessedBlock)();

@interface AddAccountViewController : HHSoftBaseViewController

- (instancetype)initWithAddAccountSuccessedBlock:(AddAccountSuccessedBlock)addAccountSuccessedBlock;

@end
