//
//  AttentionNewsViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

//是否可以编辑的block
typedef void(^AttentionNewsCanEditBlock)(BOOL canEdit);
//是否全部删除的block
typedef void(^AttentionNewsIsAllDeleteBlock)(BOOL isAllDelete);

@interface AttentionNewsViewController : HHSoftBaseViewController
-(instancetype)initWithAttentionNewsCanEditBlock:(AttentionNewsCanEditBlock)canEditBlock AttentionNewsIsAllDeleteBlock:(AttentionNewsIsAllDeleteBlock)isAllDeleteBlock;
-(void)deleteSelectCollect;
-(void)setTableEditing:(BOOL)isEdit;
-(void)reloadAttentionData;
@end
