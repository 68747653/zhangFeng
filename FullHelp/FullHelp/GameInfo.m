//
//  GameInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GameInfo.h"
#import "UserInfo.h"
@implementation GameInfo
- (instancetype) init {
    if (self = [super init]) {
        _userInfo = [[UserInfo alloc] init];
    }
    return self;
}
@end
