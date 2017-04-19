//
//  AttentionDemandViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

//是否可以编辑的block
typedef void(^AttentionDemandCanEditBlock)(BOOL canEdit);
//是否全部删除的block
typedef void(^AttentionDemandIsAllDeleteBlock)(BOOL isAllDelete);

@interface AttentionDemandViewController : HHSoftBaseViewController
-(instancetype)initWithAttentionDemandCanEditBlock:(AttentionDemandCanEditBlock)canEditBlock AttentionDemandIsAllDeleteBlock:(AttentionDemandIsAllDeleteBlock)isAllDeleteBlock;
-(void)deleteSelectCollect;
-(void)setTableEditing:(BOOL)isEdit;
-(void)reloadAttentionData;
@end
