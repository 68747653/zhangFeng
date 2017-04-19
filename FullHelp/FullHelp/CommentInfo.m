//
//  CommentInfo.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "CommentInfo.h"
#import "UserInfo.h"

@implementation CommentInfo
-(instancetype)init{
    if(self = [super init]){
        _userInfo = [[UserInfo alloc] init];
        _arrCommentGallery = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
