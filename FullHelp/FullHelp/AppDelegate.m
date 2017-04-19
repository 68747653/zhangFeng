//
//  AppDelegate.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AppDelegate.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationBar+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftSDWebImageDownloader.h>
#import <HHSoftFrameWorkKit/UIDevice+DeviceInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "MainTabBarController.h"
#import "UserInfoEngine.h"
#import "LoginViewController.h"
#import "GlobalFile.h"
//百度定位
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import "LocationInfo.h"
#import "HHSoftHeader.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import "HHSoftHeader.h"
#import "HomeNetWorkEngine.h"
#import "CheckSoftVersionNetWorkEngine.h"
#import "StartPageViewController.h"
#import "SoftVersionInfo.h"
#import "ImageInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserLoginNetWorkEngine.h"
#import "WKWebViewController.h"
#import "PayHelper.h"
#import "NewsInfoViewController.h"
#import "PictureNewsInfoViewController.h"
#import "VideoNewsInfoViewController.h"
#import "MerchantsRewardApplyViewController.h"
#import "SupplierRewardApplyViewController.h"
//分享
#import "HHSoftShareTool.h"
#import "WXApi.h"
#import "WeiboSDK.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "UncaughtExceptionNetEngine.h"
/**
 *判断当前设备
 **/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


@interface AppDelegate () <BMKLocationServiceDelegate>

@property (nonatomic,strong) BMKMapManager* mapManager;
@property (nonatomic,strong) BMKLocationService *locationService;

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:@"0" forKey:IsOpenAgin];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [GlobalFile backgroundColor];
    [self setBaiDuMapInfo];
    [WXApi registerApp:@"wxf9cc80629c29ac0f"];
    [WeiboSDK registerApp:@"3910860466"];
    NSString *fileName = @"homeav.jpg";
    NSString *filePath = [HHHomeImageCachePath stringByAppendingPathComponent:fileName];
    UIImage *startImg = [UIImage imageWithContentsOfFile:filePath];
    if (startImg) {
        //启动页
        StartPageViewController *startPageViewController = [[StartPageViewController alloc] init];
        self.window.rootViewController = startPageViewController;
    } else {
        self.window.rootViewController = [AppDelegate getRootViewController];
    }
    // 注册远程推送及处理
    [self registerRemoteNotification:^(NSDictionary *userInfo) {
        [self receviceRemoteNotificationWithUserInfo:userInfo application:application];
    } registRemoteNotificationSuccessedBlock:^{
        if ([UserInfoEngine isLogin]) {
            [[[UserLoginNetWorkEngine alloc] init] updateDeviceStateWithUserID:[UserInfoEngine getUserInfo].userID deviceType:1 deviceToken:[HHSoftAppDelegate deviceToken] successed:^(NSInteger code) {
                
            } failed:^(NSError *error) {
                
            }];
        }
    } registRemoteNotificationFailBolck:^{
        
    }];
    //获取启动页
    if (IS_IPHONE_4_OR_LESS) {
        [self getStartPageImageWithType:0];
    } else if (IS_IPHONE_5) {
        [self getStartPageImageWithType:1];
    } else if (IS_IPHONE_6){
        [self getStartPageImageWithType:2];
    } else if (IS_IPHONE_6P){
        [self getStartPageImageWithType:3];
    } else {
        [self getStartPageImageWithType:0];
    }
    self.window.rootViewController = [AppDelegate getRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}
+ (UIViewController *)getRootViewController {
    if ([UserInfoEngine isLogin]) {
        return [[MainTabBarController alloc] init];
    }
    // 包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//    
//    //导航栏标题文字属性
//    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
//    // 文字颜色
//    textAttributesDict[NSForegroundColorAttributeName] = [HHSoftAppInfo defaultDeepSystemColor];
//    // 文字大小
//    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
//    [nav.navigationBar setTitleTextAttributes:textAttributesDict];
//    [nav.navigationBar setBackgroundImage:[GlobalFile imageWithColor:[UIColor whiteColor] size:CGSizeMake([HHSoftAppInfo AppScreen].width, 64)] forBarMetrics:UIBarMetricsDefault];
//    [nav.navigationBar setTintColor:[HHSoftAppInfo defaultDeepSystemColor]];
//    [nav.navigationBar setBackButtonColor:[HHSoftAppInfo defaultDeepSystemColor]];
    return nav;
}

#pragma mark ---- 获取当前位置
- (void)getLocationManagerData {
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    _locationService.distanceFilter = 10;//10米更新
    [_locationService startUserLocationService];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    LocationInfo *locationInfo = [LocationInfo getLocationInfo];
    locationInfo.lat = userLocation.location.coordinate.latitude;
    locationInfo.lng = userLocation.location.coordinate.longitude;
    [LocationInfo setLocationInfo:locationInfo];
    [_locationService stopUserLocationService];
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    
}
#pragma mark ------ 配置百度地图
- (void)setBaiDuMapInfo {
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret =  [_mapManager start:BaiduMapKey  generalDelegate:nil];
    if (ret) {
        [self getLocationManagerData];
    }
}

#pragma mark --- 获取启动页
- (void)getStartPageImageWithType:(NSInteger)type {
    [[[HomeNetWorkEngine alloc] init] getStartPageImageWithType:type successed:^(NSInteger code, ImageInfo *imageInfo) {
        if (code == 100) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *deUrlStr = [userDefault objectForKey:@"StartImageUrl"];
            if (![deUrlStr isEqualToString:imageInfo.imageBig]) {
                [userDefault setValue:imageInfo.imageBig forKey:@"StartImageUrl"];
                [userDefault synchronize];
                NSURL *url = [NSURL URLWithString:imageInfo.imageBig];
                [[HHSoftSDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (finished) {
                        [self imagePathByWirteToCacheDiroctoryWithImage:image];
                    }
                }];
            }
        }
    } failed:^(NSError *error) {
    }];
}

- (NSString *)imagePathByWirteToCacheDiroctoryWithImage:(UIImage *)image {
    if (self) {
        NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        BOOL isDirImg = false;
        BOOL isExistImg = [[NSFileManager defaultManager] fileExistsAtPath:HHHomeImageCachePath isDirectory:&isExistImg];
        if (!(isExistImg&&isDirImg)) {
            [[NSFileManager defaultManager] createDirectoryAtPath:HHHomeImageCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *fileName = @"homeav.jpg";
        
        NSString  *filePath = [HHHomeImageCachePath stringByAppendingPathComponent:fileName];
        BOOL isExist = [fileMgr fileExistsAtPath:filePath];
        if (!isExist) {
            BOOL isSuccess = [imgData writeToFile:filePath atomically:YES];
            if (isSuccess) {
                return filePath;
            }
            return nil;
        } else {
            BOOL isSuccess = [imgData writeToFile:filePath atomically:YES];
            if (isSuccess) {
                return filePath;
            }
            return nil;
        }
    } else {
        return nil;
    }
}

#pragma  mark --- 检查版本更新接口
- (void)getCheckSoftVersionInfo {
    [[[CheckSoftVersionNetWorkEngine alloc] init] checkSoftVersionInfoSuccessed:^(NSInteger code, SoftVersionInfo *softVersionInfo) {
        if (code == 0) {
            NSString *appStoreVersion = softVersionInfo.versionNum;
            NSString *currentVersion = [HHSoftAppInfo AppVersion];
            if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本%@", softVersionInfo.versionNum] message:[NSString stringWithFormat:@"%@", [NSString stringByReplaceNullString:softVersionInfo.versionUpdateContent]] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //版本更新
                    [UIDevice openSafari:[GlobalFile uploadAppStorePath]];
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            }
        }
    } failed:^(NSError *responseError) {
    }];
}

#pragma mark -- 收到推送的处理
- (void)receviceRemoteNotificationWithUserInfo:(NSDictionary *)userInfo application:(UIApplication *)application{
    NSDictionary *messageDic=[[userInfo objectForKey:@"usercustome"] objectFromJSONString];
    //类型  0：系统 1：新闻  2:组图新闻  3：视频新闻 4：打赏申请推送
    NSInteger pushType = [[messageDic objectForKey:@"type"]integerValue];
    NSInteger messgeID = [[messageDic objectForKey:@"id"] integerValue];//消息ID
    NSInteger logID = [[messageDic objectForKey:@"logid"] integerValue];
    NSString *content = [messageDic objectForKey:@"content"];
    NSString *title = [messageDic objectForKey:@"title"];
    NSString *newsImage=[messageDic objectForKey:@"image"];//视频新闻用
    /*UITabBarController *tabController = nil;
    UIViewController *rootViewContoller = self.window.rootViewController;
    if ([NSStringFromClass([rootViewContoller class]) isEqualToString:@"TabBarController"]) {
        tabController = (UITabBarController *)self.window.rootViewController;
    }
    
    UIViewController *current=[(UINavigationController *)tabController.selectedViewController topViewController];
    if ([current.presentedViewController isKindOfClass:[UITabBarController class]]) {
        tabController = (UITabBarController *)current.presentedViewController;
    }*/
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    UIViewController *current=[(UINavigationController *)tabController.selectedViewController topViewController];
    if ([current.presentedViewController isKindOfClass:[UITabBarController class]]) {
        tabController = (UITabBarController *)current.presentedViewController;
    }
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {//app正在运行
        NSString *alert=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        UINavigationController *userCenterNav = tabController.viewControllers[tabController.selectedIndex];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alert preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"立即查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            switch (pushType) {
                case 0:{
                    WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithMessageID:messgeID WkWebType:WKWebTypeWithMessage MessageTitle:@"消息详情" successed:^(NSInteger messageID) {
                        
                    }];
                    wkWebViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:wkWebViewController animated:YES];
                }
                    break;
                case 1:{
                    //新闻
                    NewsInfoViewController *newsInfoViewController = [[NewsInfoViewController alloc] initWithUrl:nil newsID:logID infoID:messgeID];
                    newsInfoViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:newsInfoViewController animated:YES];
                }
                    break;
                case 2:{
                    //组图新闻
                    PictureNewsInfoViewController *pictureNewsInfoViewController = [[PictureNewsInfoViewController alloc] initWithNewsID:logID infoID:messgeID];
                    pictureNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:pictureNewsInfoViewController animated:YES];
                }
                    break;
                case 3:{
                    //视频新闻
                    VideoNewsInfoViewController *videoNewsInfoViewController = [[VideoNewsInfoViewController alloc] initWithNewsID:logID newsImage:newsImage infoID:messgeID];
                    videoNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:videoNewsInfoViewController animated:YES];
                }
                    break;
                case 4:{
                        //打赏申请推送
                        if ([UserInfoEngine getUserInfo].userType == 1) {
                            //商家打赏申请
                            MerchantsRewardApplyViewController *merchantsRewardApplyViewController = [[MerchantsRewardApplyViewController alloc] init];
                            merchantsRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                            [userCenterNav pushViewController:merchantsRewardApplyViewController animated:YES];
                        }else{
                            //供货商打赏申请
                            SupplierRewardApplyViewController *supplierRewardApplyViewController = [[SupplierRewardApplyViewController alloc] init];
                            supplierRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                            [userCenterNav pushViewController:supplierRewardApplyViewController animated:YES];
                        }
                    }
                    break;
                default:
                    break;
            }
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [tabController presentViewController:alertController animated:YES completion:nil];
        
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
        UINavigationController *userCenterNav = tabController.viewControllers[tabController.selectedIndex];
        switch (pushType) {
            case 0:{
                WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithMessageID:messgeID WkWebType:WKWebTypeWithMessage MessageTitle:@"消息详情" successed:^(NSInteger messageID) {
                    
                }];
                wkWebViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:wkWebViewController animated:YES];
            }
                break;
            case 1:{
                //新闻
                NewsInfoViewController *newsInfoViewController = [[NewsInfoViewController alloc] initWithUrl:nil newsID:logID infoID:messgeID];
                newsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:newsInfoViewController animated:YES];
            }
                break;
            case 2:{
                //组图新闻
                PictureNewsInfoViewController *pictureNewsInfoViewController = [[PictureNewsInfoViewController alloc] initWithNewsID:logID infoID:messgeID];
                pictureNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:pictureNewsInfoViewController animated:YES];
            }
                break;
            case 3:{
                //视频新闻
                VideoNewsInfoViewController *videoNewsInfoViewController = [[VideoNewsInfoViewController alloc] initWithNewsID:logID newsImage:newsImage infoID:messgeID];
                videoNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:videoNewsInfoViewController animated:YES];
            }
                break;
            case 4:{
                //打赏申请推送
                if ([UserInfoEngine getUserInfo].userType == 1) {
                    //商家打赏申请
                    MerchantsRewardApplyViewController *merchantsRewardApplyViewController = [[MerchantsRewardApplyViewController alloc] initWithInfoID:messgeID];
                    merchantsRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:merchantsRewardApplyViewController animated:YES];
                }else{
                    //供货商打赏申请
                    SupplierRewardApplyViewController *supplierRewardApplyViewController = [[SupplierRewardApplyViewController alloc] initWithInfoID:messgeID];
                    supplierRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:supplierRewardApplyViewController animated:YES];
                }
            }
                break;
            default:
                break;
        }
    }else{
        UINavigationController *userCenterNav = tabController.viewControllers[tabController.selectedIndex];
        switch (pushType) {
            case 0:{
                WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithMessageID:messgeID WkWebType:WKWebTypeWithMessage MessageTitle:title successed:^(NSInteger messageID) {
                    
                }];
                wkWebViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:wkWebViewController animated:YES];
            }
                break;
            case 1:{
                //新闻
                NewsInfoViewController *newsInfoViewController = [[NewsInfoViewController alloc] initWithUrl:nil newsID:logID infoID:messgeID];
                newsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:newsInfoViewController animated:YES];
            }
                break;
            case 2:{
                //组图新闻
                PictureNewsInfoViewController *pictureNewsInfoViewController = [[PictureNewsInfoViewController alloc] initWithNewsID:logID infoID:messgeID];
                pictureNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:pictureNewsInfoViewController animated:YES];
            }
                break;
            case 3:{
                //视频新闻
                VideoNewsInfoViewController *videoNewsInfoViewController = [[VideoNewsInfoViewController alloc] initWithNewsID:logID newsImage:newsImage infoID:messgeID];
                videoNewsInfoViewController.hidesBottomBarWhenPushed=YES;
                [userCenterNav pushViewController:videoNewsInfoViewController animated:YES];
            }
                break;
            case 4:{
                //打赏申请推送
                if ([UserInfoEngine getUserInfo].userType == 1) {
                    //商家打赏申请
                    MerchantsRewardApplyViewController *merchantsRewardApplyViewController = [[MerchantsRewardApplyViewController alloc] init];
                    merchantsRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:merchantsRewardApplyViewController animated:YES];
                }else{
                    //供货商打赏申请
                    SupplierRewardApplyViewController *supplierRewardApplyViewController = [[SupplierRewardApplyViewController alloc] init];
                    supplierRewardApplyViewController.hidesBottomBarWhenPushed=YES;
                    [userCenterNav pushViewController:supplierRewardApplyViewController animated:YES];
                }
            }
                break;
            default:
                break;
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    //检查版本更新
    [self getCheckSoftVersionInfo];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL canOpen = NO;
    NSString *str = [url absoluteString];
    if ([str rangeOfString:[GlobalFile aliScheme]].length) {
        //支付宝
        [PayHelper handParsePay:url type:PayWayTypeAliPay application:application];
        canOpen = YES;
    } else if ([str rangeOfString:[[GlobalFile wxAppID] stringByAppendingString:@"://pay"]].length) {
        //微信
        [PayHelper handParsePay:url type:PayWayTypeWXPay application:application];
        canOpen = YES;
    } else {
        //分享
        NSDictionary *dictKey = [NSDictionary dictionaryWithObjectsAndKeys:@"wxf9cc80629c29ac0f", @"wxid", @"wb3910860466", @"sinaweibokey", nil];
        canOpen = [[HHSoftShareTool sharedHHSoftShareTool] hhsoftShareOpenURL:url key:dictKey];
    }
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canOpen = NO;
    NSString *str = [url absoluteString];
    if ([str rangeOfString:[GlobalFile aliScheme]].length) {
        //支付宝
        [PayHelper handParsePay:url type:PayWayTypeAliPay application:application];
        canOpen = YES;
    } else if ([str rangeOfString:[[GlobalFile wxAppID] stringByAppendingString:@"://pay"]].length) {
        //微信
        [PayHelper handParsePay:url type:PayWayTypeWXPay application:application];
        canOpen = YES;
    } else {
        //分享
        NSDictionary *dictKey = [NSDictionary dictionaryWithObjectsAndKeys:@"wxf9cc80629c29ac0f", @"wxid", @"wb3910860466", @"sinaweibokey", nil];
        canOpen = [[HHSoftShareTool sharedHHSoftShareTool] hhsoftShareOpenURL:url key:dictKey];
    }
    return canOpen;
}
#ifdef __IPHONE_9_0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    BOOL canOpen = NO;
    NSString *str = [url absoluteString];
    if ([str rangeOfString:[GlobalFile aliScheme]].length) {
        //支付宝
        [PayHelper handParsePay:url type:PayWayTypeAliPay application:app];
        canOpen = YES;
    } else if ([str rangeOfString:[[GlobalFile wxAppID] stringByAppendingString:@"://pay"]].length) {
        //微信
        [PayHelper handParsePay:url type:PayWayTypeWXPay application:app];
        canOpen = YES;
    } else {
        //分享
        NSDictionary *dictKey = [NSDictionary dictionaryWithObjectsAndKeys:@"wxf9cc80629c29ac0f", @"wxid", @"wb3910860466", @"sinaweibokey", nil];
        canOpen = [[HHSoftShareTool sharedHHSoftShareTool] hhsoftShareOpenURL:url key:dictKey];
    }
    return canOpen;
}
#endif
- (void)onResp:(BaseResp*)resp {
    [PayHelper wxPaySuccessWithOnResp:resp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
