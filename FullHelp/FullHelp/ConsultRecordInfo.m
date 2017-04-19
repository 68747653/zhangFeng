//
//  ConsultRecordInfo.m
//  FullHelp
//
//  Created by hhsoft on 17/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ConsultRecordInfo.h"
#import "UserInfo.h"
#import "AdvertInfo.h"

@implementation ConsultRecordInfo
-(instancetype)init{
    if(self = [super init]){
        _userInfo = [[UserInfo alloc] init];
        _advertInfo = [[AdvertInfo alloc] init];
    }
    return self;
}
@end
