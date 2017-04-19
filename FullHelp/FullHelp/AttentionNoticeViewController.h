//
//  AttentionNoticeViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

//是否可以编辑的block
typedef void(^AttentionNoticeCanEditBlock)(BOOL canEdit);
//是否全部删除的block
typedef void(^AttentionNoticeIsAllDeleteBlock)(BOOL isAllDelete);

@interface AttentionNoticeViewController : HHSoftBaseViewController

-(instancetype)initWithAttentionNoticeCanEditBlock:(AttentionNoticeCanEditBlock)canEditBlock AttentionNoticeIsAllDeleteBlock:(AttentionNoticeIsAllDeleteBlock)isAllDeleteBlock;
-(void)deleteSelectCollect;
-(void)setTableEditing:(BOOL)isEdit;
-(void)reloadAttentionData;
@end
