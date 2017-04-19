//
//  SupplierRewardViewCell.h
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RewardInfo;

typedef void(^RewardSupplierRewardBlock)();
typedef void(^RefusedSupplierRewardBlock)();
typedef void(^DeleteSupplierRewardBlock)();
typedef void(^ReasonSupplierRewardBlock)();

@interface SupplierRewardViewCell : UITableViewCell
@property (nonatomic,strong) RewardInfo *rewardInfo;
@property (nonatomic,copy) RewardSupplierRewardBlock rewardSupplierRewardBlock;
@property (nonatomic,copy) RefusedSupplierRewardBlock refusedSupplierRewardBlock;
@property (nonatomic,copy) DeleteSupplierRewardBlock deleteSupplierRewardBlock;
@property (nonatomic,copy) ReasonSupplierRewardBlock reasonSupplierRewardBlock;


@end
