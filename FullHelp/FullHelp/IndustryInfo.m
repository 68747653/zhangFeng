//
//  IndustryInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "IndustryInfo.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import "UserInfoEngine.h"
#import "UserInfo.h"
@interface IndustryInfo ()
@end

@implementation IndustryInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_industryID forKey:@"IndustryID"];
    [aCoder encodeObject:_industryName forKey:@"IndustryName"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
       _industryID = [aDecoder decodeIntegerForKey:@"IndustryID"];
       _industryName = [aDecoder decodeObjectForKey:@"IndustryName"];
    }
    return self;
}

+ (void)setIndustryInfo:(IndustryInfo *)industryInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:industryInfo];
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"user_industryInfo"];
}
+ (IndustryInfo *)getIndustryInfo {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    NSData *data = [defaults objectForKey:@"user_industryInfo"];
    IndustryInfo *industryInfo = (IndustryInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!industryInfo) {
        industryInfo = [[IndustryInfo alloc] init];
        industryInfo.industryID = [UserInfoEngine getUserInfo].userIndustryID;
        industryInfo.industryName = [UserInfoEngine getUserInfo].userIndustryName;
    }
    return industryInfo;
}
@end
