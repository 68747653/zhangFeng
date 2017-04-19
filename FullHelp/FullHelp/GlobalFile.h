//
//  GlobalFile.h
//  YiYouCoach
//
//  Created by hhsoft on 17/1/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+HHSoft.h"

@interface GlobalFile : NSObject
#pragma mark -------------------------系统
#pragma mark -------------------------域名和分享地址
#pragma mark --- 分享 支付
/**
 微信AppID
 
 @return  NSString
 */
+(NSString *)wxAppID;
/**
 支付宝 Scheme·
 
 @return NSString
 */
+(NSString *)aliScheme;
/**
 *  域名地址
 */
+(NSString *)domainName;
/**
 分享地址
 
 @return NSString
 */
+ (NSString *)shareUrlName;
#pragma mark  --- 检查版本更新
/**
 *  检查版本更新
 *
 *  @return NSString
 */
+ (NSString *)uploadSoftVersion;
#pragma mark  --- 去appStore
/**
 *  去appStore更新版本
 *
 *  @return NSString
 */
+ (NSString *)uploadAppStorePath;

/*=============================网络开始=============================*/
#pragma mark ------------------------- 网络提示部分图片提示语

/**
 *  1比1默认图
 *
 */
+ (UIImage *)HHSoftDefaultImg1_1;
+ (UIImage *)HHSoftDefaultImg2_1;
/**
 *  5:4默认图
 *
 */
+(UIImage *)HHSoftDefaultImg5_4;
+(UIImage *)HHSoftDefaultImg4_5;
+(UIImage *)HHSoftDefaultImg5_8;
/**
 *  动画持续时间
 */
+(CGFloat)HHSoftLoadingAnimationDuration;
/**
 *  等待提示语
 */
+(NSString *)HHSoftLoadingWaitMessage;
/**
 *  没有数据提示语
 */
+(NSString *)HHSoftLoadNoDataMessage;
/**
 *  网络错误提示语
 */
+(NSString *)HHSoftLoadErrorMessage;

/**
 无法连接网络，加载失败
 
 @return nsstring
 */
+(NSString *)HHSoftUnableLinkNetWork;

/**
 网络异常，请稍候再试
 
 @return NSString
 */
+(NSString *)HHSoftLoadError;
/**
 *  加载动画的图片数组
 */
+(NSArray *)HHSoftLoadingAnimationImages;
/**
 *  没有数据的图片
 */
+(UIImage *)HHSoftLoadNoDataImage;
/**
 *  加载失败的图片
 */
+(UIImage *)HHSoftLoadErrorImage;

/**
 默认头像
 */
+(UIImage *)avatarImage;
+(NSString *)avatarDefault;
/*=============================网络部分=============================*/


/*=============================app内颜色=============================*/

/**
 *  主题颜色
 */
+(UIColor *)themeColor;
/**
 *  view背景颜色
 */
+(UIColor *)backgroundColor;
/**
 *  系统主题色图片
 *
 *  @return UIImage
 */
+ (UIImage *)themeColorImage;
/**
 *  自定义image颜色
 *
 *  @return UIImage
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 *  颜色
 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/*=============================app内颜色=============================*/


/*=============================其他=============================*/
/**
 *  获取商品子类列表
 *  价格保留小数
 *
 *  @param tfloat 传人的价格
 *  @param count  价格的小数点位数
 *
 *  @return NSString
 */
+ (NSString *)stringFromeFloat:(CGFloat)tfloat decimalPlacesCount:(NSInteger) count;
+ (NSString *) stringFromeDouble:(double)doubleValue decimalPlacesCount:(NSInteger) count;
/*=============================其他=============================*/
#pragma mark --- 登录注册
/**
 登录
 
 @return NSString
 */
+ (NSString *)userLoginUrl;

/**
 注册
 
 @return NSString
 */
+ (NSString *)userRegisterUrl;

/**
 忘记密码
 
 @return NSString
 */
+ (NSString *)userFindPasswordUrl;

/**
 获取地区列表
 
 @return NSString
 */
+ (NSString *)getRegionListUrl;

/**
 获取行业列表
 
 @return NSString
 */
+ (NSString *)getIndustryListUrl;

/**
 获取验证码
 
 @return NSString
 */
+ (NSString *)getVerifyCodeUrl;

/**
 获取使用帮助
 
 @return NSString
 */
+ (NSString *)getUserHelpUrl;

/**
 更新设备状态
 
 @return NSString
 */
+ (NSString *)updateDeviceStateUrl;

#pragma mark --- 我的
/**
 我的
 
 @return NSString
 */
+ (NSString *)getUserInfoMySelfUrl;

/**
 个人信息
 
 @return NSString
 */
+ (NSString *)getUserInfoUrl;

/**
 修改个人信息
 
 @return NSString
 */
+ (NSString *)editUserInfoUrl;

/**
 修改地址
 
 @return NSString
 */
+ (NSString *)editUserAddressUrl;

/**
 修改手机号
 
 @return NSString
 */
+ (NSString *)editLoginNameUrl;

/**
 修改密码
 
 @return NSString
 */
+ (NSString *)editOldPasswordUrl;

/**
 开通红包打赏
 
 @return NSString
 */
+ (NSString *)userApplyRedUrl;

/**
 关闭红包打赏
 
 @return NSString
 */
+ (NSString *)userCloseRedUrl;

/**
 联系我们
 
 @return NSString
 */
+ (NSString *)getRegionIndustryListUrl;

/**
 地区行业客服列表
 
 @return NSString
 */
+ (NSString *)getCustomListUrl;

/**
 获取通知栏推送状态
 
 @return NSString
 */
+ (NSString *)getIsPushUrl;

/**
 修改通知栏推送状态
 
 @return NSString
 */
+ (NSString *)ediIsPushUrl;

/**
 我的积分
 
 @return NSString
 */
+ (NSString *)userPointList;
/**
 获取积分规则列表
 
 @return NSString
 */
+ (NSString *)getPointRuleList;

/**
 积分申请提现
 
 @return NSString
 */
+ (NSString *)addPointWithdrawalsUrl;

/**
 签到
 
 @return NSString
 */
+ (NSString *)addSignInfoUrl;

#pragma mark --- 钱包
/**
 获取我的钱包信息
 
 @return NSString
 */
+ (NSString *)getUserFeesUrl;

/**
 账户列表
 
 @return NSString
 */
+ (NSString *)getMyAccountListUrl;

/**
 银行列表
 
 @return NSString
 */
+ (NSString *)getBankListUrl;

/**
 添加提现账户
 
 @return NSString
 */
+ (NSString *)addUserAccountUrl;

/**
 设置默认账户
 
 @return NSString
 */
+ (NSString *)setDefaultAccountUrl;

/**
 删除账户
 
 @return NSString
 */
+ (NSString *)deleteUserAccountUrl;

/**
 确认提现密码
 
 @return NSString
 */
+ (NSString *)withdrawalsConfirmUrl;

/**
 修改提现密码
 
 @return NSString
 */
+ (NSString *)updateWithdrawalsPasswordUrl;

/**
 申请提现获取用户余额和默认账户
 
 @return NSString
 */
+ (NSString *)getUserFeesAndDefaultUrl;

/**
 申请提现
 
 @return NSString
 */
+ (NSString *)addWithdrawalsApplyUrl;

/**
 资金流水
 
 @return NSString
 */
+ (NSString *)getAccountChangeListUrl;

/**
 充值
 
 @return NSString
 */
+ (NSString *)addRechargeUrl;

/**
 充值记录
 
 @return NSString
 */
+ (NSString *)getRechargeRecordListUrl;

/**
 收到/发出的红包
 
 @return NSString
 */
+ (NSString *)geUserRedRecordListUrl;

#pragma mark --- 我的广告
/**
 我的广告
 
 @return NSString
 */
+ (NSString *)getRedAdvertListUrl;

#pragma mark  --- 启动页

/**
 启动页
 
 @return NSString
 */
+ (NSString *)getStartPageImage;
#pragma mark --- 首页
/**
 首页数据
 */
+ (NSString *)getHomeInfo;

/**
 获取资讯列表
 
 @return NSString
 */
+ (NSString *)getNewsListUrl;

/**
 获取资讯详情
 
 @return NSString
 */
+ (NSString *)getNewsInfoUrl;

#pragma mark --- 红包广告
/**
 编辑需求公示公告信息
 */
+ (NSString *)editDemand;
/**
 发布需求公示公告信息
 */
+ (NSString *)publishDemand;
/**
 热门项目推荐
 */
+ (NSString *)getHotRedPacketAdvert;
/**
 限时抢购列表
 */
+ (NSString *)grabRedPacketList;
/**
 新活动列表
 */
+ (NSString *)newRedPacketList;

/**
 红包广告详情

 @return NSString
 */
+(NSString *)getRedAdvertInfo;
/**
 拆红包
 */
+ (NSString *)openRedPacket;
/**
 拆需求红包
 */
+ (NSString *)openNeedsRedPacket;
/**
 拆今日红包
 
 @return NSString
 */
+(NSString *)openTodayRedPacketInfo;
/**
 拆场景红包
 */
+(NSString *)openSceneRedPacketInfo;
    /**
     获取场景红包
     */
+(NSString *)getSceneRedPacketList;
/**
 专场红包列表
 */
+ (NSString *)getSpecialRedPacketList;
/**
 预报红包列表
 */
+ (NSString *)getPredictRedListUrl;
/**
 游戏红包列表
 */
+(NSString *)getGameList;
/**
 获取需求/公示公告列表
 */
+ (NSString *)getDemandList;
/**
 今日红包列表
 */
+ (NSString *)getTodayList;
/**
 拆游戏红包
 */
+(NSString *)openGameRedAdvertInfo;
/**
 验证口令
 */
+(NSString *)checkPassword;
/**
 获取需求和公示公告详情
 */
+ (NSString *)getDemandInfo;

/**
 供货商印象点评

 @return NSString
 */
+(NSString *)AddImpressCommentInfo;

/**
 评价列表

 @return NSString
 */
+(NSString *)getCommentList;

/**
 点赞和取消点赞

 @return NSString
 */
+(NSString *)addPraiseInfo;

/**
 拆专场红包

 @return NSString
 */
+(NSString *)openRedAdvertInfo;

/**
 申请红包打赏

 @return NSString
 */
+(NSString *)addApplyRedInfo;

/**
 添加评论

 @return NSString
 */
+(NSString *)addCommentInfo;

/**
 电话咨询

 @return NSString
 */
+(NSString *)addConsultRecordInfo;

/**
 领取电话红包

 @return NSString
 */
+(NSString *)openTelRedAdvertInfo;
#pragma mark ------------------- 我的关注
/**
 收藏和取消收藏
 
 @return NSString
 */
+ (NSString *)addCollectOrCancelCollectUrl;

/**
 我的关注广告列表
 
 @return NSString
 */
+(NSString *)getCollectAdvertList;

/**
 我的关注资讯列表

 @return NSString
 */
+(NSString *)getCollectNewsList;

/**
 我的关注需求公示公告列表

 @return NSString
 */
+(NSString *)getCollectDemandNoticeList;

/**
 我的关注批量删除

 @return NSString
 */
+(NSString *)deleteBatchCollectInfo;

/**
 咨询记录（商家/代货商）

 @return NSString
 */
+(NSString *)getConsultRecordList;

/**
 删除咨询记录

 @return NSString
 */
+(NSString *)deleteConsultRecordInfo;

/**
 我的发布列表

 @return NSString
 */
+(NSString *)getMyDemandNoticeList;

/**
 我的发布删除

 @return NSString
 */
+(NSString *)deleteDemandNoticeInfo;

/**
 意见反馈

 @return NSString
 */
+(NSString *)addFeedBack;

/**
 获取系统消息列表

 @return NSString
 */
+(NSString *)getSystemList;
/**
 *  单个删除系统消息
 *
 *  @return NSString
 */
+ (NSString *)deleteSinglesSystemUser;
/**
 *  清空系统消息
 *
 *  @return NSString
 */
+ (NSString *)emptySystemUserInfo;
/**
 获取系统消息详情
 
 @return NSString
 */
+ (NSString *)getSystemInfo;

/**
 我的打赏申请（商家/代理商）

 @return NSString
 */
+(NSString *)getApplyRedList;

/**
 删除申请打赏信息

 @return NSString
 */
+(NSString *)deleteApplyRedInfo;

/**
 修改申请打赏状态

 @return NSString
 */
+(NSString *)editApplyRedInfo;
@end
