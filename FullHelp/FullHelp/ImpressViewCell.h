//
//  ImpressViewCell.h
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertInfo;

typedef void(^ImpressSelectBlock)(NSInteger index);

@interface ImpressViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AdvertInfo:(AdvertInfo *)advertInfo CellHeight:(CGFloat)cellHeight;
@property (nonatomic,copy) ImpressSelectBlock impressSelectBlock;

@end
