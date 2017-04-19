//
//  AdvertTableCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdvertInfo;

@interface AdvertTableCell : UITableViewCell

@property (nonatomic, strong) AdvertInfo *advertInfo;

+ (CGFloat)getCellHeightWith:(AdvertInfo *)advertInfo;

@end
