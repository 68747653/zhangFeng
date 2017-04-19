//
//  RedPacketAdvertCell.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CellType) {
    CellTypeHotAdvert , //热门推荐
    CellTypeGrabAdvert, //抢购活动
    CellTypeNew       , //最新活动
    CellTypeHome2_1   , //首页2比1类型
    CellTypeHome1_1   , //首页1比1类型
};

@class AdvertInfo;
@interface RedPacketAdvertCell : UITableViewCell
@property (nonatomic, strong) AdvertInfo *advertInfo;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType)cellType;
-(instancetype)initWithNewAdvertStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType)cellType;
-(instancetype)initWithHomeAdvertStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(CellType)cellType;
@end
