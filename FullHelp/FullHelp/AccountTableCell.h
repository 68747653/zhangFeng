//
//  AccountTableCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountInfo;

typedef void(^SetDefaultAccountBlock)();
typedef void(^DeleteAccountBlock)();

@interface AccountTableCell : UITableViewCell

@property (nonatomic,copy) SetDefaultAccountBlock setDefaultAccountBlock;
@property (nonatomic,copy) DeleteAccountBlock deleteAccountBlock;
@property (nonatomic,strong) AccountInfo *accountInfo;

+ (CGFloat)getCellHeightWith:(AccountInfo *)accountInfo;

@end
