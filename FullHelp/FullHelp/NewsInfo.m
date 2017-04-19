//
//  NewsInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "NewsInfo.h"
#import "ImageInfo.h"

@implementation NewsInfo

- (ImageInfo *)newsImageInfo {
    if (!_newsImageInfo) {
        _newsImageInfo = [[ImageInfo alloc] init];
    }
    return _newsImageInfo;
}

- (NSMutableArray *)newsArrImageInfo {
    if (!_newsArrImageInfo) {
        _newsArrImageInfo = [NSMutableArray arrayWithCapacity:0];
    }
    return _newsArrImageInfo;
}

@end
