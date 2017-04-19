//
//  CustomServicerTableCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomServicerInfo;

@interface CustomServicerTableCell : UITableViewCell

@property (nonatomic, strong) CustomServicerInfo *customServicerInfo;

+ (CGFloat)getCellHeightWith:(CustomServicerInfo *)customServicerInfo;

@end
