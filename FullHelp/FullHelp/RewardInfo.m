//
//  RewardInfo.m
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RewardInfo.h"
#import "UserInfo.h"

@implementation RewardInfo
-(instancetype)init{
    if(self = [super init]){
        _userInfo = [[UserInfo alloc] init];
    }
    return self;
}
@end
