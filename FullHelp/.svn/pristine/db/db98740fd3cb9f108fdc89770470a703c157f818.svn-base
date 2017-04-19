//
//  MenuInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo

- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName {
    if (self = [super init]) {
        self.menuID = menuID;
        self.menuName = menuName;
    }
    return self;
}

- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon {
    if (self = [super init]) {
        self.menuID = menuID;
        self.menuName = menuName;
        self.menuIcon = menuIcon;
    }
    return self;
}
-(instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon menuDetail:(NSString *)menuDetail menuData:(NSMutableArray *)menuData {
    if (self = [super init]) {
        _menuID = menuID;
        _menuName = menuName;
        _menuIcon = menuIcon;
        _menuDetail = menuDetail;
        _menuData = menuData;
    }
    return self;
}
- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuDetail:(NSString *)menuDetail menuIsSelect:(BOOL)menuIsSelect{
    if (self = [super init]) {
        _menuID = menuID;
        _menuName = menuName;
        _menuDetail = menuDetail;
        _menuIsSelect = menuIsSelect;
    }
    return self;
}
@end
