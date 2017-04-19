//
//  SoftVersionInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoftVersionInfo : NSObject

/**
 更新内容
 */
@property (nonatomic, copy) NSString *versionUpdateContent;

/**
 版本号
 */
@property (nonatomic, copy) NSString *versionNum;

@end
