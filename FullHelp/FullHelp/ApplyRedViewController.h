//
//  ApplyRedViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef NS_ENUM(NSInteger, RedViewType) {
    OpenRedViewType,        //申通开通红包打赏
    SetRedViewType,         //设置红包打赏
};

typedef void (^UserApplyOpenRedBlock)();

@interface ApplyRedViewController : HHSoftBaseViewController

- (instancetype)initWithUserApplyOpenRedBlock:(UserApplyOpenRedBlock)userApplyOpenRedBlock viewType:(RedViewType)viewType;

@end
