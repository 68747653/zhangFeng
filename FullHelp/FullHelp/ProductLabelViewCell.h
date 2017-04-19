//
//  ProductLabelViewCell.h
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductLabelViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ArrProductLabel:(NSMutableArray *)arrProductLabel CellHeight:(CGFloat)cellHeight;
@property (nonatomic,strong) NSMutableArray *arrProductLabel;
@end
