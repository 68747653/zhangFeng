//
//  EditUserInfoViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef void (^EditUserInfoBlock)(NSString *userInfoStr);

@interface EditUserInfoViewController : HHSoftBaseViewController

- (instancetype)initWithUserInfoStr:(NSString *)userInfoStr editUserInfoBlock:(EditUserInfoBlock)editUserInfoBlock mark:(NSInteger)mark;

@end
