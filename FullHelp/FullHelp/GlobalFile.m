//
//  GlobalFile.m
//  YiYouCoach
//
//  Created by hhsoft on 17/1/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GlobalFile.h"

@implementation GlobalFile
#pragma mark -------------------------域名和分享地址


#pragma mark --- 分享 支付
/**
 微信AppID
 
 @return  NSString
 */
+(NSString *)wxAppID{
    return @"wx579e5264a5c84d69";
}
/**
 支付宝 Scheme·
 
 @return NSString
 */
+(NSString *)aliScheme{
    return @"fulltohelp";
}


+(NSString *)domainName {
#ifdef DEBUG
    return @"http://203.171.237.66:8041";
#else
    return @"http://203.171.237.66:8041";
#endif
    
}

/**
 分享地址

 @return NSString
 */
+ (NSString *)shareUrlName {
    return [NSString stringWithFormat:@"%@/shareaddress", [self domainName]];
}
#pragma mark  --- 检查版本更新
/**
 *  检查版本更新
 *
 *  @return NSString
 */
+ (NSString *)uploadSoftVersion {
    return @"http://itunes.apple.com/lookup?id1205804306";
}
#pragma mark  --- 去appStore
/**
 *  去appStore更新版本
 *
 *  @return NSString
 */
+ (NSString *)uploadAppStorePath {
    return @"https://itunes.apple.com/us/app/ding-li-xiang-zhu/id1205804306?l=zh&ls=1&mt=8";
}
/*=============================网络开始=============================*/
#pragma mark ------------------------- 网络提示部分图片提示语
+ (UIImage *)HHSoftDefaultImg1_1 {
    return [UIImage imageNamed:@"default_1_1.png"];
}
+ (UIImage *)HHSoftDefaultImg2_1 {
    return [UIImage imageNamed:@"default_2_1.png"];
}
+(UIImage *)HHSoftDefaultImg5_4 {
    return [UIImage imageNamed:@"default_5_4.png"];
}
+(UIImage *)HHSoftDefaultImg4_5 {
    return [UIImage imageNamed:@"default_4_5.png"];
}
+(UIImage *)HHSoftDefaultImg5_8{
    return [UIImage imageNamed:@"default_5_8.png"];
}
+(CGFloat)HHSoftLoadingAnimationDuration{
    return 0.5;
}
+(NSString *)HHSoftLoadingWaitMessage{
    return @"正在加载，请稍候...";
}
+(NSString *)HHSoftLoadNoDataMessage{
    return @"暂时没有可展示的数据哦";
}
+(NSString *)HHSoftLoadErrorMessage{
    return @"加载失败，请点击屏幕重试";
}

+(NSString *)HHSoftUnableLinkNetWork{
    return @"无法连接网络，请稍后再试";
}
+(NSString *)HHSoftLoadError{
    return @"网络异常，请稍后再试";
}
+(NSArray *)HHSoftLoadingAnimationImages {
    return [NSArray arrayWithObjects:
            [UIImage imageNamed:@"loading_01.png"],
            [UIImage imageNamed:@"loading_02.png"],
            [UIImage imageNamed:@"loading_03.png"],
            [UIImage imageNamed:@"loading_04.png"],
            [UIImage imageNamed:@"loading_05.png"],
            [UIImage imageNamed:@"loading_06.png"],
            [UIImage imageNamed:@"loading_07.png"],
            [UIImage imageNamed:@"loading_08.png"],
            [UIImage imageNamed:@"loading_09.png"],
            [UIImage imageNamed:@"loading_10.png"],
            [UIImage imageNamed:@"loading_11.png"],
            [UIImage imageNamed:@"loading_12.png"],
            [UIImage imageNamed:@"loading_13.png"],
            [UIImage imageNamed:@"loading_14.png"],
            [UIImage imageNamed:@"loading_15.png"],
            [UIImage imageNamed:@"loading_16.png"],nil];
}
+(UIImage *)HHSoftLoadNoDataImage {
    return [UIImage imageNamed:@"loading_error.png"];
}
+(UIImage *)HHSoftLoadErrorImage {
    return [UIImage imageNamed:@"loading_error.png"];
}
/**
 默认头像
 */
+(UIImage *)avatarImage {
    return [UIImage imageNamed:@"avatar_default.png"];
}
+(NSString *)avatarDefault {
    return @"avatar_default.png";
}
/*=============================app内颜色=============================*/
+(UIColor *)themeColor{
    return [GlobalFile colorWithRed:255 green:125 blue:51 alpha:1];
}
+(UIColor *)backgroundColor{
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
}
+ (UIImage *)themeColorImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, [GlobalFile themeColor].CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}
+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 10, 10);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
    
}
+ (UIColor *) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
    return color;
}
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); //得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}
/*=============================app内颜色=============================*/

/*=============================其他=============================*/
+ (NSString *) stringFromeFloat:(CGFloat)tfloat decimalPlacesCount:(NSInteger) count {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *positiveFormat = [NSString stringWithFormat:@"%@",@"#####0."];
    for (NSInteger i = 0; i<count; i++) {
        positiveFormat = [positiveFormat stringByAppendingString:@"0"];
    }
    [numberFormatter setPositiveFormat:positiveFormat];
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:tfloat]];
}
/**
 *  价格保留小数
 *
 *  @param doubleValue 传人的价格
 *  @param count  价格的小数点位数
 *
 */
+ (NSString *) stringFromeDouble:(double)doubleValue decimalPlacesCount:(NSInteger) count {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    NSString *positiveFormat = [NSString stringWithFormat:@"%@",@"#####0."];
    for (NSInteger i = 0; i<count; i++) {
        positiveFormat = [positiveFormat stringByAppendingString:@"0"];
    }
    [numberFormatter setPositiveFormat:positiveFormat];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]];
}
/*=============================其他=============================*/

#pragma mark --- 登录注册
/**
 登录

 @return NSString
 */
+ (NSString *)userLoginUrl {
    return [NSString stringWithFormat:@"%@/login", [self domainName]];
}

/**
 注册
 
 @return NSString
 */
+ (NSString *)userRegisterUrl {
    return [NSString stringWithFormat:@"%@/regist", [self domainName]];
}

/**
 忘记密码
 
 @return NSString
 */
+ (NSString *)userFindPasswordUrl {
    return [NSString stringWithFormat:@"%@/updatepwd", [self domainName]];
}

/**
 获取地区列表
 
 @return NSString
 */
+ (NSString *)getRegionListUrl {
    return [NSString stringWithFormat:@"%@/regionlist", [self domainName]];
}

/**
 获取行业列表
 
 @return NSString
 */
+ (NSString *)getIndustryListUrl {
    return [NSString stringWithFormat:@"%@/industrylist", [self domainName]];
}

/**
 获取验证码
 
 @return NSString
 */
+ (NSString *)getVerifyCodeUrl {
    return [NSString stringWithFormat:@"%@/getverifycode", [self domainName]];
}

/**
 获取使用帮助
 
 @return NSString
 */
+ (NSString *)getUserHelpUrl {
    return [NSString stringWithFormat:@"%@/userhelpdetail", [self domainName]];
}

/**
 更新设备状态
 
 @return NSString
 */
+ (NSString *)updateDeviceStateUrl {
    return [NSString stringWithFormat:@"%@/updatedevicestate", [self domainName]];
}

#pragma mark --- 我的
/**
 我的
 
 @return NSString
 */
+ (NSString *)getUserInfoMySelfUrl {
    return [NSString stringWithFormat:@"%@/userinfomyself", [self domainName]];
}

/**
 个人信息
 
 @return NSString
 */
+ (NSString *)getUserInfoUrl {
    return [NSString stringWithFormat:@"%@/userinfo", [self domainName]];
}

/**
 修改个人信息
 
 @return NSString
 */
+ (NSString *)editUserInfoUrl {
    return [NSString stringWithFormat:@"%@/edituserinfo", [self domainName]];
}

/**
 修改地址
 
 @return NSString
 */
+ (NSString *)editUserAddressUrl {
    return [NSString stringWithFormat:@"%@/edituseraddress", [self domainName]];
}

/**
 修改手机号
 
 @return NSString
 */
+ (NSString *)editLoginNameUrl {
    return [NSString stringWithFormat:@"%@/editloginname", [self domainName]];
}

/**
 修改密码
 
 @return NSString
 */
+ (NSString *)editOldPasswordUrl {
    return [NSString stringWithFormat:@"%@/editoldpwd", [self domainName]];
}

/**
 开通红包打赏
 
 @return NSString
 */
+ (NSString *)userApplyRedUrl {
    return [NSString stringWithFormat:@"%@/userapplyred", [self domainName]];
}

/**
 关闭红包打赏
 
 @return NSString
 */
+ (NSString *)userCloseRedUrl {
    return [NSString stringWithFormat:@"%@/userclosered", [self domainName]];
}

/**
 联系我们
 
 @return NSString
 */
+ (NSString *)getRegionIndustryListUrl {
    return [NSString stringWithFormat:@"%@/regionindustrylist", [self domainName]];
}

/**
 地区行业客服列表
 
 @return NSString
 */
+ (NSString *)getCustomListUrl {
    return [NSString stringWithFormat:@"%@/customlist", [self domainName]];
}

/**
 获取通知栏推送状态
 
 @return NSString
 */
+ (NSString *)getIsPushUrl {
    return [NSString stringWithFormat:@"%@/getispush", [self domainName]];
}

/**
 修改通知栏推送状态
 
 @return NSString
 */
+ (NSString *)ediIsPushUrl {
    return [NSString stringWithFormat:@"%@/editispush", [self domainName]];
}

/**
 我的积分
 
 @return NSString
 */
+ (NSString *)userPointList {
    return [NSString stringWithFormat:@"%@/pointchangerecord", [self domainName]];
}

/**
 获取积分规则列表
 
 @return NSString
 */
+ (NSString *)getPointRuleList {
    return [NSString stringWithFormat:@"%@/pointrulelist", [self domainName]];
}

/**
 积分申请提现
 
 @return NSString
 */
+ (NSString *)addPointWithdrawalsUrl {
    return [NSString stringWithFormat:@"%@/addpointwithdrawals", [self domainName]];
}

/**
 签到
 
 @return NSString
 */
+ (NSString *)addSignInfoUrl {
    return [NSString stringWithFormat:@"%@/addsigninfo", [self domainName]];
}

#pragma mark --- 钱包
/**
 获取我的钱包信息
 
 @return NSString
 */
+ (NSString *)getUserFeesUrl {
    return [NSString stringWithFormat:@"%@/getuserfees",[self domainName]];
}

/**
 账户列表
 
 @return NSString
 */
+ (NSString *)getMyAccountListUrl {
    return [NSString stringWithFormat:@"%@/myaccountlist", [self domainName]];
}

/**
 银行列表
 
 @return NSString
 */
+ (NSString *)getBankListUrl {
    return [NSString stringWithFormat:@"%@/banklist", [self domainName]];
}

/**
 添加提现账户
 
 @return NSString
 */
+ (NSString *)addUserAccountUrl {
    return [NSString stringWithFormat:@"%@/adduseraccount", [self domainName]];
}

/**
 设置默认账户
 
 @return NSString
 */
+ (NSString *)setDefaultAccountUrl {
    return [NSString stringWithFormat:@"%@/setdefaultaccount", [self domainName]];
}

/**
 删除账户
 
 @return NSString
 */
+ (NSString *)deleteUserAccountUrl {
    return [NSString stringWithFormat:@"%@/deluseraccount", [self domainName]];
}

/**
 确认提现密码
 
 @return NSString
 */
+ (NSString *)withdrawalsConfirmUrl {
    return [NSString stringWithFormat:@"%@/withdrawalsconfirm", [self domainName]];
}

/**
 修改提现密码
 
 @return NSString
 */
+ (NSString *)updateWithdrawalsPasswordUrl {
    return [NSString stringWithFormat:@"%@/updatewithdrawalspwd", [self domainName]];
}

/**
 申请提现获取用户余额和默认账户
 
 @return NSString
 */
+ (NSString *)getUserFeesAndDefaultUrl {
    return [NSString stringWithFormat:@"%@/userfeesanddefault",[self domainName]];
}

/**
 申请提现
 
 @return NSString
 */
+ (NSString *)addWithdrawalsApplyUrl {
    return [NSString stringWithFormat:@"%@/addwithdrawalsapply", [self domainName]];
}

/**
 资金流水
 
 @return NSString
 */
+ (NSString *)getAccountChangeListUrl {
    return [NSString stringWithFormat:@"%@/accountchangefees", [self domainName]];
}

/**
 充值
 
 @return NSString
 */
+ (NSString *)addRechargeUrl {
    return [NSString stringWithFormat:@"%@/addrecharge", [self domainName]];
}

/**
 充值记录
 
 @return NSString
 */
+ (NSString *)getRechargeRecordListUrl {
    return [NSString stringWithFormat:@"%@/rechargerecordlist", [self domainName]];
}

/**
 收到/发出的红包
 
 @return NSString
 */
+ (NSString *)geUserRedRecordListUrl {
    return [NSString stringWithFormat:@"%@/userredrecordlist", [self domainName]];
}

#pragma mark --- 我的广告
/**
 我的广告
 
 @return NSString
 */
+ (NSString *)getRedAdvertListUrl {
    return [NSString stringWithFormat:@"%@/redadvertlist", [self domainName]];
}

#pragma mark --- 启动页
/**
 启动页
 
 @return NSString
 */
+ (NSString *)getStartPageImage {
    return [NSString stringWithFormat:@"%@/startupimage", [self domainName]];
}
#pragma mark --- 首页
/**
 首页数据
 */
+ (NSString *)getHomeInfo {
    return [NSString stringWithFormat:@"%@/homeindex", [self domainName]];
}

/**
 获取资讯列表
 
 @return NSString
 */
+ (NSString *)getNewsListUrl {
    return [NSString stringWithFormat:@"%@/newslist", [self domainName]];
}

/**
 获取资讯详情
 
 @return NSString
 */
+ (NSString *)getNewsInfoUrl {
    return [NSString stringWithFormat:@"%@/newsinfo", [self domainName]];
}

#pragma mark --- 红包广告
/**
 编辑需求公示公告信息
 */
+ (NSString *)editDemand {
    return [NSString stringWithFormat:@"%@/editdemandnoticeinfo", [self domainName]];
}
/**
 发布需求公示公告信息
 */
+ (NSString *)publishDemand {
    return [NSString stringWithFormat:@"%@/adddemandnoticeinfo", [self domainName]];
}
/**
 热门项目推荐
 */
+ (NSString *)getHotRedPacketAdvert {
    return [NSString stringWithFormat:@"%@/redadvertinfohot", [self domainName]];
}
/**
 限时抢购列表
 */
+ (NSString *)grabRedPacketList {
    return [NSString stringWithFormat:@"%@/redadvertseckilllist", [self domainName]];
}
/**
新活动列表
 */
+ (NSString *)newRedPacketList {
    return [NSString stringWithFormat:@"%@/redadvertmoneylist", [self domainName]];
}
/**
 红包广告详情
 
 @return NSString
 */
+(NSString *)getRedAdvertInfo{
    return [NSString stringWithFormat:@"%@/redadvertinfo", [self domainName]];
}
/**
 拆红包
 */
+ (NSString *)openRedPacket {
    return [NSString stringWithFormat:@"%@/openloginredinfo", [self domainName]];
}
/**
 拆需求红包
 */
+ (NSString *)openNeedsRedPacket {
    return [NSString stringWithFormat:@"%@/openreddemandnoticeinfo", [self domainName]];
}
/**
 获取需求/公示公告列表
 */
+ (NSString *)getDemandList {
    return [NSString stringWithFormat:@"%@/demandnoticelist", [self domainName]];
}
/**
 今日红包列表
 */
+ (NSString *)getTodayList {
    return [NSString stringWithFormat:@"%@/todayredlist", [self domainName]];
}
/**
 专场红包列表
 */
+ (NSString *)getSpecialRedPacketList {
    return [NSString stringWithFormat:@"%@/redadvertspeciallist", [self domainName]];
}
/**
 预报红包列表
 */
+ (NSString *)getPredictRedListUrl {
    return [NSString stringWithFormat:@"%@/predictredlist", [self domainName]];
}
/**
 获取需求和公示公告详情
 */
+ (NSString *)getDemandInfo {
    return [NSString stringWithFormat:@"%@/demandnoticeinfo", [self domainName]];
}
/**
 供货商印象点评
 
 @return NSString
 */
+(NSString *)AddImpressCommentInfo{
    return [NSString stringWithFormat:@"%@/addImpresscommentinfo", [self domainName]];
}
/**
 评价列表
 
 @return NSString
 */
+(NSString *)getCommentList{
    return [NSString stringWithFormat:@"%@/commentlist", [self domainName]];
}
/**
 点赞和取消点赞
 
 @return NSString
 */
+(NSString *)addPraiseInfo{
    return [NSString stringWithFormat:@"%@/addpraiseinfo", [self domainName]];
}
/**
 拆专场红包
 
 @return NSString
 */
+(NSString *)openRedAdvertInfo{
    return [NSString stringWithFormat:@"%@/openredadvertinfo", [self domainName]];
}
/**
 拆游戏红包
 
 @return NSString
 */
+(NSString *)openGameRedAdvertInfo{
    return [NSString stringWithFormat:@"%@/opengameredinfo", [self domainName]];
}
/**
 拆今日红包
 
 @return NSString
 */
+(NSString *)openTodayRedPacketInfo{
    return [NSString stringWithFormat:@"%@/opentodayredinfo", [self domainName]];
}
/**
 拆场景红包
 */
+(NSString *)openSceneRedPacketInfo{
    return [NSString stringWithFormat:@"%@/openpasswordredInfo", [self domainName]];
}
    /**
     获取场景红包
     */
+(NSString *)getSceneRedPacketList{
    return [NSString stringWithFormat:@"%@/passwordredlist", [self domainName]];
}
/**
 游戏红包列表
 */
+(NSString *)getGameList {
    return [NSString stringWithFormat:@"%@/gameredlist", [self domainName]];
}

/**
 验证口令
 */
+(NSString *)checkPassword {
    return [NSString stringWithFormat:@"%@/authenticationpassword", [self domainName]];
}
/**
 申请红包打赏
 
 @return NSString
 */
+(NSString *)addApplyRedInfo{
    return [NSString stringWithFormat:@"%@/addapplyredinfo", [self domainName]];
}
/**
 添加评论
 
 @return NSString
 */
+(NSString *)addCommentInfo{
    return [NSString stringWithFormat:@"%@/addcommentinfo", [self domainName]];
}
/**
 电话咨询
 
 @return NSString
 */
+(NSString *)addConsultRecordInfo{
    return [NSString stringWithFormat:@"%@/addconsultrecordinfo", [self domainName]];
}
/**
 领取电话红包
 
 @return NSString
 */
+(NSString *)openTelRedAdvertInfo{
    return [NSString stringWithFormat:@"%@/opentelredadvertinfo", [self domainName]];
}
#pragma mark ------------------- 我的关注
/**
 收藏和取消收藏
 
 @return NSString
 */
+ (NSString *)addCollectOrCancelCollectUrl {
    return [NSString stringWithFormat:@"%@/collectdemandnoticeinfo", [self domainName]];
}
/**
 我的关注广告列表
 
 @return NSString
 */
+(NSString *)getCollectAdvertList{
    return [NSString stringWithFormat:@"%@/collectadvertlist", [self domainName]];
}
/**
 我的关注资讯列表
 
 @return NSString
 */
+(NSString *)getCollectNewsList{
    return [NSString stringWithFormat:@"%@/collectnewslist", [self domainName]];
}
/**
 我的关注需求公示公告列表
 
 @return NSString
 */
+(NSString *)getCollectDemandNoticeList{
    return [NSString stringWithFormat:@"%@/collectdemandnoticelist", [self domainName]];
}
/**
 我的关注批量删除
 
 @return NSString
 */
+(NSString *)deleteBatchCollectInfo{
    return [NSString stringWithFormat:@"%@/batchdelcollectinfo", [self domainName]];
}
/**
 咨询记录（商家/代货商）
 
 @return NSString
 */
+(NSString *)getConsultRecordList{
    return [NSString stringWithFormat:@"%@/consultrecordlist", [self domainName]];
}
/**
 删除咨询记录
 
 @return NSString
 */
+(NSString *)deleteConsultRecordInfo{
    return [NSString stringWithFormat:@"%@/delconsultrecordinfo", [self domainName]];
}
/**
 我的发布列表
 
 @return NSString
 */
+(NSString *)getMyDemandNoticeList{
    return [NSString stringWithFormat:@"%@/mydemandnoticelist", [self domainName]];
}/**
  我的发布删除
  
  @return NSString
  */
+(NSString *)deleteDemandNoticeInfo{
    return [NSString stringWithFormat:@"%@/deldemandnoticeinfo", [self domainName]];
}
/**
 意见反馈
 
 @return NSString
 */
+(NSString *)addFeedBack{
    return [NSString stringWithFormat:@"%@/addfeedback", [self domainName]];
}
/**
  获取系统消息列表
  
  @return NSString
  */
+(NSString *)getSystemList{
    return [NSString stringWithFormat:@"%@/systemlist", [self domainName]];
}
/**
 *  单个删除系统消息
 *
 *  @return NSString
 */
+ (NSString *)deleteSinglesSystemUser {
    return [NSString stringWithFormat:@"%@/delsinglesystemuser", [self domainName]];
}
/**
 *  清空系统消息
 *
 *  @return NSString
 */
+ (NSString *)emptySystemUserInfo {
    return [NSString stringWithFormat:@"%@/emptysystemuserinfo" ,[self domainName]];
}
/**
 获取系统消息详情
 
 @return NSString
 */
+ (NSString *)getSystemInfo {
    return [NSString stringWithFormat:@"%@/systeminfo", [self domainName]];
}
/**
 我的打赏申请（商家/代理商）
 
 @return NSString
 */
+(NSString *)getApplyRedList{
    return [NSString stringWithFormat:@"%@/applyredlist", [self domainName]];
}
/**
 删除申请打赏信息
 
 @return NSString
 */
+(NSString *)deleteApplyRedInfo{
    return [NSString stringWithFormat:@"%@/delapplyredinfo", [self domainName]];
}
/**
 修改申请打赏状态
 
 @return NSString
 */
+(NSString *)editApplyRedInfo{
    return [NSString stringWithFormat:@"%@/editapplyredinfo", [self domainName]];
}
@end
