//
//  UserInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserInfo.h"
#import <HHSoftFrameWorkKit/HHSoftEncrypt.h>
#import "AddressInfo.h"

@interface UserInfo () <NSCoding>

@end

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_userType forKey:@"user_userType"];
    [aCoder encodeObject:[HHSoftEncrypt EncryptString:[@(_userID) stringValue]] forKey:@"user_userID"];
    [aCoder encodeObject:[HHSoftEncrypt EncryptString:_userLoginName] forKey:@"user_userLoginName"];
    [aCoder encodeInteger:_userRedNum forKey:@"user_userRedNum"];
    [aCoder encodeObject:_userNickName forKey:@"user_userNickName"];
    [aCoder encodeObject:_userRealName forKey:@"user_userRealName"];
    [aCoder encodeObject:_userHeadImg forKey:@"user_userHeadImg"];
    [aCoder encodeInteger:_userProvinceID forKey:@"user_userProvinceID"];
    [aCoder encodeObject:_userProvinceName forKey:@"user_userProvinceName"];
    [aCoder encodeInteger:_userCityID forKey:@"user_userCityID"];
    [aCoder encodeObject:_userCityName forKey:@"user_userCityName"];
    [aCoder encodeInteger:_userDistrictID forKey:@"user_userDistrictID"];
    [aCoder encodeInteger:_userIndustryID forKey:@"user_userIndustryID"];
    [aCoder encodeObject:_userIndustryName forKey:@"user_userIndustryName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _userType = [aDecoder decodeIntegerForKey:@"user_userType"];
        _userID = [[HHSoftEncrypt DecryptString:[aDecoder decodeObjectForKey:@"user_userID"]] integerValue];
        _userLoginName = [HHSoftEncrypt DecryptString:[aDecoder decodeObjectForKey:@"user_userLoginName"]];
        _userRedNum = [aDecoder decodeIntegerForKey:@"user_userRedNum"];
        _userNickName = [aDecoder decodeObjectForKey:@"user_userNickName"];
        _userRealName = [aDecoder decodeObjectForKey:@"user_userRealName"];
        _userHeadImg = [aDecoder decodeObjectForKey:@"user_userHeadImg"];
        _userProvinceID = [aDecoder decodeIntegerForKey:@"user_userProvinceID"];
        _userProvinceName = [aDecoder decodeObjectForKey:@"user_userProvinceName"];
        _userCityID = [aDecoder decodeIntegerForKey:@"user_userCityID"];
        _userCityName = [aDecoder decodeObjectForKey:@"user_userCityName"];
        _userDistrictID = [aDecoder decodeIntegerForKey:@"user_userDistrictID"];
        _userIndustryID = [aDecoder decodeIntegerForKey:@"user_userIndustryID"];
        _userIndustryName = [aDecoder decodeObjectForKey:@"user_userIndustryName"];
    }
    return self;
}

- (AddressInfo *)userMerchantAddressInfo {
    if (!_userMerchantAddressInfo) {
        _userMerchantAddressInfo = [[AddressInfo alloc] init];
    }
    return _userMerchantAddressInfo;
}

- (NSMutableArray *)userArrRedRecord {
    if (!_userArrRedRecord) {
        _userArrRedRecord = [NSMutableArray arrayWithCapacity:0];
    }
    return _userArrRedRecord;
}

@end
