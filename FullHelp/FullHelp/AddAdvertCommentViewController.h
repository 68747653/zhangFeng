//
//  AddAdvertCommentViewController.h
//  FullHelp
//
//  Created by hhsoft on 17/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef void(^AddCommentSucceedBlock)();

@interface AddAdvertCommentViewController : HHSoftBaseViewController
-(instancetype)initWithMerchantUserID:(NSInteger)merchantUserID AddCommentSucceedBlock:(AddCommentSucceedBlock)addCommentSucceedBlock;
@end
