//
//  AttentionAdvertViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

//是否可以编辑的block
typedef void(^AttentionAdvertCanEditBlock)(BOOL canEdit);
//是否全部删除的block
typedef void(^AttentionAdvertIsAllDeleteBlock)(BOOL isAllDelete);
@interface AttentionAdvertViewController : HHSoftBaseViewController

-(instancetype)initWithAttentionAdvertCanEditBlock:(AttentionAdvertCanEditBlock)canEditBlock AttentionAdvertIsAllDeleteBlock:(AttentionAdvertIsAllDeleteBlock)isAllDeleteBlock;
-(void)deleteSelectCollect;
-(void)setTableEditing:(BOOL)isEdit;
-(void)reloadAttentionData;
@end
