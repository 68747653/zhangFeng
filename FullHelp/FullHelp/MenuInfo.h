//
//  MenuInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuInfo : NSObject

/**
 菜单ID
 */
@property (nonatomic, assign) NSInteger menuID;

/**
 名字
 */
@property (nonatomic, copy) NSString *menuName;

/**
 图片
 */
@property (nonatomic, copy) NSString *menuIcon;

/**
 简介
 */
@property (nonatomic, copy) NSString *menuDetail;

/**
 是否选中
 */
@property (nonatomic, assign) NSInteger menuIsSelect;
/**
 菜单数据
 */
@property (nonatomic, strong) NSMutableArray *menuData;

- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName;

- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuDetail:(NSString *)menuDetail menuIsSelect:(BOOL)menuIsSelect;

- (instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon;

-(instancetype)initWithMenuID:(NSInteger)menuID menuName:(NSString *)menuName menuIcon:(NSString *)menuIcon menuDetail:(NSString *)menuDetail menuData:(NSMutableArray *)menuData;

@end
