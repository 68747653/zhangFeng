//
//  RedTableCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountChangeInfo;

@interface RedTableCell : UITableViewCell

@property (nonatomic, strong) AccountChangeInfo *accountChangeInfo;

+ (CGFloat)getCellHeightWith:(AccountChangeInfo *)accountChangeInfo;

@end
