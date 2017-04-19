//
//  DemandNoticeInfo.m
//  FullHelp
//
//  Created by hhsoft on 17/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "DemandNoticeInfo.h"
#import "AddressInfo.h"
#import "UserInfo.h"
@implementation DemandNoticeInfo
-(instancetype)init{
    if (self = [super init]) {
        _arrImg = [[NSMutableArray alloc] init];
        _arrShowImg = [[NSMutableArray alloc] init];
        _addressInfo = [[AddressInfo alloc] init];
        _userInfo = [[UserInfo alloc] init];
    }
    return self;
}
@end
