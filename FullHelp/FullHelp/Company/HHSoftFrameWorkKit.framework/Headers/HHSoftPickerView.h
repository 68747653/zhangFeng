//
//  HHSoftPickerView.h
//  FrameWotkTest
//
//  Created by dgl on 15-3-13.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectProvinceBlock)(NSInteger provinceID,NSString *provinceName);
typedef void(^SelectCityBlock)(NSInteger cityID,NSString *cityName);
typedef void(^SelectCountiesBlock)(NSInteger countiesID,NSString *countiesName);


@interface HHSoftPickerView : UIPickerView
@property (nonatomic,strong) NSArray *arrProvince;//需要传入的省列表
@property (nonatomic,strong) NSArray *arrCity;//需要传入的市列表
@property (nonatomic,strong) NSArray *arrCounties;//需要传入的县/区列表
@property (nonatomic,copy) NSString *keyName;//地区的ID的属性名称
@property (nonatomic,copy) NSString *valueName;//地区的名称的属性名称
@property (nonatomic,assign) NSInteger selectProvinceID;//选中的省ID
@property (nonatomic,assign) NSInteger selectCityID;//选中的国家ID
@property (nonatomic,assign) NSInteger selectCountiesID;//选中的县/区ID

/**
 *  默认选中第一个的初始化方法
 *
 *  @param frame               位置
 *  @param arrProvince         省列表
 *  @param arrCity             市列表
 *  @param arrCounties         县/区列表
 *  @param keyName             地区的ID的属性名称（一定是字符串）
 *  @param valueName           地区的名称的属性名称
 *  @param selectProvinceBlock 选中省后的操作
 *  @param selectCityBlock     选中市后的操作
 *  @param selectCountiesBlock 选中县/区后的操作
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame withProvince:(NSArray *)arrProvince andCity:(NSArray *)arrCity andCounties:(NSArray *)arrCounties andKeyName:(NSString *)keyName andValueName:(NSString *)valueName andSelectProvinceBlock:(SelectProvinceBlock)selectProvinceBlock andSelectCountryBlock:(SelectCityBlock)selectCityBlock andSelectCountiesBlock:(SelectCountiesBlock)selectCountiesBlock;

/**
 *  选中具体某一个实例的初始化方法
 *
 *  @param frame               位置
 *  @param arrProvince         省列表
 *  @param arrCity             市列表
 *  @param arrCounties         县/区列表
 *  @param keyName             地区的ID的属性名称（一定是字符串）
 *  @param valueName           地区的名称的属性名称
 *  @param selectProvinceID    要选中的省ID
 *  @param selectCityID        要选中的市ID
 *  @param selectCounitesID    要选中的县/区ID
 *  @param selectProvinceBlock 选中省后的操作
 *  @param selectCityBlock     选中市后的操作
 *  @param selectCountiesBlock 选中县/区后的操作
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame withProvince:(NSArray *)arrProvince andCity:(NSArray *)arrCity andCounties:(NSArray *)arrCounties andKeyName:(NSString *)keyName andValueName:(NSString *)valueName andSelectProvinceID:(NSInteger)selectProvinceID andSelectCityID:(NSInteger)selectCityID andCountiesID:(NSInteger)selectCounitesID andSelectProvinceBlock:(SelectProvinceBlock)selectProvinceBlock andSelectCountryBlock:(SelectCityBlock)selectCityBlock andSelectCountiesBlock:(SelectCountiesBlock)selectCountiesBlock;


@end
