//
//  NewsTableCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsInfo;

@interface NewsTableCell : UITableViewCell

@property (nonatomic, strong) NewsInfo *newsInfo;

+ (CGFloat)getCellHeightWith:(NewsInfo *)newsInfo;

@end
